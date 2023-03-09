return {
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
}
