---InsertLeave時にIMEを英数入力へ自動切り替えするための設定
---OSごとの実行ファイル名・呼び出し方の差異をここに閉じ込め、
---呼び出し元からは `require("utils.ime").setup_autoswitch()` を呼ぶだけで済むようにする

local platform = require("utils.platform")

local M = {}

---OSごとの設定値
---@class ImeOsConfig
---@field exe_name string 実行ファイル名（'vim.fn.executable'でのチェックに使用）
---@field switch_cmd string[] IMEを英語に切り替えるためのコマンド（引数は配列で渡す）

---@type table<string, ImeOsConfig>
local config = {
    mac = {
        exe_name = "im-select",
        switch_cmd = { "im-select", "com.apple.keylayout.ABC" },
    },
    windows = {
        exe_name = "ime_off.exe",
        switch_cmd = { "ime_off.exe" },
    },
}

---現在のOSに対応する設定を取得する
---@return ImeOsConfig|nil
local function get_current_os_config()
    if platform.is_mac then
        return config.mac
    elseif platform.is_windows then
        return config.windows
    end
    return nil
end

---現在のOSでIME切り替えツールが利用可能かどうかを調べる
---@return boolean
function M.is_available()
    local cfg = get_current_os_config()
    if not cfg then
        return false
    end
    return vim.fn.executable(cfg.exe_name) == 1
end

---InsertLeave autocmdを登録し、IME自動切り替えを有効化する
---ツールが見つからない場合は何もせず警告を出す
---@return nil
function M.setup_autoswitch()
    if not M.is_available() then
        vim.notify("IME切り替えツールが見つかりません。インストールしてください。", vim.log.levels.WARN)
        return
    end

    local cfg = get_current_os_config()

    vim.api.nvim_create_autocmd("InsertLeave", {
        group = vim.api.nvim_create_augroup("ime_autoswitch", { clear = true }),
        pattern = "*",
        callback = function()
            vim.fn.system(cfg.switch_cmd)
        end,
    })
end

return M

