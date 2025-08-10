# Claude Code デフォルトモデル設定ガイド

## 概要
Claude Codeを起動時に自動的にSonnetモデルに設定する方法です。

## 問題
- 毎回起動時にOpusが選択されてしまう
- 毎回手動でSonnetに変更するのが面倒

## 解決方法

### 1. ユーザー設定ファイルの作成

#### Windows
```json
// ファイル: C:\Users\[ユーザー名]\.claude\settings.json
{
  "model": "sonnet"
}
```

#### Linux/WSL
```json
// ファイル: ~/.claude/settings.json  
{
  "model": "sonnet"
}
```

### 2. 自動設定スクリプト

#### Windows PowerShell
```powershell
# Sonnet固定設定スクリプト
$claudeDir = "$env:USERPROFILE\.claude"
$settingsFile = "$claudeDir\settings.json"

# フォルダ作成
if (!(Test-Path $claudeDir)) {
    New-Item -ItemType Directory -Path $claudeDir -Force
}

# 設定ファイル作成
$settings = @{
    model = "sonnet"
} | ConvertTo-Json

$settings | Out-File -FilePath $settingsFile -Encoding UTF8
Write-Host "✅ Sonnet固定設定完了: $settingsFile"
```

#### Bash (Linux/WSL/macOS)
```bash
#!/bin/bash
# Sonnet固定設定スクリプト

CLAUDE_DIR="$HOME/.claude"
SETTINGS_FILE="$CLAUDE_DIR/settings.json"

# フォルダ作成
mkdir -p "$CLAUDE_DIR"

# 設定ファイル作成
cat > "$SETTINGS_FILE" << 'EOF'
{
  "model": "sonnet"
}
EOF

echo "✅ Sonnet固定設定完了: $SETTINGS_FILE"
```

### 3. プロジェクト固有設定

特定のプロジェクトでだけSonnetを使いたい場合：

```json
// ファイル: [プロジェクトルート]/.claude/settings.json
{
  "model": "sonnet"
}
```

## 設定の優先順位

1. **プロジェクト設定** (`.claude/settings.json`)
2. **ローカル設定** (`.claude/settings.local.json`) 
3. **ユーザー設定** (`~/.claude/settings.json`)
4. **デフォルト設定** (Claude Code標準)

## 確認方法

1. Claude Codeを再起動
2. モデル表示を確認
3. Sonnetが選択されていればOK

## 他のモデルオプション

```json
{
  "model": "opus"          // Claude 3 Opus
  "model": "haiku"         // Claude 3 Haiku  
  "model": "sonnet"        // Claude 3.5 Sonnet (推奨)
}
```

## 注意点

- 設定ファイルはJSON形式（コメント不可）
- 間違った形式だと設定が読み込まれない
- プロジェクト設定が最優先される

## トラブルシューティング

### まだOpusになる場合
1. プロジェクト内に別の設定がないか確認
2. JSON形式が正しいか確認
3. Claude Codeを完全に再起動

### 設定ファイルの場所がわからない場合
```bash
# 現在の設定ファイルを探す
find ~ -name "settings.json" -path "*/.claude/*" 2>/dev/null
```

## 作成日
2025-08-10