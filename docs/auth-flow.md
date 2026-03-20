# 認証・認可フロー

## 概要

Firebase Authentication（Google ログイン）を使用したトークンベース認証。

## フロー図

```mermaid
sequenceDiagram
    actor User as Flutter App
    participant Google as Google OAuth
    participant Firebase as Firebase Auth
    participant Backend as Backend (Go)
    participant DB as PostgreSQL

    User->>Google: 1. Google ログイン
    Google-->>User: 2. OAuth 認証完了

    User->>Firebase: 3. Firebase にサインイン
    Firebase-->>User: 4. Firebase ID Token 返却

    User->>Backend: 5. POST /login (Bearer Token)
    Backend->>Firebase: 6. Token 検証
    Firebase-->>Backend: 7. TokenInfo 返却

    alt 新規ユーザー
        Backend->>DB: 8a. ユーザー作成
    else 既存ユーザー
        Backend->>DB: 8b. email / display_name 更新
    end

    Backend-->>User: 9. ユーザー情報返却

    Note over User,Backend: 以降のリクエスト
    User->>Backend: 10. Authorization: Bearer [ID Token]
```

## 詳細

### 1. フロントエンド（Flutter）

1. `google_sign_in` パッケージで Google OAuth 認証
2. `firebase_auth` で Firebase にサインイン
3. Firebase ID Token を取得
4. `POST /login` に Bearer Token として送信
5. 以降のすべての API リクエストに同じトークンを付与（`BearerAuthInterceptor`）

### 2. バックエンド（Go）

#### ログイン処理 (`POST /login`)

1. `Authorization` ヘッダーから Bearer Token を抽出
2. `AuthRepository.VerifyIDToken()` で Firebase Admin SDK を使いトークンを検証
3. Firebase UID でユーザーを検索
   - **新規**: ユーザーを自動作成（email, display_name を Firebase から取得）
   - **既存**: email, display_name を最新の値に更新
4. ユーザー情報を返却

#### 各エンドポイントの認証チェック

1. `authenticate(ctx)` メソッドで Bearer Token を検証
2. Firebase UID → DB の User を取得
3. 認証失敗時は `401 Unauthorized`

### 3. オプション: メールドメイン制限

環境変数 `ALLOWED_EMAIL_DOMAINS` にカンマ区切りでドメインを指定すると、そのドメインのメールアドレスを持つユーザーのみログイン可能。

```env
ALLOWED_EMAIL_DOMAINS=example.com,university.ac.jp
```
