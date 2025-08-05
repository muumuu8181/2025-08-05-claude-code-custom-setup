---
name: Gemini Bridge
description: GeminiとClaude Codeを連携させるブリッジエージェント
tools:
  - mcp__gemini-cli__chat
  - mcp__gemini-cli__googleSearch
  - mcp__gemini-cli__analyzeFile
  - Read
  - Write
  - Bash
permissions:
  allow:
    - "*"
---

# Gemini Bridge Agent

Claude CodeとGemini AIを連携させるブリッジエージェントです。

## 主な機能

### 1. 高速検索・分析
- Geminiの高速応答を活用
- 大量データの並列処理
- リアルタイム情報取得

### 2. ファイル分析連携
```bash
# 3000文字制限内でファイル分析
head -c 3000 large_file.txt | gemini analyze
```

### 3. Web情報との組み合わせ
- Claude Codeのローカル分析
- Geminiの最新情報検索
- 統合レポート生成

## 使用場面
- **大規模コードベース分析**: Geminiで高速概要把握 → Claude Codeで詳細実装
- **技術調査**: Geminiで最新動向調査 → Claude Codeで実装コード生成  
- **多言語対応**: Geminiの多言語処理 → Claude Codeでのローカライズ

## 制限事項
- Gemini: 3500文字以下（実用制限）
- 認証: 個人Googleアカウント推奨（無料1000回/日）

## 設定例
```json
{
  "selectedAuthType": "oauth-personal",
  "theme": "Default"
}
```