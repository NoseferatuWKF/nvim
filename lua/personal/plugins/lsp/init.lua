return {
  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      "williamboman/mason.nvim",
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "hrsh7th/cmp-nvim-lsp" },
        config = function ()
          -- LSP settings.
          --  This function gets run when an LSP connects to a particular buffer.
          local on_attach = function(_, bufnr)

            require("personal.plugins.lsp.remap")

            -- Create a command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
              vim.lsp.buf.format()
            end, { desc = "Format current buffer with LSP" })
          end

          -- Enable the following language servers
          --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
          --
          --  Add any additional override configuration in the following tables. They will be passed to
          --  the `settings` field of the server config. You must look up that documentation yourself.
          local servers = {
            -- clangd = {},
            -- gopls = {},
            -- pyright = {},
            rust_analyzer = {},
            tsserver = {},
            lua_ls = {
              Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
              },
            },
          }

          -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

          -- Setup mason so it can manage external tooling
          require("mason").setup()

          -- Ensure the servers above are installed
          local mason_lspconfig = require("mason-lspconfig")

          mason_lspconfig.setup {
            ensure_installed = vim.tbl_keys(servers),
          }

          mason_lspconfig.setup_handlers {
            function(server_name)
              local lspconfig = require("lspconfig")
              lspconfig[server_name].setup {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = servers[server_name],
              }
              lspconfig.jdtls.setup {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = servers[server_name],
                root_dir = lspconfig.util.root_pattern('.git')
              }
            end,
          }
        end
      },
      {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim"
        },
        init = function()
          local null_ls = require("null-ls")
          local sources = {
            null_ls.builtins.formatting.prettier,
            null_ls.builtins.formatting.stylua,
            null_ls.builtins.diagnostics.eslint,
            null_ls.builtins.completion.spell,
          }
        end,
      },
      {
        "jay-babu/mason-null-ls.nvim",
        dependencies = {
          "williamboman/mason.nvim",
          "jose-elias-alvarez/null-ls.nvim",
        },
        init = function ()
          local ensure_installed = {
            "prettier",
            "stylua",
            "eslint",
          }
        end,
      },

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require("fidget").setup({})`
      { "j-hui/fidget.nvim", opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      {"folke/neodev.nvim", opts = {} },
    },
  },
}
