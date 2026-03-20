# API 仕様書

## 概要

- **ベース URL（ローカル）**: `http://localhost:8080`
- **認証方式**: Bearer Token（Firebase ID Token）
- **Swagger UI**: `http://localhost:8081`（`make docs-up` で起動）
- **Mock サーバー**: `http://localhost:4010`（`make mock-up` で起動）

## エンドポイント一覧

| メソッド | パス | operationId | 認証 | 説明 |
|---------|------|-------------|------|------|
| GET | `/health` | healthCheck | 不要 | ヘルスチェック |
| POST | `/login` | login | 必要 | ログイン・ユーザー登録 |
| GET | `/chats` | listChats | 必要 | チャット一覧取得 |
| POST | `/chats` | createChat | 必要 | チャット作成 |
| GET | `/chats/{chatId}/messages` | listMessages | 必要 | メッセージ一覧取得 |
| POST | `/chats/{chatId}/messages` | sendMessage | 必要 | メッセージ送信 + AI 応答 |
| POST | `/chats/{chatId}/call-persona` | callPersona | 必要 | プリセット先輩を呼び出し |

## 認証

すべての保護エンドポイントには `Authorization` ヘッダーが必要。

```
Authorization: Bearer <Firebase ID Token>
```

認証失敗時は `401 Unauthorized` を返却。

## エンドポイント詳細

### POST /login

Firebase ID Token を検証し、ユーザーを登録または更新する。

**リクエスト**: ボディなし（Authorization ヘッダーのみ）

**レスポンス (200)**:
```json
{
  "user": {
    "id": "uuid",
    "firebase_uid": "string",
    "email": "user@example.com",
    "display_name": "名前",
    "created_at": "2025-01-01T00:00:00Z",
    "updated_at": "2025-01-01T00:00:00Z"
  }
}
```

### POST /chats

新しいチャット（AI 先輩との会話）を作成する。

**リクエスト**:
```json
{
  "title": "チャットタイトル（省略時: New Chat）",
  "persona": {
    "name": "田中太郎",
    "gender": "male",
    "age": 25,
    "occupation": "エンジニア",
    "annual_income": 500,
    "system_prompt": "（オプション）追加のシステムプロンプト"
  }
}
```

**レスポンス (201)**:
```json
{
  "chat": {
    "id": "uuid",
    "title": "チャットタイトル",
    "persona": { ... },
    "created_at": "2025-01-01T00:00:00Z"
  }
}
```

### GET /chats

認証ユーザーのチャット一覧を取得（作成日時の降順）。

**レスポンス (200)**:
```json
{
  "chats": [
    {
      "id": "uuid",
      "title": "チャットタイトル",
      "persona": { ... },
      "created_at": "2025-01-01T00:00:00Z"
    }
  ]
}
```

### POST /chats/{chatId}/messages

メッセージを送信し、AI の応答を受け取る。

**リクエスト**:
```json
{
  "content": "就活で大事なことは何ですか？"
}
```

**レスポンス (201)**:
```json
{
  "user_message": {
    "id": "uuid",
    "chat_id": "uuid",
    "sender_type": "user",
    "content": "就活で大事なことは何ですか？",
    "created_at": "2025-01-01T00:00:00Z"
  },
  "ai_message": {
    "id": "uuid",
    "chat_id": "uuid",
    "sender_type": "persona",
    "persona": { ... },
    "content": "AI の応答テキスト",
    "created_at": "2025-01-01T00:00:00Z"
  }
}
```

### GET /chats/{chatId}/messages

メッセージ一覧を取得する（カーソルページネーション対応）。

**パラメータ**:

| 名前 | 型 | デフォルト | 説明 |
|------|-----|----------|------|
| `limit` | integer | 50 | 取得件数（最小 1） |
| `before` | string (UUID) | — | このメッセージ ID より前のメッセージを取得 |

**レスポンス (200)**:
```json
{
  "messages": [ ... ],
  "has_more": true
}
```

### POST /chats/{chatId}/call-persona

プリセット先輩をチャットに呼び出す。呼び出された先輩はこれまでの会話ログを読んだ上で応答する。

**リクエスト**:
```json
{
  "preset_key": "yarigai"
}
```

**利用可能な preset_key**:

| キー | 説明 |
|------|------|
| `yarigai` | やりがい重視の先輩 |
| `nenshu` | 年収重視の先輩 |

**レスポンス (201)**:
```json
{
  "message": {
    "id": "uuid",
    "chat_id": "uuid",
    "sender_type": "persona",
    "persona": { ... },
    "content": "プリセット先輩の応答",
    "created_at": "2025-01-01T00:00:00Z"
  }
}
```

## エラーレスポンス

```json
{
  "message": "エラーメッセージ"
}
```

| ステータス | 説明 |
|-----------|------|
| 400 | リクエスト不正（バリデーションエラー等） |
| 401 | 認証失敗（トークン無効・期限切れ） |
| 404 | リソースが見つからない |
| 500 | サーバー内部エラー |
