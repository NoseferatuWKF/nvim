return {
  -- Aesthetics
  "nvim-tree/nvim-web-devicons",

  -- Utils
  "nvim-lua/plenary.nvim",
  "christoomey/vim-tmux-navigator",
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
  
  -- show buffers as tabs
  { "ap/vim-buftabline",
    config = function()
      vim.g.buftabline_numbers = 2

      vim.keymap.set("n", "<C-n>", vim.cmd.bn)
      vim.keymap.set('n', '1<C-n>', '<Plug>BufTabLine.Go(1)')
      vim.keymap.set('n', '2<C-n>', '<Plug>BufTabLine.Go(2)')
      vim.keymap.set('n', '3<C-n>', '<Plug>BufTabLine.Go(3)')
      vim.keymap.set('n', '4<C-n>', '<Plug>BufTabLine.Go(4)')
      vim.keymap.set('n', '5<C-n>', '<Plug>BufTabLine.Go(5)')
      vim.keymap.set('n', '6<C-n>', '<Plug>BufTabLine.Go(6)')
      vim.keymap.set('n', '7<C-n>', '<Plug>BufTabLine.Go(7)')
      vim.keymap.set('n', '8<C-n>', '<Plug>BufTabLine.Go(8)')
      vim.keymap.set('n', '9<C-n>', '<Plug>BufTabLine.Go(9)')
      vim.keymap.set('n', '0<C-n>', '<Plug>BufTabLine.Go(10)')
      vim.keymap.set("n", "<C-p>", vim.cmd.bp)
    end
  },

  { "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false,
        },
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

  { "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = false,
      highlight = {
        keyword = "wide_fg"
      }
    }
  },
  { "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },

  -- Add indentation guides even on blank lines
  { "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
  },

  -- DIY plugins
  { "NoseferatuWKF/dijon.nvim",
    opts = {
      vault = "/home/noseferatu/athena",
    },
  },
}
