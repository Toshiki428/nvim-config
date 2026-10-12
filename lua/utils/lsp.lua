---LSP関連のNeovim側の設定。
---・言語サーバーの一覧(Masonでインストールされ、自動で有効化される)
---・全サーバー共通の設定(capabilities)、サーバーごとの追加設定
---・LSPがバッファにアタッチされた時のキーマップ
---インストール自体は lua/plugins/lsp.lua(Mason)の責務。

local M = {}

---Masonでインストールし、自動で有効化する言語サーバー(lspconfigの名前)
---@type string[]
M.servers = { "omnisharp", "pyright", "lua_ls" }

---LSPがアタッチされたバッファ用のキーマップ。
---K（ホバー)/grn(リネーム)/gra(コードアクション)/grr(参照)などはNeovim標準なので定義しない。
---@param bufnr integer
local function set_keymaps(bufnr)
    local function map(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
    end
    map("gd", vim.lsp.buf.definition, "LSP: 定義へジャンプ")
    map("gl", vim.diagnostic.open_float, "LSP: 診断を表示")
end

---@return nil
function M.setup()
    -- 全サーバー共通: nvim-cmp向けのcapabilities
    vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })

    -- lua_ls: Neovim設定を書くため、vimをグローバルとして認識させる
    vim.lsp.config("lua_ls", {
        settings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = { library = { vim.env.VIMRUNTIME } },
            },
        },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
        callback = function(args)
            set_keymaps(args.buf)
        end,
    })
end

return M

