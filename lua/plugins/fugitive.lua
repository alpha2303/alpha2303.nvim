return {
  "tpope/vim-fugitive",
  config = function()
    -- Optional keymaps
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "Git Status" })
    vim.keymap.set("n", "<leader>gd", vim.cmd.Gdiffsplit, { desc = "Git Diff Split" })
    vim.keymap.set("n", "<leader>gc", vim.cmd.Gcommit, { desc = "Git Commit" })
    vim.keymap.set("n", "<leader>gb", vim.cmd.Gblame, { desc = "Git Blame" })
    vim.keymap.set("n", "<leader>gp", vim.cmd.Gpush, { desc = "Git Push" })
    vim.keymap.set("n", "<leader>gl", vim.cmd.Glog, { desc = "Git Log" })
  end,
}

