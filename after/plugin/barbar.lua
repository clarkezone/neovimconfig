 local map = vim.api.nvim_set_keymap
 local opts = { noremap = true, silent = true }

-- Move to previous/next
 map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
 map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)

 vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '*',
  callback = function()
    if vim.bo.filetype == 'NvimTree' then
      require'bufferline.api'.set_offset(31, 'FileTree')
    end
  end
})

vim.api.nvim_create_autocmd('BufWinLeave', {
  pattern = '*',
  callback = function()
    if vim.fn.expand('<afile>'):match('NvimTree') then
      require'bufferline.api'.set_offset(0)
    end
  end
})
