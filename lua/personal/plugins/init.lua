-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
return {
  "nvim-lua/plenary.nvim",

  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",

  -- Aesthetics
  "nvim-tree/nvim-web-devicons",

  -- Utils
  "tpope/vim-surround",
  "christoomey/vim-tmux-navigator",
  "ap/vim-buftabline",

  { "windwp/nvim-autopairs", opts = {} },

  -- "gc" to comment visual regions/lines
  { "numToStr/Comment.nvim", opts = {} },

  -- Useful plugin to show you pending keybinds.
  { "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  }, 

  { "mbbill/undotree",
    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },

  {
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      show_trailing_blankline_indent = false,
    },
  },

  -- DIY plugins
  {
    "NoseferatuWKF/dijon.nvim",
    opts = {
      vault = "/home/noseferatu/athena",
    },
  },
}
