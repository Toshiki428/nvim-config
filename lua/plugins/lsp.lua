return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "mason-org/mason.nvim",
            "mason-org/mason-lspconfig.nvim",
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local on_attach = require("config.lsp_on_attach")

            local servers = { "omnisharp" }

            -- 1. Apply shared configuration to each server BEFORE they are enabled.
            for _, server_name in ipairs(servers) do
                vim.lsp.config(server_name, {
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end

            -- 2. Let mason-lspconfig handle installation and enabling the servers.
            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = servers,
            })
        end,
    },
}
