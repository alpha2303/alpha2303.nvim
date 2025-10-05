return {
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("Comment").setup({
        ---Add any custom options here
        toggler = {
          line = "gcc",  -- Toggle current line
          block = "gbc", -- Toggle block comment
        },
        opleader = {
          line = "gc",
          block = "gb",
        },
        mappings = {
          basic = true,
          extra = true,
        },
      })

      -- VSCode-style keybinding: Ctrl + /
      vim.keymap.set("n", "<C-_>", "gcc", { remap = true, desc = "Toggle line comment" })
      vim.keymap.set("v", "<C-_>", "gc", { remap = true, desc = "Toggle selection comment" })
      -- Note: <C-_> is Ctrl + / (they map to the same code in Neovim)
    end,
  },
}

