require("alpha2303.keymaps")
require("alpha2303.autocmds")

-- Load the main configurations
vim.opt.number = true
vim.opt.relativenumber = true
vim.keymap.set("n", "<leader>n", function()
  vim.opt.number = not vim.opt.number:get()
  vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, { desc = "Toggle line numbers" })

print("Loaded configs: /alpha2303")
