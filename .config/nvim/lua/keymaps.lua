-- keymaps
local remap_opts = { noremap=true }
vim.api.nvim_set_keymap('n', '<leader>u', ':UndotreeToggle<cr>', remap_opts)
vim.api.nvim_set_keymap('n', '<leader><space>', ':nohlsearch<cr>', remap_opts)
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', remap_opts)
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', remap_opts)
vim.api.nvim_set_keymap('n', 'j', 'gj', remap_opts)
vim.api.nvim_set_keymap('n', 'k', 'gk', remap_opts)
vim.api.nvim_set_keymap('i', 'jk', '<esc>', remap_opts)
vim.api.nvim_set_keymap('n', '<leader>b', ':buffers<cr>:buffer<space>', remap_opts)
vim.api.nvim_set_keymap('n', '<C-p>', ':Files<cr>', remap_opts)
vim.api.nvim_set_keymap('n', '<leader>y', ':call system("nc -U ~/.clipper.sock", @0)<CR>', remap_opts)

