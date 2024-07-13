-- Telescope
-- See `:help telescope.builtin`
local compact = require("telescope.themes").get_dropdown({
  previewer = false,
  layout_config = {
    width = 0.8,
    height = 0.8,
  }
})

vim.keymap.set("n", "<leader><space>", function()
  require("telescope.builtin").buffers(compact)
end, { desc = "Search current buffers" })

vim.keymap.set("n", "<leader>?", function()
  require("telescope.builtin").oldfiles(compact)
end, { desc = "[?] Find recently opened files" })

vim.keymap.set("n", "<leader>/", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require("telescope.builtin").current_buffer_fuzzy_find(compact)
end, { desc = "[/] Fuzzily search in current buffer" })

vim.keymap.set("n", "<leader>sd", function()
  require("telescope.builtin").diagnostics(compact)
end, { desc = "[S]earch [D]iagnostics" })

vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "[G]it [F]iles" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sm", require("telescope.builtin").marks, { desc = "[S]earch [M]arks" })

vim.keymap.set("n", "<leader>gg", function ()
  -- https://www.reddit.com/r/neovim/comments/106oz66/comment/j3imi3v/
  local git_dir = vim.fn.system(string.format("git -C %s rev-parse --show-toplevel", vim.fn.expand("%:p:h")))
  git_dir = string.gsub(git_dir, "\n", "")
  local opts = {
    cwd = git_dir,
  }
  require("telescope.builtin").live_grep(opts)
end, { desc = "[G]it [G]rep" })
