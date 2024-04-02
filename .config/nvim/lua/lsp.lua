-- lsp config
local remap_opts = { noremap=true }
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, remap_opts)
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, remap_opts)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next, remap_opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, remap_opts)

local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
  vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, bufopts)
end

local lang_servers = {'clangd', 'tsserver', 'gopls', 'marksman', 'taplo', 'yamlls'}
for _, lang in ipairs(lang_servers) do
  require('lspconfig')[lang].setup{
      on_attach = on_attach,
      capabilities = capabilities,
  }
end

local rust_opts = {
  tools = {
    executor = require("rust-tools/executors").termopen,
    on_initialized = nil,
    reload_workspace_from_cargo_toml = true,
    inlay_hits = {
      auto = true,
      only_current_line = false,
      show_parameter_hints = true,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
      max_len_align = false,
      right_align = false,
      highlight = "Comment",
    },
    hover_actions = {
      border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
      },
      auto_focus = false,
      hover_with_actions = true,
    },
  },
  server = {
    standalone = true,
    capabilities = capabilities,
    on_attach = function(_, bufnr)
      require('rust-tools').inlay_hints.set()
      require('rust-tools').inlay_hints.enable()
      on_attach(_, bufnr)
    end,
    settings = {
      cmd = {"/usr/local/bin/rust-analyzer"},
      ['rust-analyzer'] = {
        lens = {
          enable = true,
        },
        checkOnSave = {
          command = 'clippy'
        },
      },
    },
  },
  dap = {
    adaptor = {
      type = "exectuable",
      command = "lldb-vscode",
      name = "rt_lldb"
    }
  }
}

require('null-ls').setup()
require('eslint').setup()
require('rust-tools').setup(rust_opts)

require('lspconfig')['lua_ls'].setup{
  on_attach = on_attach,
  capabilites = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = {"vim", "use"},
         disable = {"lowercase-global"}
      },
    },
  },
}
