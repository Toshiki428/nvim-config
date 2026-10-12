---LSPの導入設定(Mason + nvim-lspconfig + mason-lspconfig)。
---サーバー一覧と共通設定は utils/lsp.lua。補完はnvim-cmp(cmp_nvim_lsp)経由。
---詳細は docs/lsp.md を参照。

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local lsp = require("utils.lsp")
        lsp.setup()
        require("mason").setup()
        require("mason-lspconfig").setup({ ensure_installed = lsp.servers })
    end,
}
