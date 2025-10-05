local vim = vim
return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        event = "UIEnter",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local ok, bufferline = pcall(require, "bufferline")
            if not ok or type(bufferline) ~= "table" or type(bufferline.setup) ~= "function" then
                return
            end
            
            bufferline.setup({
                options = {
                    mode = "buffers", -- show open buffers (not tabs)
                    numbers = "none",
                    indicator = { icon = "▎", style = "icon" },
                    name_formatter = function(buf)
                        return vim.fn.fnamemodify(buf.name, ":t")
                    end,
                    separator_style = "slant", -- "thin" | "slant" | "padded_slant"
                    diagnostics = "nvim_lsp",
                    offsets = {
                        {
                            filetype = "neo-tree",
                            text = "File Explorer",
                            highlight = "Directory",
                            text_align = "left",
                            padding = 1,
                        },
                    },
                    show_buffer_icons = true,
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                    color_icons = true,
                    hover = {
                        enabled = true,
                        delay = 200,
                        reveal = { "close" },
                    },
                },
            })

            -- Keymaps (VSCode-like buffer navigation)
            vim.keymap.set("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
            vim.keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
            vim.keymap.set("n", "<leader>bd", ":bdelete<CR>!", { desc = "Close current buffer" })
            vim.keymap.set("n", "<leader>bp", ":BufferLinePick<CR>", { desc = "Pick buffer" })
        end,
    },
}
