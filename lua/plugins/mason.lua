local vim = vim
local lsp_configs = vim.lsp.config
local required_lsps = { "ruff", "eslint", "ts_ls", "lua_ls", "bashls", "gopls", "html", "cssls", "jsonls", "yamlls",
  "taplo", "marksman" } -- add your servers

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
    "neovim/nvim-lspconfig",
    config = function()
      local servers = required_lsps
      for _, s in ipairs(servers) do
        if lsp_configs[s] then
          pcall(lsp_configs[s].setup, {})
        else
          vim.notify("plugins.mason.nvim-lspconfig: LSP " .. s .. " is not supported by nvim-lspconfig",
            vim.log.levels.WARN)
        end
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      local ok_ml, mason_lsp = pcall(require, "mason-lspconfig")
      if not ok_ml then
        vim.notify("mason-lspconfig not available", vim.log.levels.WARN)
        return
      end

      mason_lsp.setup({
        ensure_installed = required_lsps,
      })

      if lsp_configs.lua_ls then
        pcall(lsp_configs.lua_ls.setup, {
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
      end

      for _, server in pairs(mason_lsp.get_installed_servers()) do
        if lsp_configs[server] then
          pcall(lsp_configs[server].setup, {})
        else
          vim.notify("plugins.mason.mason-lspconfig: installed server not available in lspconfig: " .. server,
            vim.log.levels.WARN)
        end
      end
    end,
  },
  -- Formatter
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    config = function()
      require("conform").setup({
        format_on_save = false,
        -- format_on_save = {
        --   timeout_ms = 3000,
        --   lsp_fallback = true,
        -- },
        formatters_by_ft = {
          python = { "ruff" },
          javascript = { "prettierd", "prettier" },
          typescript = { "prettierd", "prettier" },
          json = { "prettierd", "prettier" },
          yaml = { "yamlfmt", "prettier" },
          toml = { "taplo" },
          markdown = { "prettierd", "prettier" },
          html = { "prettierd", "prettier" },
          css = { "prettierd", "prettier" },
        },
      })
      vim.keymap.set({ "n", "v" }, "<leader>fm", function()
        require("conform").format({ async = true, lsp_fallback = true })
      end, { desc = "Format code" })
    end,
  },
}
