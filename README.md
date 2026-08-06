# 💖 羽蝉NIKKI一键化酒馆部署 💖

嗨，各位小仙女！(o´ω`o)ﾉ 欢迎来到羽蝉NIKKI的专属酒馆部署项目！

这是一个为安卓手机Termux和Linux服务器（如阿里云）设计的，超级简单、超级可爱的一键化SillyTavern（酒馆）安装脚本合集。让你在手机或服务器上都能轻松拥有属于自己的AI聊天伴侣！

> ⚠️ **开源程序 · 仅供学习交流使用 · 完全免费。**
> **如果收费，恭喜你被骗了。请通过 QQ 群获取正确渠道。**
>
> 💖 **本包永久免费，直接给姐妹们用，不需要密码、不需要验证，拿来就能装！**

## ✨ 版本选择

*   **`install_termux.sh` -> 📱 安卓Termux版 (v3.0)**
    *   **无需魔法上网**：内置原作者官方国内源（Gitee/GitLab），自动切换双源。
    *   锁定的稳定版本：SillyTavern **v1.18.0**。
    *   可选插件：酒馆助手 (Tavern Helper) + 记忆插件 (yuzuki-Memory)。
    *   适合想在手机上随时随地玩耍的小仙女。

*   **`install_aliyun.sh` -> ☁️ 阿里云/Linux通用版**
    *   **无需魔法上网**，脚本内置国内镜像加速，下载速度起飞！
    *   适合拥有自己服务器，追求稳定和高性能的玩家。

## 🚀 如何安装 (第一次使用)

### 📱 第一步：安装 Termux（必装，30秒搞定）

**安卓手机必须先装 Termux**（没有它酒馆跑不起来），任选一个方法：

**方法1（度盘直下，国内最快）**：手机浏览器打开度盘链接下载 Termux 安装包：
```text
链接：https://pan.baidu.com/s/1kTzCuyEMkPd5qFR1RUfDtw?pwd=xyxy
提取码：xyxy
```
下载完点开安装即可（安卓会提示"允许安装未知来源应用"，点允许就行）。

**方法2（官方直装，备选）**：度盘打不开就用官方下载页：
`https://f-droid.org/zh_Hans/packages/com.termux/`
往下拉到「版本」列表，点最新版旁边的 **Download APK** 下载安装。不用装 F-Droid 客户端。

**方法3（GitHub，最后备选）**：
`https://github.com/termux/termux-app/releases`
找 `termux-app_v0.118.x+apt-android-7-github-debug_universal.apk` 这个文件下载安装。

> ⚠️ **注意**：千万别用 Google Play 商店的旧版 Termux（跑不起来）！
> 装好后打开 Termux 输入 `pkg --version` 能出结果，就是装好了~

### 📱 第二步：部署酒馆

1.  **下载项目**：打开 Termux，复制粘贴下面的咒语，然后按回车：
    ```bash
    git clone https://github.com/mosaicbear/Nikki-SillyTavern-Termux.git
    ```
2.  **进入项目文件夹**：
    ```bash
    cd Nikki-SillyTavern-Termux
    ```
3.  **运行安装脚本**：
    ```bash
    chmod +x install_termux.sh && ./install_termux.sh
    ```
4.  脚本会弹出菜单，选 `1` 或 `2` 开始安装，等它跑完就行。

### ☁️ 阿里云 / Linux服务器 (免魔法)

1.  **下载项目**：
    ```bash
    git clone https://github.com/mosaicbear/Nikki-SillyTavern-Termux.git
    ```
2.  **进入项目文件夹**：
    ```bash
    cd Nikki-SillyTavern-Termux
    ```
3.  **运行安装脚本**：
    ```bash
    chmod +x install_aliyun.sh && ./install_aliyun.sh
    ```

---

## 🎮 安装脚本菜单

运行 `install_termux.sh` 后，会出现这样的菜单：

```
  羽蝉NIKKI · 酒馆一键部署
  ════════════════════════
  [1] 安装酒馆纯净版 v1.18.0
  [2] 一键安装（酒馆 + 酒馆助手）
  [3] 单独安装酒馆助手
  [4] 安装记忆插件 yuzuki-Memory
  [5] 退出
```

*   **选项1**：只装酒馆本体（纯净版 v1.18.0）
*   **选项2**：酒馆 + 酒馆助手一起装（推荐新手）
*   **选项3**：已有酒馆，单独补装酒馆助手
*   **选项4**：已有酒馆，单独安装记忆插件 yuzuki-Memory（自动记忆表格 + 隐藏楼层省 Token）

> 装完插件后，**打开酒馆 → 扩展 → 勾选启用**对应插件才能生效哦！

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
2.  **进入项目文件夹**：
    ```bash
    cd Nikki-SillyTavern-Termux
    ```
3.  **一键启动**（没装好酒馆的话它会先自动问你装不装）：
    ```bash
    bash start.sh
    ```
4.  **开始玩耍**：手机浏览器访问 `http://127.0.0.1:8000`

---

## 📁 项目里都有什么

| 文件 | 是干嘛的 |
|------|---------|
| `install_termux.sh` | 安卓 Termux 一键部署（酒馆 + 助手 + 记忆插件） |
| `install_aliyun.sh` | 阿里云 / Linux 服务器部署 |
| `start.sh` | 日常启动器（自动检测酒馆，没装会先问你要不要装） |
| `plugins/README.md` | 酒馆推荐插件清单（TTS / 记忆 / 表情包等） |
| `patch/mark-inject.js` | 可选小工具：给酒馆页面加"开源免费·被骗加群"水印标注（想自己分享给朋友时用，跑 `node patch/mark-inject.js` 即可） |

---

## 💖 加入我们

遇到问题或者想找姐妹们聊天？快来加入我们的QQ群吧！

**QQ群号：778585992**

---

祝你玩得开心！比心！💖
