-- https://github.com/ray-x/go.nvim
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
require('go').setup({
	lsp_cfg = {
		capabilities = capabilities,
	}
})

local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimport()
  end,
  group = format_sync_grp,
})

vim.keymap.set("n", "<leader>tf", vim.cmd.GoTestFunc)
