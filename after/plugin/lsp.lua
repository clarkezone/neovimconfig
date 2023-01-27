-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local lsp = require('lsp-zero')
lsp.preset('recommended')
lsp.ensure_installed( {
'sumneko_lua',
'rust_analyzer'
})

local cmp = require("cmp")
local cmp_select = {behavior = cmp.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
['<C-p'] = cmp.mapping.select_prev_item(cmp_select),
['<C-Space'] = cmp.mapping.complete(),
})

-- lsp.setup.cmp_mappings(cmp_mappings)
lsp.setup_nvim_cmp({
 mapping = cmp_mappings
})

-- autocmd BufWritePre *.go vim.lsp.buf.format { async = true }

-- if client.resolved_capabilities.document_formatting then
-- 	buf_set_keymap("n", "ff", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
-- end

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()
