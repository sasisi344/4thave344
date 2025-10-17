# Hugoブログワークフロー用PowerShellスクリプト

param(
    [string]$Action = "build",
    [string]$Title = ""
)

function Build-Hugo {
    Write-Host "Hugoビルドを実行中..." -ForegroundColor Green
    hugo --minify --cleanDestinationDir
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "ビルド完了！" -ForegroundColor Green
    } else {
        Write-Host "ビルドに失敗しました。" -ForegroundColor Red
        exit 1
    }
}

function Deploy-Hugo {
    if ([string]::IsNullOrEmpty($Title)) {
        $Title = Read-Host "記事タイトルを入力してください"
    }
    
    Write-Host "デプロイを開始します..." -ForegroundColor Green
    git add public/
    git commit -m "Update site: $Title"
    git push
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "デプロイ完了！" -ForegroundColor Green
    } else {
        Write-Host "デプロイに失敗しました。" -ForegroundColor Red
        exit 1
    }
}

function Start-HugoServer {
    Write-Host "Hugoサーバーを起動中..." -ForegroundColor Green
    hugo server
}

function New-HugoPost {
    $postName = Read-Host "記事名を入力してください"
    hugo new posts/$postName.md
    Write-Host "記事を作成しました: content/post/$postName/$postName.md" -ForegroundColor Green
}

# メイン処理
switch ($Action.ToLower()) {
    "build" { Build-Hugo }
    "deploy" { Deploy-Hugo }
    "server" { Start-HugoServer }
    "new" { New-HugoPost }
    "all" { 
        Build-Hugo
        Deploy-Hugo
    }
    default { 
        Write-Host "使用方法:" -ForegroundColor Yellow
        Write-Host "  .\hugo-workflow.ps1 build    - ビルドのみ"
        Write-Host "  .\hugo-workflow.ps1 deploy   - デプロイのみ"
        Write-Host "  .\hugo-workflow.ps1 server   - ローカルサーバー起動"
        Write-Host "  .\hugo-workflow.ps1 new      - 新記事作成"
        Write-Host "  .\hugo-workflow.ps1 all      - ビルド+デプロイ"
    }
}
