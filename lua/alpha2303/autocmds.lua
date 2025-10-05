local vim = vim
local autosave_group = vim.api.nvim_create_augroup("autosave", { clear = true })

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    group = autosave_group,
    pattern = "*",
    callback = function()
        if vim.bo.modifiable and vim.bo.buftype == "" then
            vim.cmd("silent! write")
        end
    end,
})
