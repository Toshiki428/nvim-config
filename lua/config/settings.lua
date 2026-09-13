---エディタ全体の基本設定（インデント・クリップボードなど）をまとめたファイル
---OS固有の判定やIME自動切り替えなどのロジックは`utils/`配下の各モジュールに記述し
---ここにはNeovim組み込みオプションの設定のみを置く

---基本のインシデント設定
vim.opt.expandtab = true -- Tabキーでスペースを挿入
vim.opt.tabstop = 4      -- 画面上のタブ幅
vim.opt.shiftwidth = 4   -- 自動インテント時のスペース数
vim.opt.softtabstop = 4  -- Tabキーを押した時のスペース数

---クリップボード設定
---OSのシステムクリップボードとNeovimのレジスタを統合する
vim.opt.clipboard = "unnamedplus"

---Web系・設定ファイル系のファイルタイプではインデント幅を2に上書きする
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "html", "css", "javascript", "typescript", "json", "yaml", "dart" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
    end,
})

