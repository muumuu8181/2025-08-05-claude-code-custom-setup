#!/bin/bash
# Claude Code デンジャラスモード自動セットアップスクリプト (Bash版)
# Version: 0.1
# Date: 2025-08-05

echo "=== Claude Code デンジャラスモード設定 v0.1 (Bash版) ==="
echo ""

# 色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# 1. .bashrcにcdgエイリアスを追加
echo -e "${YELLOW}[1/2] .bashrcにcdgエイリアスを追加中...${NC}"

# cdgエイリアスが既に存在するかチェック
if grep -q "alias cdg=" ~/.bashrc; then
    echo -e "${YELLOW}  cdgエイリアスは既に存在します${NC}"
else
    # cdgエイリアスを追加
    cat >> ~/.bashrc << 'EOF'

# Claude Code デンジャラスモードエイリアス (追加日: $(date +%Y-%m-%d))
alias cdg="claude --dangerously-skip-permissions"
EOF
    echo -e "${GREEN}  cdgエイリアスを.bashrcに追加しました${NC}"
fi

# 2. .bashrcを再読み込み
echo -e "${YELLOW}[2/2] .bashrcを再読み込み中...${NC}"
source ~/.bashrc
echo -e "${GREEN}  .bashrcの再読み込みが完了しました${NC}"

echo ""
echo -e "${CYAN}=== セットアップ完了 ===${NC}"
echo ""
echo -e "${NC}動作確認:${NC}"
echo -e "${YELLOW}  cdg --version    # デンジャラスモードでClaude Codeのバージョン確認${NC}"
echo -e "${YELLOW}  cdg              # デンジャラスモードでClaude Code起動${NC}"
echo ""
echo -e "${RED}注意事項:${NC}"
echo -e "${RED}  デンジャラスモードは安全性制約を無効化します${NC}"
echo -e "${RED}  システムファイルの変更やネットワーク操作が自動許可されます${NC}"
echo ""

# cdgエイリアスが利用可能か確認
if command -v cdg &> /dev/null; then
    echo -e "${GREEN}✓ cdg コマンドが正常に設定されました${NC}"
else
    echo -e "${RED}✗ cdg コマンドの設定に問題があります${NC}"
    echo -e "${YELLOW}  新しいシェルセッションを開始してから再度お試しください${NC}"
fi

echo ""
echo -e "${CYAN}Claude設定ファイルの手動設定が必要です:${NC}"
echo -e "${YELLOW}  ~/.claude.json の allowedTools を ['*'] に設定してください${NC}"