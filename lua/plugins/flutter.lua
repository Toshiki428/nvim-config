-- lua/plugins/flutter.lua
return {
    {
        "nvim-flutter/flutter-tools.nvim",
        ft = "dart",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "stevearc/dressing.nvim", -- optional for better UI
        },
        config = function()
            require("flutter-tools").setup({
                widget_guides = {
                    enabled = true,
                },
                lsp = {
                    on_attach = require("flutter-tools.lsp").on_attach,
                }
            })
        end,
    },
}
