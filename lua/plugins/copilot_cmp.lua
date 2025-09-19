return {
  "zbirenbaum/copilot-cmp",
  dependencies = {
    "github/copilot.vim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    require("copilot_cmp").setup()
  end,
}

