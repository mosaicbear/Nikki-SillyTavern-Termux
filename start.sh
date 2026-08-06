#!/data/data/com.termux/files/usr/bin/bash
# ═══════════════════════════════════════════════════════════════════
#  羽蝉NIKKI · 酒馆一键启动 (Termux)
#  开源程序 · 仅供学习交流使用 · 完全免费
#  如果收费，恭喜你被骗了。请联络 QQ 群获取正确渠道。
# ═══════════════════════════════════════════════════════════════════

set -e
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; PINK='\033[1;35m'; NC='\033[0m'
ST_DIR="$HOME/SillyTavern"

echo -e "${PINK}"
echo "  ┌────────────────────────────────────────────┐"
echo "  │   ✨ 羽蝉NIKKI · 酒馆启动器 ✨             │"
echo "  │   开源 · 免费 · 仅供学习交流               │"
echo "  │   如果收费，恭喜你被骗了。QQ 群找正确渠道   │"
echo "  └────────────────────────────────────────────┘"
echo -e "${NC}"

if [ ! -d "$ST_DIR" ]; then
  echo -e "${YELLOW}[!] 未检测到酒馆，请先运行 install_termux.sh 部署${NC}"
  read -p "是否立即部署? (y/n): " ans
  if [ "$ans" = "y" ] || [ "$ans" = "Y" ]; then
    bash "$(dirname "$0")/install_termux.sh"
  else
    exit 1
  fi
fi

cd "$ST_DIR"
echo -e "${CYAN}[*] 启动酒馆...${NC}"
echo -e "${CYAN}    浏览器访问 http://127.0.0.1:8000${NC}"
echo -e "${YELLOW}    保持本终端运行，关闭即停止${NC}"
bash start.sh
