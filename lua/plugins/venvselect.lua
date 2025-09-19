return {
  "linux-cultist/venv-selector.nvim",
  dependencies = {
    "neovim/nvim-lspconfig",
    "nvim-telescope/telescope.nvim",
  },
  ft = "python", -- Load when opening Python files
  config = function()
	      require("venv-selector").setup({
      search = {
	-- You can add your own searches here.
	-- The default searches are shown below.
	"VIRTUAL_ENV",
	".venv",
	"venv",
	".env",
	"env",
	".virtualenvs",
	".pyenv",
      },
      picker = "telescope", -- "telescope" or "vim.ui.select"
	python_command = vim.fn.has("win32") == 1 and "py" or "python3", -- Python command to use to check if venv is valid
    })

    vim.keymap.set("n", "<leader>vs", "<cmd>VenvSelect<cr>", { desc = "Select VirtualEnv" })

  end,
}
