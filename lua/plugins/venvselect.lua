local vim = vim

return {
	"linux-cultist/venv-selector.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"nvim-telescope/telescope.nvim",
	},
	event = "VeryLazy",
	opts = {
		name = "venv",
		auto_refresh = true, -- Refresh the virtualenv list on `VenvSelect` command
	},
	ft = "python",     -- Load when opening Python files
	config = function()
		local rg_path = "C:\\ProgramData\\chocolatey\\bin\\rg.exe"
		if vim.fn.filereadable(rg_path) == 0 then
			rg_path = "rg"
		end

		local ok, venv_selector = pcall(require, "venv-selector")
		venv_selector.setup({
			search = {
				backend = "rg",
				rg_command = rg_path,
				search_patterns = {
					-- You can add your own searches here.
					-- The default searches are shown below.
					"VIRTUAL_ENV",
					".venv",
					"venv",
					".env",
					"env",
					".virtualenvs",
					".pyenv",
				}
			},
			backend = "rg",
			picker = "telescope", -- "telescope" or "vim.ui.select"
			-- Python command to use to check if venv is valid
			python_command = vim.fn.has("win32") == 1 and "py" or "python3",
		})
		local ok_tel, telescope = pcall(require, "telescope")
		if ok_tel and type(telescope) == "table" and type(telescope.load_extension) == "function" then
			pcall(function() telescope.load_extension("venv_selector") end)
		end

		vim.keymap.set("n", "<leader>vs", "<cmd>VenvSelect<cr>", { desc = "Select VirtualEnv" })
	end,
}
