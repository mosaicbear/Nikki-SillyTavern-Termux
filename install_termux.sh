#!/data/data/com.termux/files/usr/bin/bash
# ═══════════════════════════════════════════════════════════════════
#  💖 羽蝉NIKKI一键化酒馆部署 💖 (Termux 版 v2.0)
#  开源程序 · 仅供学习交流使用 · 完全免费
#  如果收费，恭喜你被骗了。请联络 QQ 群获取正确渠道。
# ═══════════════════════════════════════════════════════════════════

set -e
PINK='\033[1;35m'; CYAN='\033[1;36m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'

# ── 常量 ──
ST_URL="https://github.com/SillyTavern/SillyTavern.git"
ST_BRANCH="release"
ST_DIR="$HOME/SillyTavern"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
QQ_GROUP="778585992"

banner() {
  echo ""
  echo -e "${PINK}  ╔══════════════════════════════════════════════════╗${NC}"
  echo -e "${PINK}  ║    ✨ 羽蝉NIKKI一键化酒馆部署 ✨ (Termux)      ║${NC}"
  echo -e "${PINK}  ╠══════════════════════════════════════════════════╣${NC}"
  echo -e "${PINK}  ║  开源程序 · 仅供学习交流使用 · 完全免费          ║${NC}"
  echo -e "${PINK}  ║  如果收费，恭喜你被骗了。                        ║${NC}"
  echo -e "${PINK}  ║  QQ 群 ${QQ_GROUP} 获取正确渠道                  ║${NC}"
  echo -e "${PINK}  ╚══════════════════════════════════════════════════╝${NC}"
  echo ""
}

check_termux() {
  if [ ! -d "/data/data/com.termux" ]; then
    echo -e "${RED}[!] 此脚本仅支持 Termux 环境（Android 手机）${NC}"
    echo -e "${YELLOW}请先安装 Termux: https://f-droid.org/repo/com.termux.apk${NC}"
    echo -e "${YELLOW}不要用 Play 商店旧版哦，会跑不起来的~${NC}"
    exit 1
  fi
}

install_deps() {
  echo -e "${CYAN}🌸 Step 1/5: 更新软件包 + 安装小工具~${NC}"
  pkg update -y
  pkg install -y git nodejs-lts nano curl
  echo -e "${GREEN}    小工具准备好咯！${NC}"
}

install_tavern() {
  if [ -d "$ST_DIR/.git" ]; then
    echo -e "${CYAN}🌸 Step 2/5: 发现酒馆已经在了，拉取最新更新~${NC}"
    cd "$ST_DIR"
    git pull origin "$ST_BRANCH"
  else
    echo -e "${CYAN}🌸 Step 2/5: 从魔法世界召唤酒馆 (release 版)...${NC}"
    git clone -b "$ST_BRANCH" "$ST_URL" "$ST_DIR"
    cd "$ST_DIR"
  fi
  echo -e "${GREEN}    酒馆就位！${NC}"
}

install_plugins() {
  echo -e "${CYAN}🌸 Step 3/5: 预置热门插件配置...${NC}"
  mkdir -p "$ST_DIR/plugins"
  echo "    插件将在首次启动后通过酒馆『扩展→插件市场』安装"
  echo "    推荐插件清单见项目 plugins/README.md"
  echo -e "${GREEN}    插件配置就绪！${NC}"
}

apply_patch() {
  echo -e "${CYAN}🌸 Step 4/5: 应用定制标记（水印）...${NC}"
  INJECT_JS="$SCRIPT_DIR/patch/mark-inject.js"
  if [ -f "$INJECT_JS" ]; then
    if ! grep -q "NIKKI_BADGE" "$ST_DIR/public/index.html" 2>/dev/null; then
      node "$INJECT_JS" --target="$ST_DIR/public/index.html" && \
        echo -e "${GREEN}    定制标记完成${NC}" || \
        echo -e "${YELLOW}    标记注入失败（可手动执行 mark-inject.js）${NC}"
    else
      echo -e "${GREEN}    定制标记已存在，跳过${NC}"
    fi
  else
    echo -e "${YELLOW}    mark-inject.js 缺失，跳过水印${NC}"
  fi
}

setup_node_modules() {
  echo -e "${CYAN}🌸 Step 5/5: 摆放家具 (npm install)...${NC}"
  cd "$ST_DIR"
  if [ ! -d "node_modules" ]; then
    npm install --no-audit --no-fund
  fi
  echo -e "${GREEN}    家具摆好啦！${NC}"
}

finish() {
  echo ""
  echo -e "${PINK}════════════════════════════════════════════════════${NC}"
  echo -e "${PINK}  🎉 恭喜小仙女！羽蝉NIKKI酒馆部署完成！ 🎉${NC}"
  echo -e "${PINK}════════════════════════════════════════════════════${NC}"
  echo ""
  echo -e "${CYAN}  启动咒语:${NC}"
  echo -e "    cd ~/SillyTavern && bash start.sh"
  echo -e "${CYAN}  秘密地址:${NC}"
  echo -e "    http://127.0.0.1:8000"
  echo -e "${YELLOW}  开源程序 · 仅供学习交流 · 完全免费${NC}"
  echo -e "${YELLOW}  如果收费，恭喜你被骗了。QQ 群 ${QQ_GROUP} 获取正确渠道。${NC}"
  echo ""
}

# ── 执行 ──
banner
check_termux
install_deps
install_tavern
install_plugins
apply_patch
setup_node_modules
finish
