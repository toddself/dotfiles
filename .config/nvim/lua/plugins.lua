-- ensure packer
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
boostrap_packer = false

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  execute 'packadd packer.nvim'
  bootstrap_packer = true
end

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "plugins.lua",
  command = "source <afile> | PackerCompile",
})

require('packer').init({display = {auto_clean = false}})

return require('packer').startup(function(use)
  local lua_path = function(name)
    return string.format("require'plugins.%s'", name)
  end

  use 'wbthomason/packer.nvim'

  -- lsp
  use { 'williamboman/mason.nvim', config = lua_path'mason' }
  use { 'williamboman/mason-lspconfig.nvim', config = lua_path'mason-lspconfig' }
  use 'neovim/nvim-lspconfig'
  use 'onsails/lspkind-nvim'
  use 'MunifTanjim/eslint.nvim'
  use 'jose-elias-alvarez/null-ls.nvim'

  -- make nvim a little easier to use
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
  use 'mbbill/undotree'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'

  -- theme
  use { 'dracula/vim', as = 'dracula' }

  -- language support
  use 'simrat39/rust-tools.nvim'
  use 'sheerun/vim-polyglot'
  use { 'mhartington/formatter.nvim', cmd = {"Format", "FormatWrite"}, config = lua_path'formatter' }
  use 'ron-rs/ron.vim'
  use 'github/copilot.vim'

  -- completeions
  use 'hrsh7th/cmp-path'
  use 'L3MON4D3/luasnip'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-nvim-lsp'
  use { 'hrsh7th/nvim-cmp', config = function ()
    local has_words_before = function()
      local line, col = table.unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    local cmp = require('cmp')
    cmp.setup({
      sources = {
        { name = 'nvim_lsp' },
        { name = 'path' },
        { name = 'luasnip' },
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      mapping = {
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<Right>'] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select}), {'i'}),
        ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select}), {'i'}),
        ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select}), {'i'}),
        ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select}), {'i'}),
      },
    })
    end
  }

  -- treesitter
  use { 'David-Kunz/markid' }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = lua_path'treesitter' }
  use { 'lukas-reineke/indent-blankline.nvim', config = lua_path'indent-blankline' }


  -- icons and statusbar
  use { 'kyazdani42/nvim-web-devicons', config = function() require('nvim-web-devicons').setup() end }
  use 'nvim-lua/plenary.nvim'
  use 'mfussenegger/nvim-dap'
  use { 'lewis6991/gitsigns.nvim', config = function() require('gitsigns').setup() end }
  use 'feline-nvim/feline.nvim'

  if bootstrap_packer then
    require('packer').sync()
  end
end)
