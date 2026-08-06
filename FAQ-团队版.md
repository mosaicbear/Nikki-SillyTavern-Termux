# 🕳️ 羽蝉NIKKI · 团队维护手册（FAQ-团队版）

> ⚠️ 内部文档，禁止对外公开。新 agent 接手本仓库前先读这份 + AGENTS.md。
> 用户答疑请用 `FAQ-用户版.md`。

---

## 1. 版本演进记录

| 版本 | 改了什么 | 为什么 |
|------|---------|--------|
| v2.0 | 菜单式一键部署 + 密码引导页 | 初版 |
| v3.0 | 双源自动切换（Gitee/GitLab/GitHub） | 无魔法用户装不动 |
| v3.1 | 去菜单 → 全自动一条龙，失败即停 | 菜单式失败还假恭喜，用户观感差 |
| v3.2 | TTY 检测 / checkout 失败即停 / 换源兼容 sources.list.d | `curl\|bash` 管道 read 崩溃、假恭喜、新版 Termux 布局 |
| v3.3 | 换源改为"写源+apt update 验证+失败回退" | `curl --max-time 3` 探测失败就放弃换源 → 用户走国外源极慢 |
| v3.4 | clone 检测 CANNOT LINK → 自动 pkg upgrade 修复 | Termux 包混装导致 git-remote-https 崩 |
| v3.5 | 修复改用 `apt full-upgrade` 而非 `pkg upgrade` | pkg 内部依赖 curl，curl 挂了 pkg 自举失败 |
| v3.6 | shallow clone 后先 fetch tag 再 checkout；日志 /tmp→$HOME | `git checkout 1.18.0` pathspec 不匹配；部分 Termux /tmp 无写权限 |
| v3.7 | 移除记忆插件 yuzuki-Memory（缺正则+全局脚本无法运行）；README 精简；FAQ 两版 | 插件半残不如不给；文档化 |

## 2. 九大技术坑（含根因）

### 坑 1 · Termux 包混装 → CANNOT LINK
- **症状**：`git-remote-https` / `curl` 报 `cannot locate symbol "SSL_set_quic_tls_transport_params" referenced by libngtcp2_crypto_ossl.so`
- **根因**：`libngtcp2` 更新到需要新版 OpenSSL 符号，但 OpenSSL 没跟着升。多因用户手动 `pkg install git` 等操作造成新旧混装
- **修法**：`apt update && apt full-upgrade -y`
- **关键**：**不能用 `pkg upgrade`**——pkg 是 bash 封装，内部调用 curl，curl 挂了 pkg 也自举失败。apt 走 libapt，不依赖 curl 二进制

### 坑 2 · shallow clone 不带 tag
- **症状**：`git clone --depth 1` 成功后 `git checkout 1.18.0` 报 `pathspec did not match`
- **根因**：shallow clone 只拉默认分支最新 commit，不带 tags
- **修法**：clone 后 `git fetch --depth 1 origin "refs/tags/$VER:refs/tags/$VER"` 再 checkout

### 坑 3 · `curl | bash` 管道模式交互失效
- **症状**：插件菜单 `read` 读到 EOF，`set -u` 下未定义变量直接崩溃
- **根因**：管道模式下 bash stdin 是管道不是终端
- **修法**：`[ -t 0 ]` 检测，非 TTY 跳过交互并提示；TTY 交互可用 `bash -c "$(curl ...)"` 方式

### 坑 4 · 换源探测法太脆弱
- **症状**：清华源其实可用，但 `curl --max-time 3` 探测抖一下失败 → 放弃换源 → pkg 走国外源极慢
- **修法**：不依赖探测。直接写源（备份原源 → 注释旧 deb 行 → 追加清华）→ `apt update` 真实验证 → 失败自动恢复备份

### 坑 5 · Termux 源文件布局差异
- 旧版：`$PREFIX/etc/apt/sources.list`
- 新版 0.118+：`$PREFIX/etc/apt/sources.list.d/termux-main.list`
- 脚本必须两者兼容，优先 sources.list.d

### 坑 6 · `/tmp` 无写权限
- 部分 Termux 的 `/tmp` 不可写，`tee /tmp/*.log` 报 Permission denied
- **修法**：日志文件改 `$HOME/nikki_clone_$$.log`

### 坑 7 · Gitee 侧五个坑
| 坑 | 现象 | 修法 |
|----|------|------|
| 裸请求 405 | `curl gitee.com/xxx` 返回 405 | 它只是不支持裸请求，git smart HTTP 端点（`/info/refs?service=git-upload-pack`）200 可用 |
| `private=false` 不生效 | 建仓 PATCH 后仍私有 | 需 `-X PATCH` 且带 `name` + `private=false`（不带 name 报 "name is missing"） |
| 拒绝 shallow push | `shallow update not allowed` | `git fetch --unshallow origin` 后再 push |
| raw 302 | `gitee.com/xxx/raw/` 重定向到 `raw.giteeusercontent.com` | curl 必须带 `-L` |
| 私有仓库 raw 403 | 未公开时 raw 403 `Route error` | 确认仓库 `private:false` |

### 坑 8 · GitHub raw CDN 缓存延迟
- push 后 `raw.githubusercontent.com` 可能拉到旧 md5（缓存延迟）
- **验证权威**：`api.github.com/repos/OWNER/REPO/contents/文件?ref=main` 带 `Accept: application/vnd.github.raw`

### 坑 9 · 别用 `grep`/`sed` 去验证 git 协议
- Windows git 的 schannel 会报 `CRYPT_E_REVOCATION_OFFLINE`（证书吊销检查），不代表源不可用
- 手机 Termux 用 OpenSSL 无此问题；验证源用 curl 打 git smart HTTP 端点更接近真机

## 3. 发布 / 维护流程

1. 改脚本 → `bash -n` 语法检查
2. 本地 stub 测试关键分支（clone_repo / install_tavern / plugin_guide / setup_pkg_source），模拟 git/apt/pkg
3. commit → push GitHub（`-c http.proxy=http://127.0.0.1:15236 -c http.sslVerify=false`）+ push Gitee（`-c http.proxy= -c http.sslVerify=false`）
4. 三端 md5 校验：本地 = Gitee raw(-L) = GitHub raw；GitHub 用 API 兜底防 CDN 缓存
5. 版本号递增（脚本/README 同步）→ README + FAQ 同步更新

## 4. 分发命令（写进 README/宣传）

- 没魔法：`curl -fsSL https://gitee.com/mosaicb/Nikki-SillyTavern-Termux/raw/main/install_termux.sh | bash`
- 有魔法：`curl -fsSL https://raw.githubusercontent.com/mosaicbear/Nikki-SillyTavern-Termux/main/install_termux.sh | bash`
- 想交互装酒馆助手：`bash -c "$(curl -fsSL https://gitee.com/mosaicb/Nikki-SillyTavern-Termux/raw/main/install_termux.sh)"`

## 5. 联系

- QQ 群：778585992
- 仓库：github.com/mosaicbear/Nikki-SillyTavern-Termux · gitee.com/mosaicb/Nikki-SillyTavern-Termux
