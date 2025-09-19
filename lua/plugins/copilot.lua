return {
	"github/copilot.vim",
	branch = "release",
	config = function()
    	
		-- Optional: disable copilot by default and enable per filetype
    		vim.g.copilot_filetypes = {
      			["*"] = true,     -- enable for all filetypes
      			-- ["markdown"] = false, -- example: disable for markdown
    		}

    		-- Example keymap to accept suggestion with Ctrl+J
    		vim.cmd [[
      			imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
    		]]
		vim.g.copilot_no_tab_map = true
	end,
}
