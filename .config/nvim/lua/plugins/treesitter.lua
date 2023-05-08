require('nvim-treesitter.configs').setup{
  markid = {
    enable = true,
    colors = false,
  },
  ensure_installed = 'all',
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = false
  },
  matchup = {
    enable = true
  }
}
