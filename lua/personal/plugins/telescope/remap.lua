-- See `:h telescope.actions`
local actions = require("telescope.actions")
local compact = {
  attach_mappings = function(_, map)
    map({"i", "n"}, "<C-a>", actions.select_all)
    map({"i", "n"}, "<C-x>", actions.delete_buffer)
    return true
  end,
  previewer = false,
}
local extension = {
  attach_mappings = function(_, map)
    map({"i", "n"}, "<C-a>", actions.select_all)
    map({"i", "n"}, "<C-q>", actions.send_selected_to_qflist + actions.open_qflist)
    return true
  end,
}

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader><space>", function()
  require("telescope.builtin").buffers(compact)
end, { desc = "Search current buffers" })

vim.keymap.set("n", "<leader>?", function()
  require("telescope.builtin").oldfiles(compact)
end, { desc = "[?] Find recently opened files" })

vim.keymap.set("n", "<leader>/", function()
  require("telescope.builtin").current_buffer_fuzzy_find(compact)
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>sd", function()
  require("telescope.builtin").diagnostics(compact)
end, { desc = "[S]earch [D]iagnostics" })

vim.keymap.set("n", "<leader>sf", function()
  require("telescope.builtin").find_files(extension)
end, { desc = "[S]earch [F]iles" })

vim.keymap.set("n", "<leader>gf", function()
  require("telescope.builtin").git_files(extension)
end, { desc = "[G]it [F]iles" })

vim.keymap.set("n", "<leader>sm", function()
  require("telescope.builtin").marks(extension)
end, { desc = "[S]earch [M]arks" })

vim.keymap.set("n", "<leader>sw", function()
  require("telescope.builtin").grep_string(extension)
end, { desc = "[S]earch current [W]ord" })

vim.keymap.set("n", "<leader>sg", function()
  require("telescope.builtin").live_grep(extension)
end, { desc = "[S]earch by [G]rep" })

vim.keymap.set("n", "<leader>sh", function()
  require("telescope.builtin").help_tags(extension)
end, { desc = "[S]earch [H]elp" })

vim.keymap.set("n", "<leader>gg", function ()
  -- https://www.reddit.com/r/neovim/comments/106oz66/comment/j3imi3v/
  local git_dir = vim.fn.system(string.format("git -C %s rev-parse --show-toplevel", vim.fn.expand("%:p:h")))
  git_dir = string.gsub(git_dir, "\n", "")
  local opts = vim.tbl_extend("keep", extension, { cwd = git_dir })
  require("telescope.builtin").live_grep(opts)
end, { desc = "[G]it [G]rep" })
