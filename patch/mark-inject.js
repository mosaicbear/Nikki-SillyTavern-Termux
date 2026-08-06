// ═══════════════════════════════════════════════════════════════════
//  mark-inject.js · 羽蝉NIKKI 酒馆定制标记注入器
//  在酒馆 index.html 的 </body> 前注入定制标记（水印+声明）
//  开源程序 · 仅供学习交流使用 · 完全免费
//  如果收费，恭喜你被骗了。请联络 QQ 群获取正确渠道。
// ═══════════════════════════════════════════════════════════════════
const fs = require('fs');
const path = require('path');

const TARGET = path.join(__dirname, '..', 'SillyTavern', 'public', 'index.html');
// 若脚本被复制到别处，支持 --target 参数
const argTarget = process.argv.find(a => a.startsWith('--target='));
const FILE = argTarget ? argTarget.split('=')[1] : TARGET;

// 定制标记（改这里即可）
const MARKER = `<!-- ══ 羽蝉NIKKI 定制标记 · 开源仅供学习交流 ══ -->
<style>
  #NIKKI_BADGE{position:fixed;bottom:6px;left:50%;transform:translateX(-50%);z-index:99999;
    background:rgba(0,0,0,.55);color:#fff;font-size:10px;padding:2px 10px;border-radius:20px;
    letter-spacing:.5px;pointer-events:none;white-space:nowrap;opacity:.75;backdrop-filter:blur(4px)}
</style>
<div id="NIKKI_BADGE">羽蝉NIKKI · 开源程序 · 仅供学习交流 · 完全免费 · 如果收费，恭喜你被骗了 · QQ群 778585992 获取正确渠道</div>
<!-- ══ 羽蝉NIKKI 定制标记结束 ══ -->`;

if (!fs.existsSync(FILE)) {
  console.error('[!] 未找到 index.html:', FILE);
  console.error('    用法: node mark-inject.js --target=/path/to/SillyTavern/public/index.html');
  process.exit(1);
}

let html = fs.readFileSync(FILE, 'utf8');

// 幂等：已注入则跳过
if (html.includes('NIKKI_BADGE')) {
  console.log('[*] 定制标记已存在，跳过。');
  process.exit(0);
}

// 注入到 </body> 前
if (html.includes('</body>')) {
  html = html.replace('</body>', MARKER + '\n</body>');
} else {
  // 兜底：追加到文件末尾
  html += '\n' + MARKER + '\n';
}

fs.writeFileSync(FILE, html, 'utf8');
console.log('[✔] 定制标记注入完成:', FILE);
console.log('    开源程序 · 仅供学习交流使用 · 完全免费');
console.log('    如果收费，恭喜你被骗了。QQ 群获取正确渠道。');
