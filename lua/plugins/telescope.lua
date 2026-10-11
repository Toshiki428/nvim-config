---Telescope(ファジーファインダー)の導入設定。
---ファイル検索とgrepに外部ツール ripgrep(rg) が必要。
---導入手順と判断経緯は docs/telescope.md を参照。

return {
    "nvim-telescope/telescope.nvim",
    version = "*", -- 最新のリリースタグに追従(公式の推奨)
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
        { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
        { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Live grep" },
        { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Buffers" },
        { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Help tags" },
    },
    config = function()
        if vim.fn.executable("rg") ~= 1 then
            vim.notify("ripgrep(rg)が見つかりません。live_grepが使えません。", vim.log.levels.WARN)
        end
        require("telescope").setup({})
    end,
}

