# 💖 Yuchen NIKKI · One-Click SillyTavern Deploy 💖

**🌐 Language / 语言: English | [中文](README.md)**

Hi there! (o´ω`o)ﾉ Welcome to the Yuchen NIKKI one-click Tavern deploy project!

This is a collection of super-simple, super-cute one-click **SillyTavern** install scripts made for **Android phones**. Have your very own AI chat companion on your phone in minutes!

> ⚠️ **Open-source project · For learning & communication only · 100% free.**
> **If anyone charges you for it, you've been scammed. Get the correct channel via the QQ group.**
>
> 💖 **This package is permanently free — no password, no verification, just grab it and install!**

## ✨ Version

*   **`install_termux.sh` → 📱 Android / Termux (v3.7, fully automatic)**
    *   **No VPN needed**: built-in official mirrors (Gitee/GitLab), auto-switches between sources.
    *   **One command, fully automatic**: installs dependencies → installs Tavern → optionally guides you through the Tavern Helper, no babysitting required.
    *   Locked stable version: SillyTavern **v1.18.0**.
    *   Optional Tavern Helper add-on included.
    *   Perfect for playing anywhere on your phone.

## 🚀 Installation (first time)

### 📱 Step 1: Install Termux (required, takes 30 seconds)

**You must install Termux on your Android phone first** (Tavern can't run without it). Pick one method:

**Method 1 (official, recommended)**: open the official download page in your browser:
`https://f-droid.org/packages/com.termux/`
Scroll down to the version list and tap **Download APK** next to the latest version. No need to install the F-Droid client.

**Method 2 (GitHub, backup)**:
`https://github.com/termux/termux-app/releases`
Download and install the file named `termux-app_v0.118.x+apt-android-7-github-debug_universal.apk`.

> ⚠️ **Note**: do NOT use the old Termux from Google Play (it won't work)!
> Once installed, run `pkg --version` in Termux — if it prints a version, you're good to go.

### 📱 Step 2: One-click deploy (fully automatic)

Open Termux, **pick one command based on your network**, paste it, press Enter, and wait for it to finish:

**No VPN (mainland China network)**:
```bash
curl -fsSL https://gitee.com/mosaicb/Nikki-SillyTavern-Termux/raw/main/install_termux.sh | bash
```

**With VPN**:
```bash
curl -fsSL https://raw.githubusercontent.com/mosaicbear/Nikki-SillyTavern-Termux/main/install_termux.sh | bash
```

The script will automatically:
1. Switch to China mirror + install dependencies (git / node / curl)
2. Download the Tavern core v1.18.0 (China mirror first, auto-falls back to overseas)

> After install, start the tavern: `cd ~/SillyTavern && ./start.sh`, then open `http://127.0.0.1:8000` in your browser.

---

## 🎀 Tavern Helper (optional)

Tavern Helper is an enhancement plugin that buffs your Tavern. Supported out of the box by the one-click pack.

The command above only installs the Tavern core. **To also install Tavern Helper**, run this form instead (a menu will pop up):
```bash
bash -c "$(curl -fsSL https://gitee.com/mosaicb/Nikki-SillyTavern-Termux/raw/main/install_termux.sh)"
```
In the menu choose `[1] Install Tavern Helper`. After install, enable it in the Tavern "Extensions" panel.

> Skipping it is fine — the Tavern core works right after install.

---

## 🌐 Dual-source explanation

Every download in the script has **domestic + overseas dual sources**, all **official upstream sources**, auto-switching:

| Item | Domestic source (priority) | Overseas source (fallback) |
|------|---------------------------|---------------------------|
| Tavern core | Gitee mirror `gitee.com/mirrors/sillytavern` | GitHub official `SillyTavern/SillyTavern` |
| Tavern Helper | GitLab official `gitlab.com/novi028/JS-Slash-Runner` | GitHub official `N0VI028/JS-Slash-Runner` |
| npm deps | npmmirror | npm official |
| Termux packages | Tsinghua mirror | official source |

On a mainland China network it prefers Gitee/GitLab and auto-falls back to GitHub. No manual work needed.

## 💖 How to start / restart the tavern (daily use)

1. **Open Termux**.
2. **Enter the tavern directory**:
    ```bash
    cd ~/SillyTavern
    ```
3. **Start the tavern**:
    ```bash
    ./start.sh
    ```
4. **Start playing**: visit `http://127.0.0.1:8000` on your phone browser.

---

## 🗑️ Uninstall & backup (quitting / reinstalling / afraid of losing chat logs)

### 💾 Back up chat logs first (strongly recommended)

Your chat logs, character cards and settings all live in `~/SillyTavern/data`. To keep your records, back it up first:

1. Grant storage access (once): `termux-setup-storage`, then restart Termux
2. Pack a backup to phone storage:
   ```bash
   tar -czf ~/storage/shared/sillytavern_backup.tar.gz -C ~/SillyTavern data
   ```
   Then find `sillytavern_backup.tar.gz` in your phone's "Files" and save it to your PC/cloud drive for safety.

### 🧹 Remove only Tavern, keep the Termux environment

```bash
rm -rf ~/SillyTavern
```
Reinstall later by simply re-running the one-click deploy command above.

### ☠️ Full uninstall (wipes Termux too)

Tavern lives inside Termux's data directory, so **uninstalling the Termux app wipes the tavern + chat logs + the whole environment**:
Android Settings → Apps → Termux → Uninstall

> ⚠️ If you want to keep your records, **make the backup above FIRST** — don't realize it after it's gone.

### ♻️ Full flow: backup → uninstall → reinstall → restore

1. **Backup**: run the `tar` command above, confirm `sillytavern_backup.tar.gz` exists
2. **Uninstall** Termux (Android Settings → Apps → Termux → Uninstall)
3. **Reinstall** Termux (see Step 1 above)
4. **Deploy** Tavern (see Step 2 above, run the one-click command)
5. **Restore**:
   ```bash
   cd ~/SillyTavern && tar -xzf ~/storage/shared/sillytavern_backup.tar.gz
   ```
6. Restart the tavern and your chat logs are back!

---

## 📁 What's in this repo

| File | What it does |
|------|-------------|
| `install_termux.sh` | Android Termux one-click deploy (automatic: deps + Tavern core + optional Tavern Helper) |
| `plugins/README.md` | One-click pack intro (core + Tavern Helper) |
| `patch/mark-inject.js` | Optional tool: adds an "open-source free · join QQ if scammed" watermark to the Tavern page (when you want to share with friends, run `node patch/mark-inject.js`) |
| `FAQ-用户版.md` | FAQ for users (Chinese, beginner-friendly: install errors / crashes / uninstall) |
| `FAQ-团队版.md` | Internal maintainer manual (Chinese: version history + root causes + release flow) |

---

## 🕳️ FAQ (read this before asking)

**Install too slow?** The script auto-switches to the Tsinghua mirror. Manual: `echo 'deb https://mirrors.tuna.tsinghua.edu.cn/termux/apt/termux-main stable main' > $PREFIX/etc/apt/sources.list && pkg update`

**Getting a CANNOT LINK error?** Your phone's packages are out of sync. Run: `apt update && apt full-upgrade -y`, then re-run the deploy.

**No Tavern Helper menu after install?** Piped install can't prompt interactively. Use: `bash -c "$(curl -fsSL https://gitee.com/mosaicb/Nikki-SillyTavern-Termux/raw/main/install_termux.sh)"`, choose `1`.

More questions: read `FAQ-用户版.md`, or join the QQ group below.

---

## 💖 Join us

Stuck on something or want to chat? Join our QQ group!

**QQ group: 778585992**

---

Enjoy and have fun! 💖
