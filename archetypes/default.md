+++
date = '{{ .Date }}'
draft = true
title = '{{ replace .File.ContentBaseName "-" " " | title }}'

# 記事メタ
description = ''
summary = ''
author = ''
categories = []
tags = []

# サムネイル画像（相対パス推奨: static/images/ 配下）
# 例: "images/thumbnail.jpg"
thumbnail = ''

# OGP用に複数画像を渡したい場合（任意）
images = []
+++
