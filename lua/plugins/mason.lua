local vim = vim
return {
  -- Mason package manager
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  -- Mason + lspconfig integration
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local mason_lsp = require("mason-lspconfig")
      mason_lsp.setup({
        ensure_installed = { "ruff", "eslint", "prettierd", "lua_ls", "bashls", "gopls", "html", "cssls", "jsonls", "yamlls", "taplo", "marksman" }, -- add your servers
      })

      vim.lsp.config("lua_ls", {
	settings = {
	  Lua = {
	    diagnostics = {
	      globals = { "vim" },
	    },
	    workspace = {
	      library = vim.api.nvim_get_runtime_file("", true),
	      checkThirdParty = false,
	    },
	    telemetry = { enable = false },
	  },
	},
      })

      for _ , server in pairs(mason_lsp.get_installed_servers()) do
        vim.lsp.config(server, {})
      end
    end,
  },
}

