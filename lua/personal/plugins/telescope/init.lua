return {
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
        layout_strategy = "vertical",
        layout_config = {
          vertical = {
            preview_cutoff = 0,
            prompt_position = "top",
          },
        },
        file_ignore_patterns = {
          -- "App_Config",
          -- "picklesdoc",
          -- "Images",
          -- "lib",
          -- "Styles",
          "*.zip",
          "*.gif",
          "*.svg",
          -- "*.csv",
          -- "*.ttf",
          -- "XeroCertificate",
          "*.jmx",
          "Content",
          "*.cmd",
        },
      },
      config = function()
        pcall(require("telescope").load_extension, "fzf")
      end
    },
  },

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
