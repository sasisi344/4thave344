+++
# 基本情報
title = '{{ replace .File.ContentBaseName "-" " " | title }}'
date = '{{ .Date }}'
draft = true

# 必須項目
categories = []  # tech/daily/news/blogのいずれか
tags = []  # 最低3つ、関連性の高いタグ
author = "さしし"
description = ''  # 160文字以内、SEO用
summary = ''  # 200文字以内、一覧表示用
thumbnail = ''  # static/images/配下の相対パス

# 推奨項目
images = []  # OGP用画像配列
weight = 3  # 記事の重要度（1-5）
lastmod = '{{ .Date }}'  # 最終更新日
publishDate = '{{ .Date }}'  # 公開日
slug = ''  # カスタムURL

# 表示設定
showToc = true  # 目次表示
showBreadcrumb = true  # パンくずリスト表示
showReadingTime = true  # 読了時間表示

# 機能設定
comments = true  # コメント機能
related = true  # 関連記事の表示
+++
