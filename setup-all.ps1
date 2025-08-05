# Claude Code 統合セットアップスクリプト
# Version: 0.1
# Date: 2025-08-05

Write-Host "=== Claude Code 統合カスタムセットアップ v0.1 ===" -ForegroundColor Cyan
Write-Host ""

Write-Host "このスクリプトは以下をセットアップします:" -ForegroundColor White
Write-Host "  ✓ デンジャラスモード (cdg コマンド)" -ForegroundColor Gray
Write-Host "  ✓ サブエージェント (Personal: 4体, Project: 8体)" -ForegroundColor Gray
Write-Host ""

$confirmation = Read-Host "続行しますか？ (y/N)"
if ($confirmation -ne 'y' -and $confirmation -ne 'Y') {
    Write-Host "セットアップをキャンセルしました" -ForegroundColor Yellow
    exit 0
}

Write-Host ""
Write-Host "=== Step 1: デンジャラスモード設定 ===" -ForegroundColor Cyan
Write-Host ""

try {
    & ".\setup-cdg.ps1"
    Write-Host ""
    Write-Host "✓ デンジャラスモード設定が完了しました" -ForegroundColor Green
} catch {
    Write-Host "✗ デンジャラスモード設定でエラーが発生しました: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "=== Step 2: サブエージェント設定 ===" -ForegroundColor Cyan
Write-Host ""

try {
    & ".\setup-agents.ps1" -All
    Write-Host ""
    Write-Host "✓ サブエージェント設定が完了しました" -ForegroundColor Green
} catch {
    Write-Host "✗ サブエージェント設定でエラーが発生しました: $($_.Exception.Message)" -ForegroundColor Red
}

Write-Host ""
Write-Host "=== 統合セットアップ完了 ===" -ForegroundColor Cyan
Write-Host ""

Write-Host "設定されたコマンド:" -ForegroundColor White
Write-Host "  claude       # 通常モード" -ForegroundColor Gray
Write-Host "  cdg          # デンジャラスモード" -ForegroundColor Gray
Write-Host "  claude /agents  # エージェント一覧表示" -ForegroundColor Gray
Write-Host ""

Write-Host "利用可能なエージェント:" -ForegroundColor White
Write-Host "  Personal agents (4体): code-reviewer, db-analyzer, gemini-bridge, task-agent" -ForegroundColor Gray
Write-Host "  Project agents (8体): agents-manager, doc-writer, doc-reader, endless-tawaimonai," -ForegroundColor Gray
Write-Host "                        problem-sleuth-engineer, rule-manager, softengineer-expert, task-splitter" -ForegroundColor Gray
Write-Host ""

Write-Host "次の手順:" -ForegroundColor Yellow
Write-Host "  1. PowerShellを再起動して cdg コマンドを有効化" -ForegroundColor Gray
Write-Host "  2. claude /agents でエージェント一覧を確認" -ForegroundColor Gray
Write-Host "  3. cdg でデンジャラスモードをテスト" -ForegroundColor Gray
Write-Host ""

Write-Host "🎉 Claude Code のカスタムセットアップが完了しました！" -ForegroundColor Green