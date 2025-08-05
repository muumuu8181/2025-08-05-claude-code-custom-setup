# Claude Code デンジャラスモード自動セットアップスクリプト
# Version: 0.1
# Date: 2025-08-05

Write-Host "=== Claude Code デンジャラスモード設定 v0.1 ===" -ForegroundColor Cyan
Write-Host ""

# 1. PowerShellプロファイルにcdg関数を追加
Write-Host "[1/3] PowerShellプロファイルにcdg関数を追加中..." -ForegroundColor Yellow

# プロファイルディレクトリが存在しない場合は作成
$profileDir = Split-Path $PROFILE -Parent
if (!(Test-Path $profileDir)) {
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
    Write-Host "  プロファイルディレクトリを作成しました: $profileDir" -ForegroundColor Green
}

# プロファイルファイルが存在しない場合は作成
if (!(Test-Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force | Out-Null
    Write-Host "  プロファイルファイルを作成しました: $PROFILE" -ForegroundColor Green
}

# cdg関数が既に存在するかチェック
$profileContent = Get-Content $PROFILE -Raw -ErrorAction SilentlyContinue
if ($profileContent -notmatch "function cdg") {
    # cdg関数を追加
    $cdgFunction = @"

# Claude Code デンジャラスモード関数 (追加日: $(Get-Date -Format 'yyyy-MM-dd'))
function cdg {
    claude --dangerously-skip-permissions @args
}
"@
    Add-Content -Path $PROFILE -Value $cdgFunction
    Write-Host "  cdg関数をプロファイルに追加しました" -ForegroundColor Green
} else {
    Write-Host "  cdg関数は既に存在します" -ForegroundColor Yellow
}

# 2. Claude設定ファイルを確認・更新
Write-Host "[2/3] Claude設定ファイルを確認中..." -ForegroundColor Yellow

$claudeConfigPath = "$env:USERPROFILE\.claude.json"
if (Test-Path $claudeConfigPath) {
    Write-Host "  Claude設定ファイルが見つかりました: $claudeConfigPath" -ForegroundColor Green
    
    # 設定ファイルの内容を確認
    try {
        $config = Get-Content $claudeConfigPath -Raw | ConvertFrom-Json
        $currentProject = "C:/Users/$env:USERNAME"
        
        if ($config.projects.$currentProject.allowedTools -contains "*") {
            Write-Host "  allowedTools は既に ['*'] に設定されています" -ForegroundColor Yellow
        } else {
            Write-Host "  注意: allowedTools の手動設定が必要です" -ForegroundColor Red
            Write-Host "    $claudeConfigPath を開いて" -ForegroundColor Red
            Write-Host "    'allowedTools': ['*'] に変更してください" -ForegroundColor Red
        }
    } catch {
        Write-Host "  設定ファイルの読み取りでエラーが発生しました" -ForegroundColor Red
    }
} else {
    Write-Host "  Claude設定ファイルが見つかりません" -ForegroundColor Red
    Write-Host "  Claude Codeを一度実行してから再度お試しください" -ForegroundColor Red
}

# 3. プロファイルを再読み込み
Write-Host "[3/3] PowerShellプロファイルを再読み込み中..." -ForegroundColor Yellow
try {
    . $PROFILE
    Write-Host "  プロファイルの再読み込みが完了しました" -ForegroundColor Green
} catch {
    Write-Host "  プロファイルの再読み込みでエラーが発生しました: $($_.Exception.Message)" -ForegroundColor Red
}

# 動作確認
Write-Host ""
Write-Host "=== セットアップ完了 ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "動作確認:" -ForegroundColor White
Write-Host "  cdg --version    # デンジャラスモードでClaude Codeのバージョン確認" -ForegroundColor Gray
Write-Host "  cdg              # デンジャラスモードでClaude Code起動" -ForegroundColor Gray
Write-Host ""
Write-Host "注意事項:" -ForegroundColor Red
Write-Host "  デンジャラスモードは安全性制約を無効化します" -ForegroundColor Red
Write-Host "  システムファイルの変更やネットワーク操作が自動許可されます" -ForegroundColor Red
Write-Host ""

# cdg関数が利用可能か確認
if (Get-Command cdg -ErrorAction SilentlyContinue) {
    Write-Host "✓ cdg コマンドが正常に設定されました" -ForegroundColor Green
} else {
    Write-Host "✗ cdg コマンドの設定に問題があります" -ForegroundColor Red
    Write-Host "  PowerShellを再起動してから再度お試しください" -ForegroundColor Yellow
}