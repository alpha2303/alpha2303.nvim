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
				file_ignore_patterns = {".git", "node_modules", "__pycache__", ".lock", ".venv/", "build/", "dist/" },
				buffer_previewer_maker = function(filepath, bufnr, opts)
					local ft = vim.fn.fnamemodify(filepath, ":e")
					local ok, ts_utils = pcall(require, "telescope.previewers.utils")
					if ok and vim.fn.has("nvim-0.9") == 1 then
						local has_ts, _ = pcall(require, "nvim-treesitter.parsers")
						if has_ts then
							ts_utils.buffer_previewer_maker(filepath, bufnr, opts)
							return
						end
					end

					-- fallback to default parser
					require("telescope.previewers").buffer_previewer_maker(filepath, bufnr, opts)
				end,	
			},
		}
		pcall(telescope.load_extension, "fzf")
		pcall(telescope.load_extension, "git_worktree")
		pcall(telescope.load_extension, "git_status")
		pcall(telescope.load_extension, "git_commits")
		pcall(telescope.load_extension, "venv_selector")

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
