# Claude Code サブエージェント自動セットアップスクリプト
# Version: 0.1
# Date: 2025-08-05

param(
    [switch]$Personal,
    [switch]$Project,
    [switch]$All
)

Write-Host "=== Claude Code サブエージェント セットアップ v0.1 ===" -ForegroundColor Cyan
Write-Host ""

if (-not ($Personal -or $Project -or $All)) {
    Write-Host "使用方法:" -ForegroundColor Yellow
    Write-Host "  .\setup-agents.ps1 -Personal    # Personal agentsのみセットアップ" -ForegroundColor Gray
    Write-Host "  .\setup-agents.ps1 -Project     # Project agentsのみセットアップ" -ForegroundColor Gray
    Write-Host "  .\setup-agents.ps1 -All         # 全エージェントをセットアップ" -ForegroundColor Gray
    Write-Host ""
    exit 1
}

# WSLパスの取得
$wslUserHome = wsl pwd
$wslPersonalAgents = "$wslUserHome/.claude/agents"
$windowsProjectAgents = "$env:USERPROFILE\.claude\agents"

# Personal agents セットアップ
if ($Personal -or $All) {
    Write-Host "[1/2] Personal agents をセットアップ中..." -ForegroundColor Yellow
    
    # WSL環境のPersonal agentsディレクトリを作成
    wsl mkdir -p ~/.claude/agents
    
    # Personal agentsをコピー
    $personalCount = 0
    Get-ChildItem "agents\personal\*.md" | ForEach-Object {
        $agentName = $_.Name
        wsl cp "/mnt/c/Users/$env:USERNAME/Desktop/work/90_cc/20250805/2025-08-05-claude-code-dangerous-mode-setup/agents/personal/$agentName" ~/.claude/agents/
        Write-Host "  ✓ $agentName をコピーしました" -ForegroundColor Green
        $personalCount++
    }
    
    Write-Host "  Personal agents: $personalCount 体のセットアップが完了" -ForegroundColor Green
}

# Project agents セットアップ
if ($Project -or $All) {
    Write-Host "[2/2] Project agents をセットアップ中..." -ForegroundColor Yellow
    
    # Windows環境のProject agentsディレクトリを作成
    if (!(Test-Path "$env:USERPROFILE\.claude\agents")) {
        New-Item -ItemType Directory -Path "$env:USERPROFILE\.claude\agents" -Force | Out-Null
        Write-Host "  Project agentsディレクトリを作成しました" -ForegroundColor Green
    }
    
    # Project agentsをコピー
    $projectCount = 0
    Get-ChildItem "agents\project\*.md" | ForEach-Object {
        $agentName = $_.Name
        Copy-Item $_.FullName -Destination "$env:USERPROFILE\.claude\agents\" -Force
        Write-Host "  ✓ $agentName をコピーしました" -ForegroundColor Green
        $projectCount++
    }
    
    Write-Host "  Project agents: $projectCount 体のセットアップが完了" -ForegroundColor Green
}

Write-Host ""
Write-Host "=== セットアップ完了 ===" -ForegroundColor Cyan
Write-Host ""
Write-Host "セットアップされたエージェント:" -ForegroundColor White

if ($Personal -or $All) {
    Write-Host ""
    Write-Host "Personal agents (WSL: ~/.claude/agents/):" -ForegroundColor Cyan
    Get-ChildItem "agents\personal\*.md" | ForEach-Object {
        $agentName = $_.BaseName
        Write-Host "  • $agentName" -ForegroundColor Gray
    }
}

if ($Project -or $All) {
    Write-Host ""
    Write-Host "Project agents (~/.claude/agents/):" -ForegroundColor Cyan
    Get-ChildItem "agents\project\*.md" | ForEach-Object {
        $agentName = $_.BaseName
        Write-Host "  • $agentName" -ForegroundColor Gray
    }
}

Write-Host ""
Write-Host "確認方法:" -ForegroundColor Yellow
Write-Host "  claude /agents    # エージェント一覧を表示" -ForegroundColor Gray
Write-Host ""
Write-Host "使用方法:" -ForegroundColor Yellow
Write-Host "  claude            # 通常起動後、エージェントを選択" -ForegroundColor Gray
Write-Host "  claude @エージェント名  # 直接エージェントを指定" -ForegroundColor Gray