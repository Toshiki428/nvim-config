local function has_im_select()
    local handle = io.popen("which im-select")
    local result = handle:read("*a")
    handle:close()
    return string.match(result, "%S") ~= nil
end

vim.opt.expandtab = true -- Tabキーでスペースを挿入
vim.opt.tabstop = 4      -- 画面上のタブ幅
vim.opt.shiftwidth = 4   -- 自動インテント時のスペース数
vim.opt.softtabstop = 4  -- Tabキーを押した時のスペース数

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "html", "css", "javascript", "typescript", "json", "yaml" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})

-- Mac用の設定
if vim.loop.os_uname().sysname == "Darwin" then
    vim.opt.clipboard = "unnamedplus"

    if not has_im_select() then
        vim.notify("⚠️ im-select が見つかりません。インストールしてください。")
        return
    end

    vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
            vim.fn.system("im-select com.apple.keylayout.ABC")
        end,
    })
end
