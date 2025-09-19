return {
  "mbbill/undotree",
  config = function()
    -- Optional: automatically open the undo tree with a keymap
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Toggle UndoTree" })
  end,
}

