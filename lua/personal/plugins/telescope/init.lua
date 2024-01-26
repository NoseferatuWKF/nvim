return {
  -- Fuzzy Finder (files, lsp, etc)
  { "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim" },
    init = function ()
      require("personal.plugins.telescope.remap")
    end,
    opts = {
      defaults = {
        path_display = {
          truncate = 3,
        },
        layout_strategy = "flex",
        layout_config = {
          horizontal = {
            preview_cutoff = 0,
            preview_width = 0.75,
          },
        },
        file_ignore_patterns = {
          -- "App_Config",
          -- "picklesdoc",
          -- "Images",
          -- "lib",
          -- "Styles",
          -- "*.zip",
          -- "*.gif",
          -- "*.svg",
          -- "*.csv",
          -- "*.ttf",
          -- "XeroCertificate",
        },
      },
      config = function()
        -- Enable telescope fzf native, if installed
        pcall(require("telescope").load_extension, "fzf")
      end
    },
  },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = "make",
    cond = function()
      return vim.fn.executable "make" == 1
    end,
  },
}
