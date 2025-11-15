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
            require("flutter-tools").setup({
                widget_guides = {
                    enabled = true,
                },
                lsp = {
                    on_attach = require("config.lsp_on_attach"),
                    -- on_attach and capabilities are now handled by the global LSP config
                    init_options = {
                        documentUpdates = false,
                    },
                }
            })
        end,
    },
}
