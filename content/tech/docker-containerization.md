---
title: "Dockerによるコンテナ化の基礎とベストプラクティス"
date: 2024-01-30T16:45:00Z
draft: false
categories: ["tech"]
tags: ["docker", "containerization", "devops"]
author: "Tech Writer"
---

# Dockerによるコンテナ化の基礎とベストプラクティス

Dockerは、アプリケーションとその依存関係をコンテナとしてパッケージ化する技術です。この記事では、Dockerの基本概念と実践的な使い方を説明します。

## Dockerとは

Dockerは、アプリケーションを軽量で移植可能なコンテナとして実行できるようにするプラットフォームです。

### 主な利点

- **一貫性**: 開発、テスト、本番環境で同じ環境を再現
- **効率性**: 仮想マシンより軽量で高速
- **移植性**: どの環境でも同じように動作
- **スケーラビリティ**: 簡単にスケールアップ・ダウン

## 基本的な使い方

### 1. Dockerfileの作成

```dockerfile
# ベースイメージの指定
FROM node:18-alpine

# 作業ディレクトリの設定
WORKDIR /app

# 依存関係のコピーとインストール
COPY package*.json ./
RUN npm install

# アプリケーションコードのコピー
COPY . .

# ポートの公開
EXPOSE 3000

# アプリケーションの起動
CMD ["npm", "start"]
```

### 2. イメージのビルド

```bash
docker build -t my-app .
```

### 3. コンテナの実行

```bash
docker run -p 3000:3000 my-app
```

## Docker Composeの活用

複数のサービスを管理する場合、Docker Composeが便利です。

```yaml
version: '3.8'
services:
  web:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
    depends_on:
      - db
  
  db:
    image: postgres:13
    environment:
      - POSTGRES_DB=myapp
      - POSTGRES_USER=user
      - POSTGRES_PASSWORD=password
    volumes:
      - postgres_data:/var/lib/postgresql/data

volumes:
  postgres_data:
```

## ベストプラクティス

### 1. マルチステージビルド

```dockerfile
# ビルドステージ
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# 本番ステージ
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### 2. セキュリティの考慮

- 非rootユーザーの使用
- 最小限のベースイメージの選択
- 不要なパッケージの削除

### 3. パフォーマンスの最適化

- レイヤーキャッシュの活用
- .dockerignoreファイルの使用
- 適切なイメージサイズの維持

## まとめ

Dockerは現代の開発において欠かせないツールです。適切な使い方を身につけることで、開発効率とアプリケーションの品質を大幅に向上させることができます。
