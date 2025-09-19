return {{
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	branch = "main",
	config = function()
		require("nvim-treesitter").setup {
			highlight = { 
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true },
			ensure_installed = { "lua", "python", "javascript", "typescript", "html", "markdown", "markdown_inline", "yaml", "toml", "vim", "bash", "rust", "json" },
			sync_install = false,
			auto_install = true,
		}
	end,
}}

