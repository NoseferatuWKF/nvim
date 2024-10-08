-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
return {
  -- Aesthetics
  "nvim-tree/nvim-web-devicons",

  -- Utils
  "nvim-lua/plenary.nvim",
  "christoomey/vim-tmux-navigator",
  
  -- show buffers as tabs
  { "ap/vim-buftabline",
    config = function()
      vim.g.buftabline_numbers = 1
    end
  },

  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",

  -- { "windwp/nvim-autopairs", opts = {} },
  { "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false,
        }
      })
    end,
  },

  { "mbbill/undotree",
    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "[U]ndo [T]ree" })
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
