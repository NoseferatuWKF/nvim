return {
    "nikolvs/vim-sunbather",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd([[colorscheme sunbather]])
        vim.api.nvim_set_hl(0, 'WinSeparator', {fg = "None"})
    end,
}
