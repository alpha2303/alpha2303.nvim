return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
      "folke/snacks.nvim",
    },
    lazy = false, -- neo-tree will lazily load itself
    config = function()
	    require("neo-tree").setup({
		    sources = { "filesystem", "git_status" },
		    source_selector = {
			    winbar = true,
			    statusline = false,
		    },
		    window = {
			    position = "left",
			    width = 30,
		    },
	    })

	    vim.keymap.set("n", "<leader>fe", ":Neotree toggle<CR>", { desc = "Toggle File Explorer" })
	    vim.keymap.set("n", "<leader>ge", ":Neotree git_status toggle<CR>", { desc = "Toggle Git Status" })
    end,
  }
}
