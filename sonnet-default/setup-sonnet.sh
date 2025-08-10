#!/bin/bash
# Claude Code Sonnet固定設定スクリプト (Linux/WSL/macOS)
# 作成日: 2025-08-10
# 用途: Claude CodeのデフォルトモデルをSonnetに設定

echo "🚀 Claude Code Sonnet固定設定を開始します..."

CLAUDE_DIR="$HOME/.claude"
SETTINGS_FILE="$CLAUDE_DIR/settings.json"

# Claude設定フォルダの作成
if [ ! -d "$CLAUDE_DIR" ]; then
    echo "📁 Claude設定フォルダを作成中..."
    mkdir -p "$CLAUDE_DIR"
fi

# 既存設定の確認
if [ -f "$SETTINGS_FILE" ]; then
    echo "⚠️  既存の設定ファイルが見つかりました"
    echo "現在の設定:"
    cat "$SETTINGS_FILE"
    echo ""
    
    read -p "設定を上書きしますか？ (y/N): " overwrite
    if [[ ! "$overwrite" =~ ^[Yy]$ ]]; then
        echo "❌ 設定をキャンセルしました"
        exit 0
    fi
fi

# Sonnet設定の作成
echo "📝 Sonnet設定ファイルを作成中..."

cat > "$SETTINGS_FILE" << 'EOF'
{
  "model": "sonnet"
}
EOF

if [ $? -eq 0 ]; then
    echo "✅ 設定完了!"
    echo "設定ファイル: $SETTINGS_FILE"
    echo ""
    echo "📋 作成された設定:"
    cat "$SETTINGS_FILE"
    echo ""
    echo "🔄 Claude Codeを再起動すると、Sonnetが自動選択されます"
else
    echo "❌ 設定ファイルの作成に失敗しました"
    exit 1
fi

echo ""
echo "🎉 Claude Code Sonnet固定設定が完了しました！"