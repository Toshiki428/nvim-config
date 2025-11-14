return {
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- Source for LSP completions
            "hrsh7th/cmp-buffer", -- Source for buffer completions
            "hrsh7th/cmp-path", -- Source for path completions
            "hrsh7th/cmp-vsnip", -- Source for vsnip snippets
            "hrsh7th/vim-vsnip", -- Snippet engine
        },
        config = function()
            local cmp = require("cmp")
            local lspkind = require("lspkind")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                -- Add borders to the documentation window for visibility
                window = {
                    documentation = cmp.config.window.bordered(),
                },
                -- Keymappings for the completion menu
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "s" }),
                }),
                -- Sources for completion
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "vsnip" },
                    { name = "buffer" },
                    { name = "path" },
                }),
                -- Configure lspkind for icons
                formatting = {
                    format = lspkind.cmp_format({
                        mode = "symbol_text", -- show only symbol annotations
                        maxwidth = 50, -- prevent the popup from becoming too wide
                        ellipsis_char = "...", -- when popup menu is too wide
                    }),
                },
            })
        end,
    },
    {
        -- Optional: Adds pretty icons to the completion menu
        "onsails/lspkind.nvim",
        event = "VimEnter",
    }
}
