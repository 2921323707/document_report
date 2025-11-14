# GitHub提交脚本
# 用途: 自动提交项目到GitHub仓库
# 仓库: https://github.com/2921323707/document_report
# 作者: 2921323707

param(
    [Parameter(Mandatory=$false)]
    [string]$message = "更新项目内容",
    
    [Parameter(Mandatory=$false)]
    [switch]$init,
    
    [Parameter(Mandatory=$false)]
    [switch]$help
)

# 显示帮助信息
if ($help) {
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host "GitHub提交脚本使用说明" -ForegroundColor Cyan
    Write-Host "========================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "用法:" -ForegroundColor Yellow
    Write-Host "  .\commit.ps1 -message `"提交信息`"    # 提交更改"
    Write-Host "  .\commit.ps1 -init                  # 初始化仓库（首次使用）"
    Write-Host "  .\commit.ps1 -help                  # 显示帮助信息"
    Write-Host ""
    Write-Host "示例:" -ForegroundColor Yellow
    Write-Host "  .\commit.ps1 -message `"添加新数据集`""
    Write-Host "  .\commit.ps1 -init"
    Write-Host ""
    exit 0
}

# 获取脚本所在目录的父目录（项目根目录）
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptDir

# 切换到项目根目录
Set-Location $projectRoot

Write-Host "========================================" -ForegroundColor Green
Write-Host "GitHub提交脚本" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host "项目目录: $projectRoot" -ForegroundColor Gray
Write-Host ""

# 检查Git是否安装
try {
    $gitVersion = git --version
    Write-Host "✓ Git已安装: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ 错误: 未检测到Git，请先安装Git" -ForegroundColor Red
    exit 1
}

# 初始化仓库（如果需要）
if ($init -or -not (Test-Path ".git")) {
    Write-Host "正在初始化Git仓库..." -ForegroundColor Yellow
    
    if (-not (Test-Path ".git")) {
        git init
        Write-Host "✓ Git仓库初始化完成" -ForegroundColor Green
    }
    
    # 检查远程仓库是否已配置
    $remoteUrl = git remote get-url origin 2>$null
    if (-not $remoteUrl) {
        Write-Host "正在配置远程仓库..." -ForegroundColor Yellow
        git remote add origin https://github.com/2921323707/document_report.git
        Write-Host "✓ 远程仓库配置完成" -ForegroundColor Green
    } else {
        Write-Host "✓ 远程仓库已配置: $remoteUrl" -ForegroundColor Green
    }
    
    # 创建.gitignore文件（如果不存在）
    if (-not (Test-Path ".gitignore")) {
        Write-Host "正在创建.gitignore文件..." -ForegroundColor Yellow
        @"
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
env/
venv/
*.egg-info/

# IDE
.vscode/
.idea/
*.swp
*.swo
*~

# OS
.DS_Store
Thumbs.db
desktop.ini

# 临时文件
*.tmp
*.log
*.bak

# 大文件（根据需要调整）
# *.pdf
# *.zip
# *.tar.gz
"@ | Out-File -FilePath ".gitignore" -Encoding UTF8
        Write-Host "✓ .gitignore文件已创建" -ForegroundColor Green
    }
}

# 检查是否有更改
$status = git status --porcelain
if (-not $status) {
    Write-Host "ℹ 没有需要提交的更改" -ForegroundColor Yellow
    exit 0
}

# 显示更改状态
Write-Host "检测到以下更改:" -ForegroundColor Yellow
git status --short
Write-Host ""

# 添加所有更改
Write-Host "正在添加文件到暂存区..." -ForegroundColor Yellow
git add .
Write-Host "✓ 文件已添加到暂存区" -ForegroundColor Green
Write-Host ""

# 创建提交
Write-Host "正在创建提交..." -ForegroundColor Yellow
Write-Host "提交信息: $message" -ForegroundColor Gray
git commit -m $message

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ 提交创建成功" -ForegroundColor Green
} else {
    Write-Host "✗ 提交失败，请检查错误信息" -ForegroundColor Red
    exit 1
}

Write-Host ""

# 推送到远程仓库
Write-Host "正在推送到GitHub..." -ForegroundColor Yellow
$branch = git branch --show-current
if (-not $branch) {
    $branch = "main"
    git branch -M main
}

# 尝试推送
git push -u origin $branch 2>&1 | ForEach-Object {
    if ($_ -match "error|fatal") {
        Write-Host $_ -ForegroundColor Red
    } else {
        Write-Host $_ -ForegroundColor Gray
    }
}

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "✓ 提交成功！" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "仓库地址: https://github.com/2921323707/document_report" -ForegroundColor Cyan
} else {
    Write-Host ""
    Write-Host "⚠ 推送可能失败，可能的原因:" -ForegroundColor Yellow
    Write-Host "  1. 需要配置GitHub认证（使用Personal Access Token或SSH）" -ForegroundColor Yellow
    Write-Host "  2. 网络连接问题" -ForegroundColor Yellow
    Write-Host "  3. 权限问题" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "提示: 可以手动执行 'git push -u origin $branch' 来推送" -ForegroundColor Gray
}

