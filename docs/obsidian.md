# obsidian.nvim

ObsidianのVaultをNeovimから扱うプラグイン(コミュニティ版フォーク)。  
設定ファイル: `lua/plugins/obsidian.lua`

## 前提

- `epwalsh/obsidian.nvim`は長期間メンテされていないため、フォークの`obsidian-nvim/obsidian.nvim`を使う
- Neovim 0.12以上
- `version = "*"`で最新リリースに追従(READMEのmainは未リリース機能を含むことがあるため)
- コマンドは`:Obsidian <サブコマンド>`形式のみ(`legacy_commands = false`)。古い記事の`:ObsidianNew`などは使えない

## Vault

OSごとに別のVaultを1つずつ使う。2台の間で同期はしない。

| OS | パス |
|---|---|
| macOS | `~/work/note` |
| Windows | `~/work/note` |

パスは`utils.platform`でOSごとに切り替える。  
Vaultが存在しない環境では、プラグインを読み込まない(`enabled`のガード)。

## 必要な外部ツール

| ツール | 必須 | 用途 |
|---|---|---|
| ripgrep (rg) | 必須 | 補完と検索。Telescope用に導入済み |
| pngpaste (macOS) | 任意 | `:Obsidian paste_img`(クリップボードの画像を貼る) |
| ImageMagick (`convert`) | 任意 | 貼った画像の色味補正 |
| SoX / arecord | 任意 | 音声メモの録音 |

Windowsネイティブは、追加の要件はREADMEに書かれていない(WSLのみ`wsl-open`が必要)。  
任意のツールは、該当機能を使うときだけ入れる。

## 設定の判断

- **picker**: Telescopeを使う(`picker = { name = "telescope.nvim" }`)
- **frontmatter**: 無効にする(`frontmatter = { enabled = false }`)
  - 既存のノートはタイトルだけで作ったプレーンなmarkdownで、困っていない
  - 有効だと、既存ノートの保存時にfrontmatterが書き込まれる可能性がある
  - `:checkhealth`で出る「missing frontmatter」は、この機能を使っていないことの通知なので無視してよい
- **ノートの作成**: 当面は`:e タイトル.md`で自分で作る。`note_id_func`は初期設定のまま

## 見送ったもの(再検討のきっかけ)

| 項目 | 見送った理由 | 再検討のきっかけ |
|---|---|---|
| frontmatter | 困っていない | 別名(aliases)でも探したい、状態でノートを絞り込みたくなった時 |
| `note_id_func` | `:e`で作るため影響しない | `:Obsidian new`や、存在しないリンクからの新規作成を使いたくなった時 |
| 補完の設定 | LSPと補完UIの選定とセットで決める | Mason + LSPの設定時 |

### `note_id_func`についての補足

- 初期設定は`1757480000-QWER.md`のような時刻+ランダム文字のファイル名になる
- 組み込みの`title_id`はタイトルを小文字化してスペースを`-`にするため、今の命名(`Apache.md`)とは合わない
- 合わせるなら、タイトルをそのままファイル名にする関数を自作するか、命名規則を変更する

## 補完

- 補完はプラグイン内蔵のLSP(in-process LSP)で動く(`[[`でリンク、`#`でタグ)
- 補完UIの設定は、Mason + LSPの段階で決める。設定の詳細はREADMEが案内するWikiの「Completion」を参照

## 動作確認

- `:checkhealth obsidian`
- `:Obsidian check`
- 確認済み: macOS / Neovim 0.12.6 / obsidian.nvim v3.16.8(設定の検証OK、rg検出OK)
- 未確認: Windows
- Picker警告: 「Telescopeなどを入れてください」と出たが、Telescopeは導入済み
  - 原因: Telescopeが遅延読み込みで未ロードだった / `picker.name`が未指定だった
  - 解決: 一度`<leader>ff`を押して、Telescopeを読み込んでから実行

