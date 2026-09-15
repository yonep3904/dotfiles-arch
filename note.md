# dotfiles-arch

この CachyOS (Arch Linux) PC の `~/.config` からコピーした設定です。`dotfiles-old` は参照していません。

## 配置

`home/<パッケージ名>/.config/` 以下に、ホームディレクトリに配置する構造で保存しています。
既存の `~/.config` は変更していません。

## コピーした設定

- `alacritty`
- `btop`
- `fcitx5`
- `fish`
- `fontconfig`
- `ghostty`
- `gtk-3.0`
- `gtk-4.0`
- `hypr`
- `hyprshell`
- `kde`
- `kitty`
- `micro`
- `noctalia`
- `nvim`
- `qt5ct`
- `qt6ct`
- `thunar`
- `uwsm`
- `vscode`
- `xdg`
- `xsettingsd`
- `zathura`
- `zed`

## 対象外

- ブラウザ・Discord・Codex などのプロファイル、認証情報、データベース
- キャッシュ、ログ、バックアップ、編集履歴、セッション、最近使ったファイル
- Mozc の学習データ、KDE Connect のペアリング情報、バイナリの dconf データ
- ダウンロード済みのプラグイン本体、Micro の配布構文定義
- Neovim ディレクトリ内のメモやセットアップ用スクリプト
- Ghostty shaders 内の Git 管理情報とプレビュー画像（GLSL ファイルのみコピー）

## この PC に依存する設定

絶対パス、モニター指定、壁紙のパスなどもコピー元のまま保持しています。
別 PC に配置するときは調整してください。フォント、テーマ、アプリ、Noctalia のプラグイン本体などは別途インストールが必要です。
Fish は `/usr/share/cachyos-fish-config/cachyos-config.fish` を参照しています。
