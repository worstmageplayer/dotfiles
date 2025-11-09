return {
  'neovim/nvim-lspconfig',
  dependencies = { 'saghen/blink.cmp' },
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },

  opts = {
    servers = {
      lua_ls = {
        on_init = function(client, _)
          local path = vim.fn.getcwd()
          if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
            return
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = { vim.env.VIMRUNTIME },
            },
          })
        end,
        settings = { Lua = {} },
      },

      pyright = {},
      ts_ls = {},
      clangd = {},

      rust_analyzer = {
        capabilities = require('blink.cmp').get_lsp_capabilities(),
        settings = {
          ['rust-analyzer'] = {
            check = { command = 'clippy' },
            cargo = { allFeatures = true },
            procMacro = { enable = true },
          },
        },
        root_dir = vim.fs.find({ 'Cargo.toml' }, { upward = true })[1] or vim.loop.cwd(),
      },
    },
  },

  config = function(_, opts)
    for server, config in pairs(opts.servers) do
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      vim.lsp.config(server, config)
      vim.lsp.enable(server)
    end
  end,
}
