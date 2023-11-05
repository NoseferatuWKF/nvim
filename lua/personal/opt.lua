-- [[ Setting options ]]
-- See `:help vim.o`
-- Set highlight on search
vim.o.hlsearch = false
-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true
-- Indentation
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.wrap = false
vim.o.scrolloff = 10
-- vim.o.colorcolumn = "80"
-- Enable mouse mode
vim.o.mouse = 'a'
-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'
-- Enable break indent
vim.o.breakindent = true
-- Save undo history
vim.o.undofile = true
-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'
-- Decrease update time
vim.o.updatetime = 50
vim.o.timeout = true
vim.o.timeoutlen = 300
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
-- Show horizontal line on cursor so that you are not lost
vim.o.cursorline = true
-- Single status line for all splits
vim.o.laststatus = 3

-- Diagnostic signcolumn
-- set signcolumn=auto:4 to avoid adding stuff on top of each other refer :h signcolumn
local signs = {Error = '', Warn = '', Info = '', Hint = '󰌵',}
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl })
end

-- Hover float windows borders
-- h nvim_open_win
local _border = "rounded"

-- h lsp
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = _border
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = _border
  }
)

-- h vim.diagnostic.config()
vim.diagnostic.config({
  float = { border = _border }
})

-- h lspconfig-highlight
require("lspconfig.ui.windows").default_options.border = _border

-- h mason-settings
require("mason").setup({
    ui = {
        border = _border
    }
})

--  h lazy.nvim-lazy.nvim-configuration
require("lazy.core.config").defaults.ui.border = _border
