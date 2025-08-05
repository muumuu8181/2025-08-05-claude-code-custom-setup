#!/bin/bash
# Claude Code 統合セットアップスクリプト (Linux/macOS版)
# Version: 0.1
# Date: 2025-08-05

# 色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

echo -e "${CYAN}=== Claude Code 統合カスタムセットアップ v0.1 (Linux/macOS版) ===${NC}"
echo ""

echo -e "${NC}このスクリプトは以下をセットアップします:${NC}"
echo -e "${GRAY}  ✓ デンジャラスモード (cdg コマンド)${NC}"
echo -e "${GRAY}  ✓ サブエージェント (Personal: 4体, Project: 8体)${NC}"
echo ""

read -p "続行しますか？ (y/N): " confirmation
if [[ "$confirmation" != "y" && "$confirmation" != "Y" ]]; then
    echo -e "${YELLOW}セットアップをキャンセルしました${NC}"
    exit 0
fi

echo ""
echo -e "${CYAN}=== Step 1: デンジャラスモード設定 ===${NC}"
echo ""

if ./setup-cdg.sh; then
    echo ""
    echo -e "${GREEN}✓ デンジャラスモード設定が完了しました${NC}"
else
    echo -e "${RED}✗ デンジャラスモード設定でエラーが発生しました${NC}"
fi

echo ""
echo -e "${CYAN}=== Step 2: サブエージェント設定 ===${NC}"
echo ""

if ./setup-agents.sh all; then
    echo ""
    echo -e "${GREEN}✓ サブエージェント設定が完了しました${NC}"
else
    echo -e "${RED}✗ サブエージェント設定でエラーが発生しました${NC}"
fi

echo ""
echo -e "${CYAN}=== 統合セットアップ完了 ===${NC}"
echo ""

echo -e "${NC}設定されたコマンド:${NC}"
echo -e "${GRAY}  claude       # 通常モード${NC}"
echo -e "${GRAY}  cdg          # デンジャラスモード${NC}"
echo -e "${GRAY}  claude /agents  # エージェント一覧表示${NC}"
echo ""

echo -e "${NC}利用可能なエージェント:${NC}"
echo -e "${GRAY}  Personal agents (4体): code-reviewer, db-analyzer, gemini-bridge, task-agent${NC}"
echo -e "${GRAY}  Project agents (8体): agents-manager, doc-writer, doc-reader, endless-tawaimonai,${NC}"
echo -e "${GRAY}                        problem-sleuth-engineer, rule-manager, softengineer-expert, task-splitter${NC}"
echo ""

echo -e "${YELLOW}次の手順:${NC}"
echo -e "${GRAY}  1. 新しいシェルセッションを開始して cdg コマンドを有効化${NC}"
echo -e "${GRAY}  2. claude /agents でエージェント一覧を確認${NC}"
echo -e "${GRAY}  3. cdg でデンジャラスモードをテスト${NC}"
echo ""

echo -e "${GREEN}🎉 Claude Code のカスタムセットアップが完了しました！${NC}"

echo ""
echo -e "${YELLOW}注意: Claude設定ファイルの手動設定が必要です:${NC}"
echo -e "${GRAY}  ~/.claude.json の allowedTools を ['*'] に設定してください${NC}"