-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"nvim-telescope/telescope.nvim",
		tag = "v0.2.1",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>pf", function()
				builtin.find_files({})
			end, {})
			vim.keymap.set("n", "<leader>ph", function()
				builtin.find_files({ hidden = true })
			end, {})
			vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "[?] Find recently opened files" })
			vim.keymap.set("n", "<leader><space>", builtin.buffers, { desc = "[ ] Find existing buffers" })
			vim.keymap.set("n", "<leader>/", function()
				require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer]" })
			vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>ps", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>pc", function()
				require("telescope.builtin").find_files({ cwd = vim.fn.expand("%:p:h") })
			end, { desc = "fuzzily search in current dir" })
		end,
	},

	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false,
		priority = 1000,
		config = function()
			require("rose-pine").setup()
			vim.cmd("colorscheme rose-pine")
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				ensure_installed = { "lua", "vim", "vimdoc", "query", "python", "javascript", "typescript", "rust", "go", "c", "cpp", "bash", "html", "css", "json", "yaml", "toml", "markdown" },
				auto_install = true,
			})
			-- Highlighting is now built into Neovim via vim.treesitter.start()
			-- Enable it for all filetypes that have a treesitter parser
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
				end,
			})
		end,
	},

	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			harpoon:setup()

			vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
			vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
			vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
			vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
			vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
			vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
		end,
	},

	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end,
	},

	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
		end,
	},

	{ "wakatime/vim-wakatime" },

	{ "mfussenegger/nvim-dap" },
	{ "theHamsta/nvim-dap-virtual-text" },
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
	},

	-- LSP: mason for server installation, native Neovim 0.11 LSP for config
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim", "neovim/nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup({
				automatic_enable = true,
			})
		end,
	},
	{ "neovim/nvim-lspconfig" },

	-- Completion: blink.cmp
	{
		"saghen/blink.cmp",
		version = "1.*",
		dependencies = { "rafamadriz/friendly-snippets" },
		opts = {
			keymap = {
				preset = "default",
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-Space>"] = { "show" },
			},
			completion = {
				documentation = { auto_show = true },
				trigger = {
					show_on_trigger_character = true,
				},
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				providers = {
					lsp = {
						-- Trigger completion on '.' for LSP servers that don't advertise it
						override_trigger_characters = { "." },
					},
				},
			},
		},
	},

	-- Mojo LSP (ships with Mojo SDK, not available in Mason)
	{
		"neovim/nvim-lspconfig",
		name = "mojo-lsp-setup",
		config = function()
			if vim.fn.executable("mojo-lsp-server") == 1 then
				vim.lsp.config("mojo", {
					cmd = { "mojo-lsp-server" },
					filetypes = { "mojo" },
					root_markers = { "mojoproject.toml", ".git" },
				})
				vim.lsp.enable("mojo")
			end
		end,
	},

	{ "nvim-tree/nvim-web-devicons" },
})
