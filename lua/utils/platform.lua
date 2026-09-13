---OS判定ユーティリティ
---他モジュールがOS分岐を描く際の共通の入り口とする
---このファイル自身は個別機能のロジックを持たない

local M = {}

---現在のOSがWindowsか
---@type boolean
M.is_windows = vim.fn.has("win32") == 1

---現在のOSがmacOSか
---@type boolean
M.is_mac = vim.fn.has("mac") == 1

return M

