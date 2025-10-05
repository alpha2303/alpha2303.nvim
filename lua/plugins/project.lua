return {
    "ahmedkhalf/project.nvim",
    config = function()
        require("project_nvim").setup({
            detection_methods = { "pattern" },
            patterns = { ".git", "pyproject.toml", "package.json", "cargo.toml" },
        })
        require("telescope").load_extension("projects")
        vim.keymap.set("n", "<leader>fp", "<cmd>Telescope projects<cr>")
    end,
}
