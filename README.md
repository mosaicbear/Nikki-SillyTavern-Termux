# 💖 羽蝉NIKKI一键化酒馆部署 💖

嗨，各位小仙女！(o´ω`o)ﾉ 欢迎来到羽蝉NIKKI的专属酒馆部署项目！

这是一个为安卓手机Termux和Linux服务器（如阿里云）设计的，超级简单、超级可爱的一键化SillyTavern（酒馆）安装脚本合集。让你在手机或服务器上都能轻松拥有属于自己的AI聊天伴侣！

> ⚠️ **开源程序 · 仅供学习交流使用 · 完全免费。**
> **如果收费，恭喜你被骗了。请通过 QQ 群获取正确渠道。**

## ✨ 版本选择

*   **`install_termux.sh` -> 📱 安卓Termux版 (v2.0)**
    *   **需要魔法上网环境**，因为它需要从GitHub拉取代码。
    *   升级内容：release 稳定分支 + 热门插件预置 + 定制水印 + 密码引导页
    *   适合想在手机上随时随地玩耍的小仙女。

*   **`install_aliyun.sh` -> ☁️ 阿里云/Linux通用版**
    *   **无需魔法上网**，脚本内置国内镜像加速，下载速度起飞！
    *   适合拥有自己服务器，追求稳定和高性能的玩家。

## 🚀 如何安装 (第一次使用)

### 📱 Termux (安卓手机)

1.  **下载项目**：
    *   打开Termux，复制粘贴下面的咒语，然后按回车：
      ```bash
      git clone https://github.com/mosaicbear/Nikki-SillyTavern-Termux.git
      ```
2.  **进入项目文件夹**：
    *   继续念咒语：
      ```bash
      cd Nikki-SillyTavern-Termux
      ```
3.  **运行安装脚本**：
    *   最后一步，运行我们的安装魔法！
      ```bash
      chmod +x install_termux.sh && ./install_termux.sh
      ```
    *   脚本会自动完成所有安装步骤，耐心等待它跑完哦~

### ☁️ 阿里云 / Linux服务器 (免魔法)

1.  **下载项目**：
    *   连接到你的服务器后，复制粘贴下面的咒语，然后按回车：
      ```bash
      git clone https://github.com/mosaicbear/Nikki-SillyTavern-Termux.git
      ```
2.  **进入项目文件夹**：
    *   继续念咒语：
      ```bash
      cd Nikki-SillyTavern-Termux
      ```
3.  **运行安装脚本**：
    *   最后一步，运行我们的安装魔法！
      ```bash
      chmod +x install_aliyun.sh && ./install_aliyun.sh
      ```
    *   脚本会自动完成所有安装步骤，耐心等待它跑完哦~

---

## 💖 如何启动 / 再次启动酒馆 (日常使用)

安装好之后，每次想玩的时候，只需要跟着下面的步骤就可以啦！

1.  **打开Termux或连接服务器**。
2.  **找到酒馆的家**：
    *   念出咒语，回到我们项目的文件夹：
      ```bash
      cd Nikki-SillyTavern-Termux
      ```
    *   再念一次咒语，进入酒馆的房间：
      ```bash
      cd SillyTavern
      ```
3.  **启动酒馆**：
    *   最后，念出启动咒语：
      ```bash
      ./start.sh
      ```
4.  **开始玩耍**：
    *   **Termux用户**：在手机浏览器访问 `http://127.0.0.1:8000`
    *   **服务器用户**：在电脑浏览器访问 `http://<你的服务器公网IP>:8000` (请确保服务器的8000端口是开放的哦！)

> 💡 **Termux 快捷启动**：也可以直接运行项目根目录的 `./start.sh`，未部署时会自动引导安装。

## 🎁 v2.0 新增内容

*   **release 稳定分支**：默认拉取 SillyTavern 官方 release 分支，更稳定。
*   **热门插件预置**：提供插件推荐清单（TTS / 摘要防失忆 / 向量记忆 / 角色卡查看器）。
*   **定制水印**：酒馆页面底部注入「羽蝉NIKKI · 开源免费」标记 + 群号，正版防冒认。
*   **密码引导页**：下载前需输入密码（`guide/guide.html`），密码在 QQ 群免费获取，强制防滥用。

## 💖 加入我们

遇到问题或者想找姐妹们聊天？快来加入我们的QQ群吧！

**QQ群号：778585992**

<img src="qq群.jpg" width="250">

---

祝你玩得开心！比心！💖
