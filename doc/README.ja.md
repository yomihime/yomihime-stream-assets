# yomihime-stream-assets

このリポジトリは、如月怜（Yomihime）の配信用素材を管理するためのものです。

中文：[../README.md](../README.md)

## 日本語

OBS / Bilibili 配信で使用する画像素材、オーバーレイ、blivechat 用 CSS、関連ドキュメントを置いています。配信画面やテーマの変更に合わせて、内容は随時更新される可能性があります。

## ディレクトリ構成

- `assets/`：配信用の画像素材。
- `blivechat/`：Bilibili 弾幕姫 / blivechat 向けの CSS スタイル。
- `blivechat/achrom-local/`：[`hekatech/achrom-css`](https://github.com/hekatech/achrom-css) の FFXIV 関連部分をもとにしたローカル改変版。
- `blivechat/achrom-local/ffxiv_blivechat_offline_template/`：FFXIV 風 blivechat スタイルのオフライン自己完結版テンプレートと生成スクリプト。
- `doc/`：説明文書やメモ。
- `overlays/`：配信用オーバーレイ関連の素材。

## achrom-local について

`blivechat/achrom-local` の FF14 風コメント表示スタイルは、`achrom-css` の FFXIV 向け素材・スタイルをベースに、如月怜の配信画面に合わせて調整したものです。

このディレクトリ内の `achrom-css` 関連 CSS および素材参照は、原作者および上流プロジェクトの要件に従います。本リポジトリは個人配信用素材の整理とローカル適用を目的としています。権利、クレジット、参照方法、その他の利用条件について問題がある場合は、リポジトリ管理者までご連絡ください。権利者または原作者の要請に応じて、速やかに修正、削除、または説明の追記を行います。

主なファイル：

- `FF14 风 blivechat 样式（自包含版）.css`：そのまま読み込める blivechat 用 CSS。
- `ffxiv_blivechat_offline_template/ffxiv_blivechat_offline_template.css`：オフライン自己完結版 CSS を生成するためのテンプレート。
- `ffxiv_blivechat_offline_template/make-offline.ps1`：リモート画像を data URI に変換し、オフライン用 CSS を生成する PowerShell スクリプト。

## 使い方

配信ソフトやコメント表示ツールの設定に合わせて、該当する CSS ファイルをカスタムスタイルとして読み込んでください。一部の素材パス、フォント、ウィンドウサイズ、レイアウト設定は現在の配信画面に合わせているため、再利用する場合は環境に合わせて調整してください。

## ライセンスと素材について

このリポジトリ内のコード部分は [MIT License](../LICENSE) で公開されています。

画像素材、ゲーム風の派生素材、第三者プロジェクトをもとにした改変内容が含まれる場合があります。再利用する際は、元素材、ゲームの権利者、および上流プロジェクトのライセンスや利用条件も確認してください。
