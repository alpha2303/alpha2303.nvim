return {
  {
    "sainnhe/everforest",
    lazy = false,      -- load immediately
    priority = 1000,   -- ensure it loads before other plugins
    config = function()
      -- optional: set theme style before loading
      vim.g.everforest_background = "hard"  -- options: 'hard', 'medium', 'soft'
      vim.g.everforest_enable_italic = 1
      vim.g.everforest_better_performance = 1
      vim.g.everforest_disable_italic_comment = 0
      vim.g.everforest_diagnostic_text_highlight = 1
      vim.g.everforest_diagnostic_line_highlight = 1
      vim.g.everforest_current_word = "bold"

      -- load colorscheme
      vim.cmd.colorscheme("everforest")
    end,
  },
}
