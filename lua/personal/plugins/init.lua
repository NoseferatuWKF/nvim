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
  "windwp/nvim-ts-autotag",
  "christoomey/vim-tmux-navigator",
  "ap/vim-buftabline",
  "mbbill/undotree",

  { "windwp/nvim-autopairs", opts = {} },
  -- "gc" to comment visual regions/lines
  { "numToStr/Comment.nvim", opts = {} },
  -- Useful plugin to show you pending keybinds.
  { "folke/which-key.nvim",  opts = {} },

  {
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      show_trailing_blankline_indent = false,
    },
  },

}
