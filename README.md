# yomihime-stream-assets

如月怜（Yomihime）的直播资源仓库。

日本語版：[doc/README.ja.md](doc/README.ja.md)

## 中文

这个仓库用于存放和维护直播中使用的画面素材、叠加层、弹幕样式以及相关文档。内容主要面向 OBS / Bilibili 直播场景，可能会随着直播画面和主题需求持续调整。

## 目录

- `assets/`：直播画面用图片素材。
- `blivechat/`：Bilibili 弹幕姬 / blivechat 相关 CSS 样式。
- `blivechat/achrom-local/`：基于 [`hekatech/achrom-css`](https://github.com/hekatech/achrom-css) 中 FFXIV 部分进行的本地二次开发。
- `blivechat/achrom-local/ffxiv_blivechat_offline_template/`：FFXIV 风格 blivechat 的离线自包含版模板与生成脚本。
- `doc/`：说明文档或记录。
- `overlays/`：直播叠加层相关资源。

## achrom-local 说明

`blivechat/achrom-local` 中的 FF14 风格弹幕样式是在 `achrom-css` 的 FFXIV 资源和样式基础上进行调整的本地版本，主要用于适配如月怜的直播画面需求。

该目录内与 `achrom-css` 相关的 CSS 与素材引用遵循原作者及上游项目的要求。本仓库仅作为个人直播资源整理与本地适配用途；如相关内容存在授权、署名、引用方式或其他使用问题，请联系仓库维护者处理，将会根据权利方或原作者要求及时调整、移除或补充说明。

其中：

- `FF14 风 blivechat 样式（自包含版）.css`：可直接使用的 blivechat 样式。
- `ffxiv_blivechat_offline_template/ffxiv_blivechat_offline_template.css`：用于生成离线自包含 CSS 的模板。
- `ffxiv_blivechat_offline_template/make-offline.ps1`：将远程图片资源转换为 data URI 并生成离线 CSS 的 PowerShell 脚本。

## 使用

可以根据直播软件或弹幕工具的配置，将对应 CSS 文件作为自定义样式加载。部分素材路径、字体、窗口尺寸和排版参数可能与当前直播布局绑定，复用前请按自己的场景检查。

## 许可与素材说明

本仓库代码部分以 [MIT License](LICENSE) 发布。

仓库中可能包含直播用图片、界面素材、游戏风格衍生素材或基于第三方项目二次开发的内容。复用这些素材时，请同时遵守原始素材、游戏著作权方以及上游项目的许可与使用规则。
