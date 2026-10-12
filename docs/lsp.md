# LSP (Mason + nvim-lspconfig)

設定ファイル: `lua/plugins/lsp.lua`(導入)、`lua/utils/lsp.lua`(サーバー一覧と共通設定)

## 役割分担

| 部品 | 役割 |
|---|---|
| Neovim本体 | LSPクライアント。`vim.lsp.config`で設定、`vim.lsp.enable`で有効化 |
| nvim-lspconfig | 言語サーバーごとの設定集(インストールはしない) |
| Mason | 言語サーバーのインストーラ |
| mason-lspconfig | インストール済みサーバーの自動有効化と`ensure_installed` |

- `require("lspconfig").xxx.setup{}`は非推奨。`vim.lsp.config`/`vim.lsp.enable`を使う
- Neovim 0.12以降が前提

## サーバー一覧

`lua/utils/lsp.lua`の`M.servers`に追加する(lspconfigの名前で書く)。
- omnisharp(C#) / pyright(Python) / lua_ls(Lua)
- 追加した場合はここにも書く

## 設計判断

- `on_attach`はサーバーごとに渡さず、`LspAttach`イベントで全サーバー共通に処理する
  (リストに無いサーバーにも適用され、リストの管理が不要になる)
- `capabilities`は`vim.lsp.config("*", ...)`で全サーバー共通に1回だけ設定する
- キーマップは`K`/`gd`/`gl`のみ自前。`grn`/`gra`/`grr`/`gri`/`grt`はNeovim標準を使う
- lua_lsは、Neovim設定を書くため`vim`をグローバルとして認識させる

## キーマップ

| キー | 動作 | 由来 |
|---|---|---|
| `gd` | 定義へジャンプ | 自前(`utils/lsp.lua`) |
| `gl` | 診断をフロート表示 | 自前(`utils/lsp.lua`) |
| `K` | ホバー(説明の表示) | Neovim標準 |
| `grn` | リネーム | Neovim標準 |
| `gra` | コードアクション | Neovim標準 |
| `grr` | 参照の一覧 | Neovim標準 |
| `gri` | 実装へジャンプ | Neovim標準 |
| `grt` | 型定義へジャンプ | Neovim標準 |
| `grx` | codelensの実行 | Neovim標準 |
| `Ctrl-S`(挿入モード) | シグネチャヘルプ | Neovim標準 |

- 「自前」はLspAttach時にバッファローカルで設定する(`lua/utils/lsp.lua`)
- 「Neovim標準」は`:h lsp-defaults`を参照。設定ファイルには書かれていない
- 診断の移動(`]d`/`[d`など)の標準キーは`:h diagnostic-defaults`を参照
- `gd`などで飛んだ後は、`Ctrl-O`で元の位置に戻り、`Ctrl-I`で再び進む(Vim標準のジャンプリスト)
  - 履歴は`:jumps`で確認できる
  - `grr`や`gri`など、他のジャンプでも同じように戻れる

## 補完

- nvim-cmpを使う(`cmp_nvim_lsp`経由)
- Neovim本体の補完(`vim.lsp.completion.enable`)への移行は未検討
  - 移行する場合は、nvim-cmpと併用すると二重に表示されるため、置き換える
- blink.cmpは未検討(V2が開発中で破壊的変更が多いため、使うなら安定版V1)

## 必要な環境

- Node.js / npm(pyrightなどnpm経由のサーバーのため)
- Windows: PowerShell、git、tar、解凍ツール(7zipなど)。`:checkhealth mason`で確認

## 動作確認

- 確認済み: macOS / Neovim 0.12.6(lua_lsでの`K`/`gd`/補完/`grn`/`grr`など)
- 未確認: Windows
- 確認コマンド: `:Mason`、`:checkhealth mason`、`:checkhealth vim.lsp`
- 原因調査: `:lua vim.lsp.log.set_level("debug")`のあと`:LspLog`

