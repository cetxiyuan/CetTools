# ============================================================
# 脚本名称: cxy_git_pull_all.ps1
# 设计者:   CetXiyuan
# 创建时间: 2026-03-18
# 脚本描述: 批量遍历指定的 Git 仓库目录，依次执行 git pull
#           拉取最新代码，并在最后汇总输出成功与失败的仓库列表。
# ============================================================

$repos = @(
    "CetCANTestTool", "CetDevelopmentKit", "CetDiagnosticInstrument",
    "CetNetworkTester", "CetSimulateEcu", "CetSScom", "CetVehicleCollector",
    "CetCryptoToolkit", "CetAssistTool", "CetLoanCalculator", "CetNetworkServer",
    "CetQtTools", "CetRemind", "CetSuperLotto", "CetToolDLLs", "CetToolLicense"
)

$success = @()
$failed  = @()
$root    = $PSScriptRoot

Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Git Pull All Repositories" -ForegroundColor Cyan
Write-Host "============================================`n" -ForegroundColor Cyan

foreach ($repo in $repos) {
    $path = Join-Path $root $repo
    Write-Host "[Pulling] $repo ..." -ForegroundColor Yellow

    if (-not (Test-Path $path)) {
        Write-Host "[SKIP] $repo - directory not found`n" -ForegroundColor DarkGray
        $failed += $repo
        continue
    }

    if (-not (Test-Path (Join-Path $path ".git"))) {
        Write-Host "[SKIP] $repo - not a git repository`n" -ForegroundColor DarkGray
        $failed += $repo
        continue
    }

    Push-Location $path
    $output = git pull 2>&1
    $exitCode = $LASTEXITCODE
    Pop-Location

    Write-Host $output

    if ($exitCode -eq 0) {
        Write-Host "[OK] $repo`n" -ForegroundColor Green
        $success += $repo
    } else {
        Write-Host "[FAIL] $repo`n" -ForegroundColor Red
        $failed += $repo
    }
}

Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Summary" -ForegroundColor Cyan
Write-Host "============================================`n" -ForegroundColor Cyan

if ($success.Count -gt 0) {
    Write-Host "Success ($($success.Count)):" -ForegroundColor Green
    foreach ($r in $success) {
        Write-Host "  [OK] $r" -ForegroundColor Green
    }
    Write-Host ""
}

if ($failed.Count -gt 0) {
    Write-Host "Failed / Skipped ($($failed.Count)):" -ForegroundColor Red
    foreach ($r in $failed) {
        Write-Host "  [!!] $r" -ForegroundColor Red
    }
    Write-Host ""
}

Write-Host "Done. Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
