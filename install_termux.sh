#!/data/data/com.termux/files/usr/bin/bash
# ═══════════════════════════════════════════════════════════════════
#  💖 羽蝉NIKKI一键化酒馆部署 💖 (Termux 版 v3.0)
#  开源程序 · 仅供学习交流使用 · 完全免费
#  如果收费，恭喜你被骗了。请联络 QQ 群获取正确渠道。
#  QQ群：778585992
# ═══════════════════════════════════════════════════════════════════

# ── 基本设置 ──
set -u
PINK='\033[1;35m'; CYAN='\033[1;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'

# ── 常量 ──
ST_VERSION="1.18.0"                                    # 酒馆锁定版本
ST_DIR="$HOME/SillyTavern"                            # 酒馆安装目录
EXT_DIR="$ST_DIR/public/scripts/extensions/third-party" # 插件全局目录
QQ_GROUP="778585992"

# ── 双源配置（原作者官方源：国内 Gitee/GitLab 优先，国外 GitHub 兜底）──
# 酒馆本体（官方：Gitee 极速下载镜像 / GitHub 官方）
ST_GITEE="https://gitee.com/mirrors/sillytavern.git"
ST_GITHUB="https://github.com/SillyTavern/SillyTavern.git"
# 酒馆助手（作者官方：GitLab / GitHub）
HELPER_GITEE="https://gitlab.com/novi028/JS-Slash-Runner.git"
HELPER_GITHUB="https://github.com/N0VI028/JS-Slash-Runner.git"
# 记忆插件 yuzuki-Memory（作者官方：Gitee / GitHub）
MEMORY_GITEE="https://gitee.com/gaigai315/yuzuki-Memory.git"
MEMORY_GITHUB="https://github.com/gaigai315/yuzuki-Memory.git"
# npm 源
NPM_CN="https://registry.npmmirror.com"
NPM_FOREIGN="https://registry.npmjs.org"
# Termux pkg 源
PKG_CN="https://mirrors.tuna.tsinghua.edu.cn/termux/apt/termux-main"
PKG_FOREIGN="https://packages.termux.dev/apt/termux-main"

banner() {
  echo ""
  echo -e "${PINK}  ╔══════════════════════════════════════════════════╗${NC}"
  echo -e "${PINK}  ║    ✨ 羽蝉NIKKI一键化酒馆部署 ✨ (Termux)      ║${NC}"
  echo -e "${PINK}  ╠══════════════════════════════════════════════════╣${NC}"
  echo -e "${PINK}  ║  开源程序 · 仅供学习交流使用 · 完全免费          ║${NC}"
  echo -e "${PINK}  ║  如果收费，恭喜你被骗了。                        ║${NC}"
  echo -e "${PINK}  ║  QQ群 ${QQ_GROUP} 获取正确渠道                   ║${NC}"
  echo -e "${PINK}  ╚══════════════════════════════════════════════════╝${NC}"
  echo ""
}

show_menu() {
  echo ""
  echo -e "${CYAN}  请选择要执行的操作：${NC}"
  echo ""
  echo -e "  ${GREEN}[1]${NC} 安装酒馆纯净版 v${ST_VERSION}"
  echo -e "  ${GREEN}[2]${NC} 一键安装（酒馆 + 酒馆助手）"
  echo -e "  ${GREEN}[3]${NC} 单独安装酒馆助手"
  echo -e "  ${GREEN}[4]${NC} 安装记忆插件 yuzuki-Memory"
  echo -e "  ${GREEN}[5]${NC} 退出"
  echo ""
  echo -e "${YELLOW}  遇到问题？加 QQ 群 ${QQ_GROUP} 求助~${NC}"
  echo ""
}

# ── Termux 环境检测 ──
check_termux() {
  if [ ! -d "/data/data/com.termux" ]; then
    echo -e "${RED}[!] 此脚本仅支持 Termux 环境（Android 手机）${NC}"
    echo ""
    echo -e "${YELLOW}  安装 Termux 的方法（任选一个）：${NC}"
    echo -e "${CYAN}  方法1（度盘直下，国内最快）：${NC}"
    echo -e "    链接：https://pan.baidu.com/s/1kTzCuyEMkPd5qFR1RUfDtw?pwd=xyxy"
    echo -e "    提取码：xyxy"
    echo -e "    下载完点开安装，安卓提示允许未知来源就点允许"
    echo -e "${CYAN}  方法2（官方直装，备选）：${NC}"
    echo -e "    https://f-droid.org/zh_Hans/packages/com.termux/"
    echo -e "    拉到版本列表，点最新版旁边 Download APK，不用装 F-Droid 客户端"
    echo -e "${CYAN}  方法3（GitHub，最后备选）：${NC}"
    echo -e "    https://github.com/termux/termux-app/releases"
    echo -e "    找 termux-app_v0.118.x+apt-android-7-github-debug_universal.apk 下载"
    echo ""
    echo -e "${RED}[!] 装好 Termux 后重新运行本脚本即可${NC}"
    echo -e "${YELLOW}  注意：千万别用 Google Play 商店的旧版 Termux，会跑不起来${NC}"
    exit 1
  fi
}

# ── 检测命令存在 ──
need_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo -e "${YELLOW}[!] 缺少命令: $1，正在安装依赖...${NC}"
    pkg install -y git nodejs-lts nano curl
  fi
}

# ── 配置 Termux pkg 国内源（国内优先，双向兜底）──
setup_pkg_source() {
  echo -e "${CYAN}[*] 检查 Termux 软件源（国内优先）...${NC}"
  # 快速测清华镜像源是否可达（3秒超时）
  if curl -s --max-time 3 -o /dev/null "$PKG_CN/dists/stable/InRelease" 2>/dev/null; then
    if grep -q "mirrors.tuna.tsinghua.edu.cn" "$PREFIX/etc/apt/sources.list" 2>/dev/null; then
      echo -e "${GREEN}    已使用国内源（清华镜像）${NC}"
    else
      sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/apt/termux-main stable main@' "$PREFIX/etc/apt/sources.list" 2>/dev/null || true
      echo -e "${GREEN}    已切换为国内源（清华镜像）${NC}"
    fi
  else
    echo -e "${YELLOW}[*] 国内源不可用，保留官方源...${NC}"
    if ! curl -s --max-time 3 -o /dev/null "$PKG_FOREIGN/dists/stable/InRelease" 2>/dev/null; then
      echo -e "${RED}[!] 国内源和官方源都连不上${NC}"
      echo -e "${YELLOW}    请自行挂梯子（魔法）重试，若仍失败请加 QQ 群 ${QQ_GROUP} 询问${NC}"
    else
      echo -e "${GREEN}    官方源可用${NC}"
    fi
  fi
  echo -e "${GREEN}    软件源就绪${NC}"
}

# ── 双源 git clone（先国内后国外自动切换）──
clone_repo() {
  local name="$1" cn_url="$2" foreign_url="$3" dest="$4"
  echo -e "${CYAN}[*] 拉取 ${name}...${NC}"
  if git clone --depth 1 "$cn_url" "$dest" 2>/dev/null; then
    echo -e "${GREEN}    使用国内源 (Gitee) 成功${NC}"
    return 0
  fi
  echo -e "${YELLOW}[*] 国内源失败，切换国外源 (GitHub)...${NC}"
  if git clone --depth 1 "$foreign_url" "$dest" 2>/dev/null; then
    echo -e "${GREEN}    使用国外源 (GitHub) 成功${NC}"
    return 0
  fi
  echo -e "${RED}[!] 两个源都失败了，请检查网络后再试${NC}"
  return 1
}

# ── 配置 npm 国内源（失败自动切国外）──
setup_npm_source() {
  echo -e "${CYAN}[*] 配置 npm 镜像源...${NC}"
  if curl -s --max-time 5 -o /dev/null "$NPM_CN" 2>/dev/null; then
    npm config set registry "$NPM_CN"
    echo -e "${GREEN}    使用国内 npm 源 (npmmirror)${NC}"
  else
    npm config set registry "$NPM_FOREIGN"
    echo -e "${YELLOW}    使用官方 npm 源${NC}"
  fi
}

# ── 安装酒馆本体（纯净版）──
install_tavern() {
  if [ -d "$ST_DIR/.git" ]; then
    echo -e "${CYAN}[*] 检测到酒馆已存在，检查版本...${NC}"
    cd "$ST_DIR"
    local cur_ver
    cur_ver=$(git describe --tags 2>/dev/null || echo "unknown")
    echo -e "${GREEN}    当前版本: ${cur_ver}${NC}"
    if [ "$cur_ver" != "$ST_VERSION" ]; then
      echo -e "${YELLOW}[*] 非目标版本，切换至 v${ST_VERSION}...${NC}"
      git fetch --depth 1 origin "refs/tags/$ST_VERSION:refs/tags/$ST_VERSION" 2>/dev/null || git fetch origin 2>/dev/null
      git checkout "$ST_VERSION" 2>/dev/null && echo -e "${GREEN}    已切换至 v${ST_VERSION}${NC}" || echo -e "${RED}    版本切换失败，请检查网络${NC}"
    fi
    return 0
  fi

  echo -e "${CYAN}[1/3] 拉取酒馆代码 (v${ST_VERSION})...${NC}"
  if ! clone_repo "酒馆本体" "$ST_GITEE" "$ST_GITHUB" "$ST_DIR"; then
    return 1
  fi
  cd "$ST_DIR"
  git checkout "$ST_VERSION" 2>/dev/null && echo -e "${GREEN}    已锁定 v${ST_VERSION}${NC}" || echo -e "${YELLOW}    版本锁定失败，将使用默认分支${NC}"
  return 0
}

# ── 安装酒馆助手 ──
install_helper() {
  local dest="$EXT_DIR/JS-Slash-Runner"
  if [ ! -d "$ST_DIR" ]; then
    echo -e "${RED}[!] 未检测到酒馆，请先执行选项 [1] 或 [2]${NC}"
    return 1
  fi
  if [ -d "$dest/.git" ]; then
    echo -e "${GREEN}[*] 酒馆助手已安装，拉取最新...${NC}"
    cd "$dest" && git pull 2>/dev/null || true
    return 0
  fi
  echo -e "${CYAN}[*] 安装酒馆助手 (Tavern Helper)...${NC}"
  mkdir -p "$EXT_DIR"
  if clone_repo "酒馆助手" "$HELPER_GITEE" "$HELPER_GITHUB" "$dest"; then
    echo -e "${GREEN}    酒馆助手安装完成${NC}"
    echo -e "${YELLOW}    ⚠ 首次使用请到酒馆【扩展】面板勾选启用「酒馆助手」${NC}"
  fi
}

# ── 安装记忆插件 ──
install_memory() {
  local dest="$EXT_DIR/yuzuki-Memory"
  if [ ! -d "$ST_DIR" ]; then
    echo -e "${RED}[!] 未检测到酒馆，请先执行选项 [1] 或 [2]${NC}"
    return 1
  fi
  if [ -d "$dest/.git" ]; then
    echo -e "${GREEN}[*] 记忆插件已安装，拉取最新...${NC}"
    cd "$dest" && git pull 2>/dev/null || true
    return 0
  fi
  echo -e "${CYAN}[*] 安装记忆插件 yuzuki-Memory...${NC}"
  mkdir -p "$EXT_DIR"
  if clone_repo "记忆插件" "$MEMORY_GITEE" "$MEMORY_GITHUB" "$dest"; then
    echo -e "${GREEN}    记忆插件安装完成${NC}"
    echo -e "${YELLOW}    ⚠ 首次使用请到酒馆【扩展】面板勾选启用「yuzuki-Memory」${NC}"
  fi
}

# ── 安装依赖 ──
install_deps() {
  echo -e "${CYAN}[2/3] 安装酒馆依赖 (npm install)...${NC}"
  setup_npm_source
  cd "$ST_DIR"
  if [ ! -d "node_modules" ]; then
    if ! npm install --no-audit --no-fund 2>/dev/null; then
      echo -e "${YELLOW}[*] npm install 失败，可能是网络问题，重试官方源...${NC}"
      npm config set registry "$NPM_FOREIGN"
      npm install --no-audit --no-fund 2>/dev/null || {
        echo -e "${RED}[!] npm install 失败${NC}"
        echo -e "${YELLOW}    请加 QQ 群 ${QQ_GROUP} 求助${NC}"
        return 1
      }
    fi
  fi
  echo -e "${GREEN}    依赖就绪${NC}"
}

# ── 完成提示 ──
finish() {
  echo ""
  echo -e "${PINK}════════════════════════════════════════════════════${NC}"
  echo -e "${PINK}  🎉 恭喜小仙女！羽蝉NIKKI酒馆部署完成！ 🎉${NC}"
  echo -e "${PINK}════════════════════════════════════════════════════${NC}"
  echo ""
  echo -e "${CYAN}  启动酒馆:${NC}"
  echo -e "    cd ~/SillyTavern && ./start.sh"
  echo -e "${CYAN}  浏览器访问:${NC}"
  echo -e "    http://127.0.0.1:8000"
  echo -e "${YELLOW}  开源程序 · 仅供学习交流 · 完全免费${NC}"
  echo -e "${YELLOW}  如果收费，恭喜你被骗了。QQ 群 ${QQ_GROUP} 获取正确渠道。${NC}"
  echo ""
}

# ── 主流程 ──
banner
check_termux

# 先配好软件源，再装依赖（保证 pkg install 时源可用）
setup_pkg_source

# 首次进入先确保基础命令存在
need_cmd git
need_cmd node
need_cmd curl

while true; do
  show_menu
  echo -n "  请输入选项 [1-5]: "
  read -r choice
  case "$choice" in
    1)
      setup_pkg_source
      if install_tavern; then install_deps; fi
      finish
      ;;
    2)
      setup_pkg_source
      if install_tavern; then
        install_deps
        install_helper
      fi
      finish
      ;;
    3)
      setup_pkg_source
      install_helper
      ;;
    4)
      setup_pkg_source
      install_memory
      ;;
    5)
      echo -e "${GREEN}  再见啦，比心~ ${NC}"
      exit 0
      ;;
    *)
      echo -e "${RED}  无效选项，请重新输入${NC}"
      ;;
  esac
done
