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
vim .keymap.set("n", "<leader>cd", function()
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

-- Set up telescope keymaps, if available
local ok, telescope = pcall(require, "telescope")
if not ok then
	print("Telescope not installed. Skipping keymaps...")
else
	local builtin = require("telescope.builtin")
	vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
	vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Search text" })
	vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "List buffers" })
	vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help tags" })
	vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Fuzzy search all commands" })
end

print("Loaded configs: alpha2303.remap")
