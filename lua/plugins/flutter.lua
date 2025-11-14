-- lua/plugins/flutter.lua
return {
    {
        "nvim-flutter/flutter-tools.nvim",
        ft = { "dart" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "stevearc/dressing.nvim", -- optional for better UI
        },
        config = function()
            local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

            require("flutter-tools").setup({
                widget_guides = {
                    enabled = true,
                },
                lsp = {
                    capabilities = capabilities,
                    on_attach = function(client, bufnr)
                        -- Set your keymaps
                        local opts = { buffer = bufnr, noremap = true, silent = true }
                        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
                        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                    end,
                }
            })
        end,
    },
}
