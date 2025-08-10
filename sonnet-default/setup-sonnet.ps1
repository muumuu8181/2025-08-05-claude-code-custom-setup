# Claude Code Sonnet固定設定スクリプト (Windows PowerShell)
# 作成日: 2025-08-10
# 用途: Claude CodeのデフォルトモデルをSonnetに設定

Write-Host "🚀 Claude Code Sonnet固定設定を開始します..." -ForegroundColor Green

$claudeDir = "$env:USERPROFILE\.claude"
$settingsFile = "$claudeDir\settings.json"

# Claude設定フォルダの作成
if (!(Test-Path $claudeDir)) {
    Write-Host "📁 Claude設定フォルダを作成中..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $claudeDir -Force | Out-Null
}

# 既存設定の確認
if (Test-Path $settingsFile) {
    Write-Host "⚠️  既存の設定ファイルが見つかりました" -ForegroundColor Yellow
    Write-Host "現在の設定:" -ForegroundColor White
    Get-Content $settingsFile | Write-Host -ForegroundColor Cyan
    
    $overwrite = Read-Host "設定を上書きしますか？ (y/N)"
    if ($overwrite.ToLower() -ne 'y') {
        Write-Host "❌ 設定をキャンセルしました" -ForegroundColor Red
        exit 0
    }
}

# Sonnet設定の作成
Write-Host "📝 Sonnet設定ファイルを作成中..." -ForegroundColor Yellow

$settings = @{
    model = "sonnet"
} | ConvertTo-Json -Depth 2

try {
    $settings | Out-File -FilePath $settingsFile -Encoding UTF8 -Force
    
    Write-Host "✅ 設定完了!" -ForegroundColor Green
    Write-Host "設定ファイル: $settingsFile" -ForegroundColor White
    Write-Host ""
    Write-Host "📋 作成された設定:" -ForegroundColor White
    Get-Content $settingsFile | Write-Host -ForegroundColor Cyan
    Write-Host ""
    Write-Host "🔄 Claude Codeを再起動すると、Sonnetが自動選択されます" -ForegroundColor Green
    
} catch {
    Write-Host "❌ 設定ファイルの作成に失敗しました: $_" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "🎉 Claude Code Sonnet固定設定が完了しました！" -ForegroundColor Green