local vim = vim

local NEOTREE_SOURCES = { "filesystem", "git_status" }

local get_current_source_info = function(nt_state)
	local current_source = {}
	for _, src in ipairs(NEOTREE_SOURCES) do
		if nt_state and nt_state.winid and vim.api.nvim_win_is_valid(nt_state.winid) then
			local win_buf = vim.api.nvim_win_get_buf(nt_state.winid)
			local cur_win = vim.api.nvim_get_current_win()
			local cur_buf = vim.api.nvim_get_current_buf()

			if vim.api.nvim_buf_is_valid(win_buf) then
				current_source = { name = src, is_focused = false }
				if win_buf == cur_buf and cur_win == nt_state.winid then
					current_source.is_focused = true
				end
			end
			break
		end
	end

	return current_source
end

local toggle_neovim = function(source)
	local ok, nt_manager = pcall(require, "neo-tree.sources.manager")
	if not ok then
		vim.notify("Neo-tree not available", vim.log.levels.ERROR)
		return nil
	end

	local state = nt_manager.get_state(source)

	local current_source = get_current_source_info(state)

	-- Neotree closed → open with requested source
	if not current_source.name then
		vim.cmd("Neotree " .. source .. " left")
		return
	end

	-- Neotree open with same source → close it
	if current_source.name == source and current_source.is_focused then
		vim.cmd("Neotree close")
		return
	end

	-- Neotree open with different source → switch source
	if source == "filesystem" then
		vim.cmd("Neotree reveal left")
	else
		vim.cmd("Neotree focus " .. source .. " left")
	end
end

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
			local ok, neo_tree = pcall(require, "neo-tree")
			if not ok or type(neo_tree) ~= "table" or type(neo_tree.setup) ~= "function" then
				return
			end

			neo_tree.setup({
				close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
				popup_border_style = "rounded",
				sources = { "filesystem", "git_status" },
				source_selector = {
					winbar = true,
					statusline = false,
				},
				window = {
					position = "left",
					width = 35,
				},
				filesystem = {
					follow_current_file = true,
					hijack_netrw_behavior = "open_default",
					use_libuv_file_watcher = true,
					filtered_items = {
						visible = true, -- show hidden files
						hide_dotfiles = false,
						hide_gitignored = false,
					},
				},
			})

			vim.keymap.set("n", "<leader>ef", function() toggle_neovim("filesystem") end,
				{ desc = "Toggle File Explorer" })
			vim.keymap.set("n", "<leader>eg", function() toggle_neovim("git_status") end,
				{ desc = "Toggle Git Status" })
			vim.keymap.set("n", "<leader>ee", "<C-w>l", { desc = "Focus editor from NeoTree" })
		end,
	}
}
