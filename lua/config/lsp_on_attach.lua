-- lua/config/lsp_on_attach.lua
-- This file contains the shared on_attach function for all LSP servers.

return function(client, bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }

    -- Keymaps are defined here
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
end
