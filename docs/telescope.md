# Telescope

ファイル検索・全文検索・バッファ一覧などをファジー検索で行うプラグイン。  
設定ファイル: `lua/plugins/telescope.lua`

## 前提

- Neovim 0.12以上
- 依存プラグイン: plenary.nvim(lazy.nvimが自動で入れる)

## 必要な外部ツール

| ツール | 必須 | 用途 |
|---|---|---|
| ripgrep (rg) | 必須 | `live_grep` / `grep_string`。`find_files`でも最優先で使われる |
| fd | 任意 | `find_files`の追加finder。rgがあれば無くても困らないため未導入 |

### 導入方法

- macOS: `brew install ripgrep`
- Windows: `scoop install ripgrep` または `winget install BurntSushi.ripgrep.MSVC`
- 確認: `rg --version`

rgが見つからない場合は、起動時に警告を出す(`config`内でチェック)。

## キーマップ

| キー | 動作 |
|---|---|
| `<leader>ff` | ファイル名検索(find_files) |
| `<leader>fg` | 全文検索(live_grep) |
| `<leader>fb` | バッファ一覧 |
| `<leader>fh` | ヘルプ検索 |

## 見送ったもの

- **fd**: rgがfind_filesで最優先に使われ、無くても困らないため
- **telescope-fzf-native**: 並べ替えを高速化する拡張。ビルドにmakeとコンパイラが必要で、Windowsだけ環境準備が増えるため。Telescope単体で検索が遅いと感じたら再検討する

## 判断メモ

- 当初fdを必須と考えていたが、公式READMEでrgが最優先と確認し、fdは任意に変更した

