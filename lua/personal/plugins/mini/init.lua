return {
  { "echasnovski/mini.ai", version = false, 
    config = function()
      require("mini.ai").setup()
    end
  },
  { "echasnovski/mini.pairs", version = false, 
    config = function()
      require("mini.pairs").setup()
    end
  },
  { "echasnovski/mini.surround", version = false,
    config = function()
      require("mini.surround").setup()
    end
  },
  { "echasnovski/mini.comment", version = false, 
    config = function()
      require("mini.comment").setup()
    end
  },
}
