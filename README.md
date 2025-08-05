# Claude Code カスタムセットアップテンプレート v0.1

## 概要
- **作成日**: 2025-08-05
- **目的**: Claude Codeのカスタム設定を一括でセットアップ
- **機能**: デンジャラスモード設定 + サブエージェント一括導入
- **対応OS**: Windows, Linux, macOS
- **使用技術**: PowerShell, Bash, Claude Code設定

## 設定内容

### 1. デンジャラスモード設定
- `.claude.json`の`allowedTools`を`["*"]`に設定
- PowerShell/Bashで`cdg`コマンドを追加
- `claude --dangerously-skip-permissions`の短縮実行

### 2. サブエージェント一括導入
- **Personal agents** (4体): WSL環境 `~/.claude/agents/`
  - code-reviewer, db-analyzer, gemini-bridge, task-agent
- **Project agents** (8体): プロジェクト環境 `.claude/agents/`  
  - agents-manager, doc-writer, doc-reader, endless-tawaimonai,
  - problem-sleuth-engineer, rule-manager, softengineer-expert, task-splitter

### 3. 統合セットアップ
- 一括でデンジャラスモード + サブエージェントをセットアップ
- 複数PC間での設定同期が可能

## セットアップ手順

### 🚀 統合セットアップ（推奨）

#### Windows (PowerShell)
```powershell
# 全機能を一括セットアップ（実行ポリシー自動設定付き）
.\setup-all.ps1
```

#### Linux/macOS (Bash)
```bash
# 全機能を一括セットアップ
./setup-all.sh
```

#### 完全自動セットアップ
```bash
# どこからでも一発セットアップ
git clone https://github.com/muumuu8181/2025-08-05-claude-code-dangerous-mode-setup.git
cd 2025-08-05-claude-code-dangerous-mode-setup

# Windows
.\setup-all.ps1

# Linux/macOS  
./setup-all.sh
```

### 📦 個別セットアップ

#### デンジャラスモードのみ
```powershell
# PowerShell
.\setup-cdg.ps1

# Bash
./setup-cdg.sh
```

#### サブエージェントのみ
```powershell
# PowerShell - 全エージェント
.\setup-agents.ps1 -All

# PowerShell - Personal agentsのみ
.\setup-agents.ps1 -Personal

# PowerShell - Project agentsのみ  
.\setup-agents.ps1 -Project

# Bash
./setup-agents.sh all        # 全エージェント
./setup-agents.sh personal   # Personal agentsのみ
./setup-agents.sh project    # Project agentsのみ
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
2025-08-05-claude-code-custom-setup/
├── README.md                    # このファイル
├── SETUP_GUIDE.md              # 詳細セットアップガイド  
├── setup-all.ps1               # 統合セットアップスクリプト (Windows)
├── setup-all.sh                # 統合セットアップスクリプト (Linux/macOS)
├── setup-cdg.ps1               # デンジャラスモード設定スクリプト
├── setup-cdg.sh                # デンジャラスモード設定スクリプト (Bash)
├── setup-agents.ps1            # サブエージェント設定スクリプト
├── setup-agents.sh             # サブエージェント設定スクリプト (Bash)
├── agents/
│   ├── personal/               # Personal agents テンプレート (4体)
│   │   ├── code-reviewer.md
│   │   ├── db-analyzer.md
│   │   ├── gemini-bridge.md
│   │   └── task-agent.md
│   └── project/                # Project agents テンプレート (8体)
│       ├── agents-manager.md
│       ├── doc-reader.md
│       ├── doc-writer.md
│       ├── endless-tawaimonai.md
│       ├── problem-sleuth-engineer.md
│       ├── rule-manager.md
│       ├── softengineer-expert.md
│       └── task-splitter.md
├── LICENSE                     # MITライセンス
└── .gitignore                  # Git無視設定

```

## 注意事項

⚠️ **警告**: デンジャラスモードは安全性制約を無効化します
- システムファイルの変更
- ネットワーク操作
- 外部コマンド実行
これらが自動で許可されるため、注意して使用してください。

## バージョン履歴

- **v0.1** (2025-08-05): 初回リリース
  - デンジャラスモード設定（PowerShell/Bash対応）
  - サブエージェント一括セットアップ（12体）
  - 統合セットアップスクリプト
  - Personal agents / Project agents 分離対応

## ライセンス

MIT License