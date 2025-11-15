# 将子模块转换为普通目录并添加到主仓库
# 用途: 解决 Frame/src/EEG_Emotion_Classifier_DEAP 目录文件无法提交的问题

param(
    [Parameter(Mandatory=$false)]
    [string]$message = "添加 EEG_Emotion_Classifier_DEAP 文件到主仓库"
)

# 获取项目根目录（git 脚本所在目录的父目录）
$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectRoot = Split-Path -Parent $scriptDir

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "添加子模块文件到主仓库" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "项目目录: $projectRoot" -ForegroundColor Gray
Write-Host ""

# 切换到项目根目录
Set-Location $projectRoot

# 检查是否在主仓库中
try {
    $branch = git branch --show-current 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "✗ 错误: 不在 Git 仓库中或不是主仓库" -ForegroundColor Red
        exit 1
    }
    Write-Host "✓ 当前分支: $branch" -ForegroundColor Green
} catch {
    Write-Host "✗ 错误: 无法识别 Git 仓库" -ForegroundColor Red
    exit 1
}

$submodulePath = Join-Path $projectRoot "Frame\src\EEG_Emotion_Classifier_DEAP"
$gitPath = Join-Path $submodulePath ".git"

Write-Host ""
Write-Host "检查子模块目录..." -ForegroundColor Yellow

# 检查子模块目录是否存在
if (-not (Test-Path $submodulePath)) {
    Write-Host "✗ 错误: 找不到目录 $submodulePath" -ForegroundColor Red
    exit 1
}
Write-Host "✓ 目录存在" -ForegroundColor Green

# 检查是否有 .git 目录
if (Test-Path $gitPath) {
    Write-Host "检测到子目录包含独立的 .git 目录" -ForegroundColor Yellow
    Write-Host "正在删除子目录的 .git 文件夹..." -ForegroundColor Yellow
    
    try {
        Remove-Item -Path $gitPath -Recurse -Force
        Write-Host "✓ 已删除子目录的 .git 文件夹" -ForegroundColor Green
    } catch {
        Write-Host "✗ 删除失败: $_" -ForegroundColor Red
        Write-Host "提示: 请手动删除 $gitPath 目录" -ForegroundColor Yellow
    }
} else {
    Write-Host "✓ 子目录中没有 .git 文件夹" -ForegroundColor Green
}

Write-Host ""
Write-Host "检查文件状态..." -ForegroundColor Yellow

# 检查主仓库中是否跟踪了这个目录
$trackedFiles = git ls-files "Frame/src/EEG_Emotion_Classifier_DEAP/" 2>&1

if ($trackedFiles -and $LASTEXITCODE -eq 0) {
    $fileCount = ($trackedFiles -split "`n").Count - 1
    Write-Host "✓ 主仓库已跟踪 $fileCount 个文件" -ForegroundColor Green
} else {
    Write-Host "⚠ 主仓库未跟踪该目录中的文件" -ForegroundColor Yellow
    
    # 检查子模块状态
    $submoduleStatus = git status --porcelain "Frame/src/EEG_Emotion_Classifier_DEAP" 2>&1
    
    if ($submoduleStatus -match "modified content|Untracked") {
        Write-Host ""
        Write-Host "移除子模块引用..." -ForegroundColor Yellow
        
        # 移除子模块的缓存（如果存在）
        git rm --cached "Frame/src/EEG_Emotion_Classifier_DEAP" 2>&1 | Out-Null
        
        Write-Host "添加文件到暂存区..." -ForegroundColor Yellow
        
        # 添加所有文件（排除 .git 目录）
        Get-ChildItem -Path $submodulePath -Recurse -File | ForEach-Object {
            $relativePath = $_.FullName.Substring($projectRoot.Length + 1)
            git add $relativePath 2>&1 | Out-Null
        }
        
        Write-Host "✓ 文件已添加到暂存区" -ForegroundColor Green
    } else {
        Write-Host "添加所有文件..." -ForegroundColor Yellow
        git add "Frame/src/EEG_Emotion_Classifier_DEAP/" 2>&1 | Out-Null
        Write-Host "✓ 文件已添加" -ForegroundColor Green
    }
}

Write-Host ""
Write-Host "当前状态:" -ForegroundColor Yellow
$status = git status --short "Frame/src/EEG_Emotion_Classifier_DEAP" 2>&1
if ($status) {
    $status | Select-Object -First 15 | ForEach-Object { Write-Host $_ -ForegroundColor Gray }
} else {
    Write-Host "没有需要提交的更改" -ForegroundColor Gray
}

# 检查是否有未暂存的文件
$unstaged = git status --porcelain "Frame/src/EEG_Emotion_Classifier_DEAP" 2>&1 | Where-Object { $_ -match "^\?\?" }
if ($unstaged) {
    Write-Host ""
    Write-Host "发现未跟踪的文件，正在添加..." -ForegroundColor Yellow
    git add "Frame/src/EEG_Emotion_Classifier_DEAP/" 2>&1 | Out-Null
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "✓ 完成！" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "下一步操作:" -ForegroundColor Cyan
Write-Host "  1. 检查状态: git status" -ForegroundColor Gray
Write-Host "  2. 提交更改: git commit -m `"$message`"" -ForegroundColor Gray
Write-Host "  3. 推送: git push" -ForegroundColor Gray
Write-Host ""
Write-Host "或者使用提交脚本:" -ForegroundColor Cyan
Write-Host "  cd git" -ForegroundColor Gray
Write-Host "  .\commit.ps1 -message `"$message`"" -ForegroundColor Gray

