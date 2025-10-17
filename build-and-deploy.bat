@echo off
echo Hugoブログのビルドとデプロイを開始します...

REM 記事タイトルを入力
set /p article_title="記事タイトルを入力してください: "

REM Hugoビルド
echo Hugoビルドを実行中...
hugo --minify --cleanDestinationDir

if %errorlevel% neq 0 (
    echo ビルドに失敗しました。
    pause
    exit /b 1
)

REM Gitにコミット
echo Gitにコミット中...
git add public/
git commit -m "Update site: %article_title%"
git push

if %errorlevel% neq 0 (
    echo プッシュに失敗しました。
    pause
    exit /b 1
)

echo デプロイが完了しました！
pause
