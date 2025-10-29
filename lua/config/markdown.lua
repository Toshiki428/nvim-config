vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.keymap.set("v", "<localleader>b", "c**<C-r>\"**<Esc>", {
            remap = true,
            buffer = true,
            desc = "Markdown 太字（**）"
        })
    end
})

