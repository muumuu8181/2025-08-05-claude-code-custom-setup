# Claude Code デンジャラスモード設定テンプレート v0.1

## 概要
- **作成日**: 2025-08-05
- **目的**: Claude Codeのデンジャラスモード（`--dangerously-skip-permissions`）を`cdg`コマンドとして設定
- **使用技術**: PowerShell, Bash, Claude Code設定

## 設定内容

### 1. 設定ファイル変更
- `.claude.json`の`allowedTools`を`["*"]`に設定
- 全ツールの自動許可を有効化

### 2. PowerShellエイリアス設定
- `cdg`関数をPowerShellプロファイルに追加
- `claude --dangerously-skip-permissions`を短縮実行

### 3. WSL Bashエイリアス設定（オプション）
- `.bashrc`に`cdg`エイリアスを追加
- Linux環境での短縮実行

## セットアップ手順

### 自動セットアップ
```powershell
# PowerShellで実行
.\setup-cdg.ps1
```

### 手動セットアップ

#### 1. Claude設定ファイル編集
```json
// ~/.claude.json の projects section
"allowedTools": ["*"]
```

#### 2. PowerShellプロファイル設定
```powershell
# PowerShellプロファイルに追加
function cdg { claude --dangerously-skip-permissions @args }
```

#### 3. WSL Bash設定（オプション）
```bash
# ~/.bashrc に追加
alias cdg="claude --dangerously-skip-permissions"
```

## 使用方法

### 通常モード
```bash
claude
# → 許可プロンプトが表示される
```

### デンジャラスモード
```bash
cdg
# → 許可プロンプトをスキップして実行
```

## ファイル構成

```
2025-08-05-claude-code-dangerous-mode-setup/
├── README.md                    # このファイル
├── SETUP_GUIDE.md              # 詳細セットアップガイド
├── setup-cdg.ps1               # PowerShell自動セットアップスクリプト
├── setup-cdg.sh                # Bash自動セットアップスクリプト
├── templates/
│   ├── claude-config.json      # Claude設定テンプレート
│   └── powershell-profile.ps1  # PowerShellプロファイルテンプレート
└── docs/
    └── troubleshooting.md      # トラブルシューティング

```

## 注意事項

⚠️ **警告**: デンジャラスモードは安全性制約を無効化します
- システムファイルの変更
- ネットワーク操作
- 外部コマンド実行
これらが自動で許可されるため、注意して使用してください。

## バージョン履歴

- **v0.1** (2025-08-05): 初回リリース
  - PowerShell/Bash両対応
  - 自動セットアップスクリプト
  - 基本ドキュメント整備

## ライセンス

MIT License