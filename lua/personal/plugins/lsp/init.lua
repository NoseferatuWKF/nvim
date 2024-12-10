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
        dependencies = "hrsh7th/cmp-nvim-lsp",
        config = function ()
          -- LSP settings.

          -- Setup mason so it can manage external tooling
          require("mason").setup({
            ui = {
              border = "rounded"
            },
          })

          -- This function gets run when an LSP connects to a particular buffer.
          local on_attach = function(_, bufnr)
            require("personal.plugins.lsp.remap")
            -- Create a command `:Format` local to the LSP buffer
            vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
              vim.lsp.buf.format()
            end, { desc = "Format current buffer with LSP" })
          end

          -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

          -- Ensure the servers above are installed
          local mason_lspconfig = require("mason-lspconfig")

          mason_lspconfig.setup_handlers {
            function(server_name)
              local lspconfig = require("lspconfig")
              lspconfig[server_name].setup {
                capabilities = capabilities,
                on_attach = on_attach,
              }
            end,
          }
        end
      },

      -- Useful status updates for LSP
      { "j-hui/fidget.nvim", 
        opts = {
          progress = {
            display = {
              done_icon = "",
            },
          }
        }
      },
    },
  },
}
