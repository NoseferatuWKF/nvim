local au_group = vim.api.nvim_create_augroup("Razor", { clear = false })
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*.razor',
    callback = function()
        -- BUG: it seems to crash when setting this to html? suspecting it is treesitter issue
        vim.o.filetype = 'xml'
    end,
    group = au_group,
})
