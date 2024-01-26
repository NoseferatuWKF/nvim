-- Netrw
vim.keymap.set("n", "<leader>nt", vim.cmd.Ex, { desc = "[N]e[T]rw" })

-- Buffers
vim.keymap.set("n", "<C-x>", vim.cmd.bd)
vim.keymap.set("n", "<C-n>", function()
  if vim.v.count > 0 then
    return vim.cmd.b(vim.v.count)
  else
    return vim.cmd.bn()
  end
end, { desc = "[N]ext buffer" })

vim.keymap.set("n", "<C-p>", function()
  if vim.v.count > 0 then
    return vim.cmd.b(vim.v.count)
  else
    return vim.cmd.bp()
  end
end, { desc = "[P]rev buffer" })

-- moving lines
vim.keymap.set("v", "J", function()
  local i = vim.v.count > 0 and vim.v.count or 1
  return "m`" .. ":m '>+" .. i .. "<CR>gv=gv"
end, { expr = true })

vim.keymap.set("v", "K", function()
  local i = vim.v.count > 0 and vim.v.count + 1 or 2
  return "m`" .. ":m '<-" .. i .. "<CR>gv=gv"
end, { expr = true })

-- replace word on cursor
vim.keymap.set("n", "<leader>sU", [[:1, . s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Cursor Replace Word - Upwards" })
vim.keymap.set("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Cursor Replace Word - All" })
vim.keymap.set("n", "<leader>sD", [[:., $ s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Cursor Replace Word - Downwards" })

-- Notorious keybinds from ThePrimeagen
-- removing disorientation
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "Yank into system clipboard"})
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Immutable Paste"})
vim.keymap.set("n", "Q", "<nop>")

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Terminal mode
vim.keymap.set("t", "<esc>", "<C-\\><C-n>")

-- edit config from anywhere while in vim
vim.keymap.set("n", "<leader>con", function()
  vim.cmd.edit("~/AppData/Local/nvim/init.lua")
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
-- vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Error list" })
