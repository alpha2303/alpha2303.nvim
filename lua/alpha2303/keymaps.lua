print("Loading alpha2303.remap")

local cwd = vim.fn.getcwd()

vim.g.mapleader = " "

-- Open netrw file explorer
vim.keymap.set("n", "<leader>rw", vim.cmd.Ex)

-- Open neovim config folder
vim.keymap.set("n", "<leader>cf", function()
    vim.cmd.Ex(vim.fn.stdpath("config"))
end)

-- Open current working directory
vim.keymap.set("n", "<leader>cd", function()
	vim.cmd.Ex(cwd)
end)

-- Terminal mappings
vim.keymap.set("n", "<leader>tp", ":terminal powershell<CR>", { desc = "Open Powershell Terminal" })

-- Set up gitbash keymap, if available
local gitbash_path = "C:\\Program Files\\Git\\bin\\bash.exe"
if (vim.uv or vim.loop).fs_stat(gitbash_path) then
	vim.keymap.set("n", "<leader>tg", function()
		vim.cmd('botright split | terminal ' .. vim.fn.shellescape(gitbash_path))
		vim.cmd("resize 15")
	end, { desc = "Open Git Bash Terminal" })
else
	print("Gitbash not detected at '" .. gitbash_path .. "'. Skipping keymaps...")
end

-- Diagnostics keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show Diagnostics" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to Previous Diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to Next Diagnostic" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Set Location List" })

print("Loaded configs: alpha2303.remap")
