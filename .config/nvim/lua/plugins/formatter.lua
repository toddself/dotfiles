local ftypes = require('formatter.filetypes')

vim.api.nvim_set_keymap('n', '<leader>f', ':FormatWrite', {noremap=true})
vim.cmd[[
  augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost * FormatWrite
  augroup END
]]

require('formatter').setup{
  logging = true,
  log_level = vim.log.levels.TRACE,
  filetype = {
    go = {
      ftypes.go.goimports,
    },
    javascript = {
      ftypes.javascript.prettier,
    },
    json = {
      ftypes.json.jq,
    },
    lua = {
      ftypes.lua.stylua,
    },
    rust = {
      ftypes.rust.rustfmt,
    },
    sh = {
      ftypes.sh.shformat
    },
    toml = {
      ftypes.toml.taplo,
    },
    yaml = {
      ftypes.yaml.prettier,
    },
    zig = {
      ftypes.zig.zigfmt,
    },
    [''] = {
      ftypes.any.remove_trailing_whitespace
    },
  },
}
