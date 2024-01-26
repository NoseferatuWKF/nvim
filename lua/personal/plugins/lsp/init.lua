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
        dependencies = { 
          "hrsh7th/cmp-nvim-lsp",
          "Hoffs/omnisharp-extended-lsp.nvim",
        },
        config = function ()
          -- LSP settings.
          -- This function gets run when an LSP connects to a particular buffer.
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
            -- rust_analyzer = {},
            -- tsserver = {},
            -- jdtls = {},
            -- lua_ls = {
            --   Lua = {
            --     workspace = { checkThirdParty = false },
            --     telemetry = { enable = false },
            --   },
            -- },
          }

          -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

          -- Setup mason so it can manage external tooling
          require("mason").setup({
            ui = {
              border = "rounded"
            }
          })

          -- Ensure the servers above are installed
          local mason_lspconfig = require("mason-lspconfig")

          -- h lspconfig-highlight
          require("lspconfig.ui.windows").default_options.border = "rounded"

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

              -- local omnisharp_exe = "C:/Users/Wan.WanAhmed/AppData/Local/nvim-data/mason/packages/omnisharp/libexec/Omnisharp.exe"
              local omnisharp_exe = "C:/omnisharp/Omnisharp.exe"
              local pid = vim.fn.getpid()
              lspconfig.omnisharp.setup {
                handlers = {
                  ["textDocument/definition"] = require('omnisharp_extended').handler,
                },
                capabilities = capabilities,
                on_attach = function (client, bufnr)
                  local fidget = require("fidget")
                  fidget.notify(" Finished setting up Omnisharp")
                  on_attach(client, bufnr)
                end,
                root_dir = lspconfig.util.find_git_ancestor,
                cmd = { omnisharp_exe, "--languageserver", '--hostPID', tostring(pid) },
              }
            end,
          }
        end
      },
      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require("fidget").setup({})`
      { "j-hui/fidget.nvim", opts = {
        progress = {
          display = {
            done_icon = "",
          },
        }
      }},

      -- Additional lua configuration, makes nvim stuff amazing!
      {"folke/neodev.nvim", opts = {} },
    },
  },
}
