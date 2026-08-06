# 💖 羽蝉NIKKI一键化酒馆部署 💖

嗨，各位小仙女！(o´ω`o)ﾉ 欢迎来到羽蝉NIKKI的专属酒馆部署项目！

这是一个为安卓手机设计的，超级简单、超级可爱的一键化SillyTavern（酒馆）安装脚本合集。让你在自己的手机上轻松拥有专属的AI聊天伴侣！

> ⚠️ **开源程序 · 仅供学习交流使用 · 完全免费。**
> **如果收费，恭喜你被骗了。请通过 QQ 群获取正确渠道。**
>
> 💖 **本包永久免费，直接给姐妹们用，不需要密码、不需要验证，拿来就能装！**

## ✨ 版本选择

*   **`install_termux.sh` -> 📱 安卓Termux版 (v3.4 全自动)**
    *   **无需魔法上网**：内置原作者官方国内源（Gitee/GitLab），自动切换双源。
    *   **一条命令全自动**：自动装依赖 → 装酒馆 → 引导装插件，全程不用管。
    *   锁定的稳定版本：SillyTavern **v1.18.0**。
    *   可选插件：酒馆助手 (Tavern Helper) + 记忆插件 (yuzuki-Memory)。
    *   适合想在手机上随时随地玩耍的小仙女。

## 🚀 如何安装 (第一次使用)

### 📱 第一步：安装 Termux（必装，30秒搞定）

**安卓手机必须先装 Termux**（没有它酒馆跑不起来），任选一个方法：

**方法1（官方直装，推荐）**：手机浏览器打开官方下载页：
`https://f-droid.org/zh_Hans/packages/com.termux/`
往下拉到「版本」列表，点最新版旁边的 **Download APK** 下载安装。不用装 F-Droid 客户端。

**方法2（GitHub，备选）**：
`https://github.com/termux/termux-app/releases`
找 `termux-app_v0.118.x+apt-android-7-github-debug_universal.apk` 这个文件下载安装。

> ⚠️ **注意**：千万别用 Google Play 商店的旧版 Termux（跑不起来）！
> 装好后打开 Termux 输入 `pkg --version` 能出结果，就是装好了~

### 📱 第二步：一键部署（一条命令全自动）

打开 Termux，**根据你的网络情况选一条**，复制粘贴按回车，然后等它自己装完就行：

**没魔法（国内网络）**：
```bash
curl -fsSL https://gitee.com/mosaicb/Nikki-SillyTavern-Termux/raw/main/install_termux.sh | bash
```

**有魔法（能翻墙）**：
```bash
curl -fsSL https://raw.githubusercontent.com/mosaicbear/Nikki-SillyTavern-Termux/main/install_termux.sh | bash
```

脚本会自动完成：
1. 自动换国内源 + 装依赖（git / node / curl）
2. 自动下载酒馆本体 v1.18.0（国内源优先，失败自动切国外）

> 💡 **想装插件？** 上面的命令装完会自动跳过插件选择（管道安装没法交互）。
> 想手动选插件，把 `| bash` 换成下面这种写法（保留交互）：
> ```bash
> bash -c "$(curl -fsSL https://gitee.com/mosaicb/Nikki-SillyTavern-Termux/raw/main/install_termux.sh)"
> ```
> 装完会问你要不要装「酒馆助手」或「记忆插件」，选 1 / 2 装，选 3 结束。

> 装完后启动酒馆：`cd ~/SillyTavern && ./start.sh`，浏览器打开 `http://127.0.0.1:8000`

---

## 🌐 双源说明

脚本所有下载都内置了**国内 + 国外双源**，全部为**原作者官方源**，自动切换：

| 下载项 | 国内源（优先） | 国外源（兜底） |
|--------|--------------|--------------|
| 酒馆本体 | Gitee 极速下载镜像 `gitee.com/mirrors/sillytavern` | GitHub 官方 `SillyTavern/SillyTavern` |
| 酒馆助手 | GitLab 官方 `gitlab.com/novi028/JS-Slash-Runner` | GitHub 官方 `N0VI028/JS-Slash-Runner` |
| 记忆插件 yuzuki-Memory | Gitee 官方 `gitee.com/gaigai315/yuzuki-Memory` | GitHub 官方 `gaigai315/yuzuki-Memory` |
| npm 依赖 | npmmirror | npm 官方 |
| Termux 软件源 | 清华镜像 | 官方源 |

国内网络优先走 Gitee/GitLab，失败自动切 GitHub，全程不用你操心。

## 🌐 网络说明（奶人一键部署包）

**奶人一键部署包**：优先使用国内源（自动切换），无需魔法。

- 如果国内源不可用，请自行挂梯子（魔法）重试。
- 如果两个源都失败，请来 QQ 群 **778585992** 询问。

## 💖 如何启动 / 再次启动酒馆 (日常使用)

1.  **打开Termux**。
2.  **进入酒馆目录**：
    ```bash
    cd ~/SillyTavern
    ```
3.  **启动酒馆**：
    ```bash
    ./start.sh
    ```
4.  **开始玩耍**：手机浏览器访问 `http://127.0.0.1:8000`

---

## 📁 项目里都有什么

| 文件 | 是干嘛的 |
|------|---------|
| `install_termux.sh` | 安卓 Termux 一键部署（全自动：依赖 + 酒馆 + 引导插件） |
| `plugins/README.md` | 酒馆推荐插件清单（TTS / 记忆 / 表情包等） |
| `patch/mark-inject.js` | 可选小工具：给酒馆页面加"开源免费·被骗加群"水印标注（想自己分享给朋友时用，跑 `node patch/mark-inject.js` 即可） |

---

## 💖 加入我们

遇到问题或者想找姐妹们聊天？快来加入我们的QQ群吧！

**QQ群号：778585992**

---

祝你玩得开心！比心！💖
