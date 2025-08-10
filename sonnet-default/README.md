# Claude Code Sonnet固定設定

## 概要
Claude Codeを起動時に自動的にSonnetモデルに設定するためのスクリプト集です。

## 使い方

### Windows PowerShell
```powershell
.\setup-sonnet.ps1
```

### Linux/WSL/macOS
```bash
./setup-sonnet.sh
```

## 設定内容
- ユーザー設定ファイル `~/.claude/settings.json` を作成
- デフォルトモデルを "sonnet" に設定
- 次回起動時から自動的にSonnetが選択される

## 注意
- 既存の設定ファイルがある場合は確認プロンプトが表示されます
- プロジェクト固有の設定がある場合はそちらが優先されます