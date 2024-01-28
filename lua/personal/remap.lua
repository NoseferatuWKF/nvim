-- [[ Basic Keymaps ]]

-- Netrw
vim.keymap.set("n", "<leader>nt", vim.cmd.Ex, { desc = "[N]e[T]rw" })

-- UndoTree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "[U]ndo [T]ree"})

-- Notorious keybinds from ThePrimeagen
-- moving lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- removing disorientation
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "Yank into system clipboard"})
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Immutable Paste"})
vim.keymap.set("n", "Q", "<nop>")
-- replace word on cursor
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Cursor Replace Word" })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- edit config from anywhere while in vim
vim.keymap.set("n", "<leader>con", function()
  vim.cmd.edit("~/.dotfiles/nvim/.config/nvim/init.lua")
end, { desc = "Edit Neovim [CON]fig"})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Diagnostic keymaps
vim.keymap.set("n", "[e", vim.diagnostic.goto_prev, { desc = "Go to next error" })
vim.keymap.set("n", "]e", vim.diagnostic.goto_next, { desc = "Go to prev error" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Hover error" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Error list" })

