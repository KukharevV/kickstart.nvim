-- Toggle between dark and light theme
vim.keymap.set('n', '<leader>tt', function()
  if vim.o.background == 'dark' then
    vim.o.background = 'light'
  else
    vim.o.background = 'dark'
  end
  print('Switched to ' .. vim.o.background .. ' mode')
end, { desc = 'Toggle between dark and light mode' })

-- Netrw :Ex shortcut
vim.keymap.set('n', '<leader>pr', ':Ex<CR>', { desc = 'Open netrw' })
