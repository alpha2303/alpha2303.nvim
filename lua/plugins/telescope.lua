local vim = vim

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = nil,
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},
	config = function()
		local telescope = require("telescope")
		telescope.setup {
			defaults = {
				layout_strategy = "vertical",
				layout_config = { height = 0.9, width = 0.9, prompt_position = "top" },
				file_ignore_patterns = { ".git", "node_modules", "__pycache__", ".vscode/", "build/", "dist/" },
				buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker
			},
		}
		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "git_worktree")
		pcall(telescope.load_extension, "git_status")
		pcall(telescope.load_extension, "git_commits")

		local builtin = require("telescope.builtin")
		vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "Find files" })
		vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "Search text" })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "List buffers" })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "Help tags" })
		vim.keymap.set("n", "<leader>fc", builtin.commands, { desc = "Fuzzy search all commands" })
		vim.keymap.set("n", "<leader>ld", builtin.lsp_definitions, { desc = "Go to Definition" })
		vim.keymap.set("n", "<leader>lr", builtin.lsp_references, { desc = "References" })
	end,
}
