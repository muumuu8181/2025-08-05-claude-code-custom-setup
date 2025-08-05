#!/bin/bash
# Claude Code サブエージェント自動セットアップスクリプト (Bash版)
# Version: 0.1
# Date: 2025-08-05

# 色定義
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

# 使用方法
usage() {
    echo -e "${YELLOW}使用方法:${NC}"
    echo -e "${GRAY}  ./setup-agents.sh personal    # Personal agentsのみセットアップ${NC}"
    echo -e "${GRAY}  ./setup-agents.sh project     # Project agentsのみセットアップ${NC}"
    echo -e "${GRAY}  ./setup-agents.sh all         # 全エージェントをセットアップ${NC}"
    echo ""
}

# 引数チェック
if [ $# -eq 0 ]; then
    echo -e "${CYAN}=== Claude Code サブエージェント セットアップ v0.1 ===${NC}"
    echo ""
    usage
    exit 1
fi

MODE=$1

echo -e "${CYAN}=== Claude Code サブエージェント セットアップ v0.1 ===${NC}"
echo ""

# Personal agents セットアップ
setup_personal() {
    echo -e "${YELLOW}[1/2] Personal agents をセットアップ中...${NC}"
    
    # Personal agentsディレクトリを作成
    mkdir -p ~/.claude/agents
    
    # Personal agentsをコピー
    personal_count=0
    for agent_file in agents/personal/*.md; do
        if [ -f "$agent_file" ]; then
            agent_name=$(basename "$agent_file")
            cp "$agent_file" ~/.claude/agents/
            echo -e "${GREEN}  ✓ $agent_name をコピーしました${NC}"
            ((personal_count++))
        fi
    done
    
    echo -e "${GREEN}  Personal agents: $personal_count 体のセットアップが完了${NC}"
}

# Project agents セットアップ
setup_project() {
    echo -e "${YELLOW}[2/2] Project agents をセットアップ中...${NC}"
    
    # 現在のプロジェクトの.claudeディレクトリを作成
    mkdir -p .claude/agents
    
    # Project agentsをコピー
    project_count=0
    for agent_file in agents/project/*.md; do
        if [ -f "$agent_file" ]; then
            agent_name=$(basename "$agent_file")
            cp "$agent_file" .claude/agents/
            echo -e "${GREEN}  ✓ $agent_name をコピーしました${NC}"
            ((project_count++))
        fi
    done
    
    echo -e "${GREEN}  Project agents: $project_count 体のセットアップが完了${NC}"
}

# 実行
case $MODE in
    "personal")
        setup_personal
        ;;
    "project")
        setup_project
        ;;
    "all")
        setup_personal
        setup_project
        ;;
    *)
        usage
        exit 1
        ;;
esac

echo ""
echo -e "${CYAN}=== セットアップ完了 ===${NC}"
echo ""
echo -e "${NC}セットアップされたエージェント:${NC}"

if [ "$MODE" = "personal" ] || [ "$MODE" = "all" ]; then
    echo ""
    echo -e "${CYAN}Personal agents (~/.claude/agents/):${NC}"
    for agent_file in agents/personal/*.md; do
        if [ -f "$agent_file" ]; then
            agent_name=$(basename "$agent_file" .md)
            echo -e "${GRAY}  • $agent_name${NC}"
        fi
    done
fi

if [ "$MODE" = "project" ] || [ "$MODE" = "all" ]; then
    echo ""
    echo -e "${CYAN}Project agents (.claude/agents/):${NC}"
    for agent_file in agents/project/*.md; do
        if [ -f "$agent_file" ]; then
            agent_name=$(basename "$agent_file" .md)
            echo -e "${GRAY}  • $agent_name${NC}"
        fi
    done
fi

echo ""
echo -e "${YELLOW}確認方法:${NC}"
echo -e "${GRAY}  claude /agents    # エージェント一覧を表示${NC}"
echo ""
echo -e "${YELLOW}使用方法:${NC}"
echo -e "${GRAY}  claude            # 通常起動後、エージェントを選択${NC}"
echo -e "${GRAY}  claude @エージェント名  # 直接エージェントを指定${NC}"