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
  ft = "python", -- Load when opening Python files
  config = function()
	  local rg_path = "C:\\ProgramData\\chocolatey\\bin\\rg.exe"
	  require("venv-selector").setup({
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
      backend = "manual",
      rg_command = "C:\\ProgramData\\chocolatey\\bin\\rg.exe",
      picker = "telescope", -- "telescope" or "vim.ui.select"
	python_command = vim.fn.has("win32") == 1 and "py" or "python3", -- Python command to use to check if venv is valid
    })

    vim.keymap.set("n", "<leader>vs", "<cmd>VenvSelect<cr>", { desc = "Select VirtualEnv" })

  end,
}
