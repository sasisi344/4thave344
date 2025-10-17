@echo off
set /p article_title="記事タイトルを入力してください: "
echo デプロイを開始します...
git add public/
git commit -m "Update site: %article_title%"
git push
echo デプロイ完了！
pause
