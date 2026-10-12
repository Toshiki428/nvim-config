---obsidian.nvim(コミュニティ版フォーク)の導入設定。
---VaultのパスはOSごとに異なるため、utils.platform で切り替える。
---補完・検索には ripgrep(rg) が必要。詳細は docs/obsidian.md を参照。

local platform = require("utils.platform")

local vault_path
if platform.is_mac then
    vault_path = vim.fn.expand("~/work/note")
elseif platform.is_windows then
    vault_path = vim.fn.expand("~/work/note")
end

return {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- 最新リリースに追従(READMEのmainは未リリース機能を含むことがあるため)
    enabled = vault_path ~= nil and vim.uv.fs_stat(vault_path) ~= nil, -- Vaultが無い環境では読み込まない
    ---@module 'obsidian'
    ---@type obsidian.config
    opts = {
        legacy_commands = false,
        workspaces = {
            { name = "main", path = vault_path },
        },
        picker = { name = "telescope.nvim" },
        frontmatter = { enabled = false },
    },
}

