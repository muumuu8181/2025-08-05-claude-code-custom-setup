# Claude Code デンジャラスモード（cdg）設定手順

## 概要
Claude Codeの`--dangerously-skip-permissions`フラグを`cdg`コマンドとして設定し、常にデンジャラスモードで起動できるようにする手順。

## 前提条件
- Windows環境でWSL使用
- Claude Codeがインストール済み
- PowerShellまたはWSL bashでの操作

## 手順1: 設定ファイルでの永続化

### 1.1 Claude設定ファイルの編集
```bash
# ~/.claude.json を編集
# allowedTools を空配列から "*" に変更
"allowedTools": ["*"]
```

この設定により、全ツールが自動許可される。

## 手順2: PowerShellでのエイリアス設定

### 2.1 PowerShellプロファイルに関数を追加
```bash
# WSLからPowerShellプロファイルに関数を追加
powershell.exe -Command "echo 'function cdg { claude --dangerously-skip-permissions @args }' | Add-Content -Path \$PROFILE -Force"
```

### 2.2 PowerShellプロファイルの再読み込み
PowerShellで以下を実行：
```powershell
. $PROFILE
```

## 手順3: WSL bashでのエイリアス設定（オプション）

### 3.1 bashrcにエイリアス追加
```bash
echo 'alias cdg="claude --dangerously-skip-permissions"' >> ~/.bashrc
source ~/.bashrc
```

## 動作確認

### PowerShellでの確認
```powershell
PS C:\Users\user> cdg
# → Claude Codeがデンジャラスモードで起動
```

### WSL bashでの確認
```bash
$ cdg
# → Claude Codeがデンジャラスモードで起動
```

## 設定内容まとめ

| 設定箇所 | 効果 |
|---------|------|
| `.claude.json` の `allowedTools: ["*"]` | 全ツール自動許可 |
| PowerShell関数 `cdg` | `--dangerously-skip-permissions`フラグ付きで起動 |
| bash alias `cdg` | 同上（WSL環境用） |

## 結果
- `claude` = 通常モード（許可プロンプトあり）
- `cdg` = デンジャラスモード（許可プロンプトスキップ）

として使い分け可能になる。

## トラブルシューティング

### PowerShellでcdgが認識されない
1. PowerShellプロファイルが存在するか確認: `Test-Path $PROFILE`
2. プロファイルを再読み込み: `. $PROFILE`
3. 関数が追加されているか確認: `Get-Command cdg`

### WSLでcdgが認識されない
1. .bashrcに追加されているか確認: `grep cdg ~/.bashrc`
2. bashrcを再読み込み: `source ~/.bashrc`
3. エイリアスが設定されているか確認: `alias | grep cdg`

### Claude設定が反映されない
1. 設定ファイルの場所確認: `~/.claude.json`
2. JSON形式の確認（カンマ、クォートなど）
3. Claudeの再起動