local M = {}

function M.setup()
  local capabilities = require('blink.cmp').get_lsp_capabilities()

  local servers = {
    terraformls = {},
    ts_ls = {},
    lua_ls = {
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
        },
      },
    },
    gh_actions_ls = {
      filetypes = { 'yaml.github' },
    },
  }

  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    'vale',
    'hadolint',
    'tflint',
    'jsonlint',
    'eslint',
    'stylua',
    'prettier'
  })

  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  require('mason-lspconfig').setup {
    ensure_installed = {},
    automatic_installation = false,
    handlers = {
      function(server_name)
        local server = servers[server_name] or {}
        server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
        require('lspconfig')[server_name].setup(server)
      end,
    },
  }
end

return M