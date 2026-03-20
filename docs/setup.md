# 環境構築手順

## 必要な環境

| ツール | 用途 |
|--------|------|
| [Docker / Docker Compose](https://www.docker.com/) | DB・Swagger UI の起動 |
| [aqua](https://aquaproj.github.io/) | CLI ツール管理（oapi-codegen, wire） |
| [Flutter SDK](https://flutter.dev/) | フロントエンド |
| Go 1.21+ | バックエンド |

## 1. CLI ツールのインストール

```bash
aqua install
```

以下がインストールされる:
- `oapi-codegen` v2.5.1 — OpenAPI → Go コード生成
- `wire` v0.7.0 — DI コンテナ生成

## 2. 外部サービスのセットアップ

### Firebase

1. [Firebase Console](https://console.firebase.google.com/) でプロジェクトを作成
2. **Authentication** を有効化し、Google ログインを設定
3. サービスアカウントキー（JSON）をダウンロード
4. プロジェクト ID と API キーを控える

### Gemini API

1. [Google AI Studio](https://aistudio.google.com/) で API キーを取得

## 3. 環境変数の設定

`backend/.env` を作成（`.env.example` をコピー）:

```bash
cp backend/.env.example backend/.env
```

以下を設定:

```env
# データベース
DATABASE_USER=postgres
DATABASE_PASSWORD=postgres
DATABASE_NAME=app
DATABASE_HOST=localhost
DATABASE_PORT=5444

# Firebase
FIREBASE_AUTH_PROJECT_ID=your-firebase-project-id
GOOGLE_APPLICATION_CREDENTIALS=path/to/serviceAccountKey.json

# Gemini
GEMINI_API_KEY=your-gemini-api-key

# サーバー
PORT=8080

# オプション
ALLOWED_EMAIL_DOMAINS=          # メールドメイン制限（カンマ区切り）
CHAT_HISTORY_LIMIT=10           # AI に渡す会話履歴の件数
```

## 4. Docker 環境の起動

```bash
# PostgreSQL + Swagger UI を起動
make up

# DB マイグレーション実行
make migrate

# ステータス確認
make ps
```

### Docker Compose サービス一覧

| サービス | ポート | 説明 |
|---------|--------|------|
| postgres | 5444 | PostgreSQL 16 |
| swagger-ui | 8081 | OpenAPI ドキュメント閲覧 |
| prism | 4010 | API モックサーバー |

## 5. バックエンドの起動

```bash
make server
```

`http://localhost:8080` でサーバーが起動。

## 6. フロントエンドの起動

```bash
cd flutter

# 依存パッケージのインストール
flutter pub get

# API クライアントのビルド
cd packages/wai_api
dart pub get
dart run build_runner build --delete-conflicting-outputs
cd ../..

# Web で起動
flutter run -d chrome
```

## 7. コード生成

API 仕様を変更した場合:

```bash
# Go + Flutter + Web のコード再生成
make gen

# Go のみ
make gen-back

# Flutter のみ
make gen-flutter
```

## よく使うコマンド

| コマンド | 説明 |
|---------|------|
| `make up` | Docker 環境を起動 |
| `make down` | Docker 環境を停止 |
| `make clean` | Docker 環境を停止 + ボリューム削除 |
| `make server` | バックエンドサーバーを起動 |
| `make gen` | OpenAPI からコードを再生成 |
| `make migrate` | DB マイグレーション実行 |
| `make erd` | ER 図を生成（tbls） |
| `make schema` | DB 起動 → マイグレーション → ERD 生成を一括実行 |
| `make mock-up` | Prism モックサーバーを起動 |
| `make docs-up` | Swagger UI を起動 |
