# 開発ガイドライン

## ブランチ戦略

| ブランチ | 用途 |
|---------|------|
| `main` | 本番リリース用 |
| `infra` | インフラ変更 |
| `feat/*` | 新機能開発 |
| `fix/*` | バグ修正 |

## コミット規約

[Conventional Commits](https://www.conventionalcommits.org/) に準拠。

```
<type>[optional scope]: <description>
```

### type 一覧

| type | 説明 |
|------|------|
| `feat` | 新機能追加 |
| `fix` | バグ修正 |
| `docs` | ドキュメント変更 |
| `style` | コード整形（機能変更なし） |
| `refactor` | リファクタリング |
| `perf` | パフォーマンス向上 |
| `test` | テスト追加・修正 |
| `build` | ビルド関連 |
| `ci` | CI 設定変更 |
| `chore` | その他の変更 |

### 例

```
feat(auth): add OAuth2 login flow
fix(api): handle nil pointer in user fetch
docs: add architecture document
```

詳細は [commit.md](./commit.md) を参照。

## コード生成ワークフロー

### API 変更時

1. `openapi/openapi.yaml` を編集
2. `make gen` でコード再生成
3. 生成されたコードに合わせてハンドラーを実装

### DI 変更時

1. `registry/wire.go` を編集
2. `wire` コマンドで `wire_gen.go` を再生成

```bash
cd backend/registry && wire
```

## バックエンドのレイヤー構成ルール

```
handler → usecase → repository
```

- **handler**: HTTP リクエスト/レスポンスの処理のみ。ビジネスロジックは書かない
- **usecase**: ビジネスロジック。複数の repository を組み合わせる
- **repository**: DB・外部 API とのやりとり。SQL クエリや API コールを書く
- **service 層は作らない**

## フロントエンドの構成ルール

```
presentation (Screen/Controller) → data (Repository) → API Client
```

- **Screen**: UI の描画
- **Controller**: `StateNotifier` で状態管理
- **Repository**: API クライアントとのやりとり
- **状態管理**: Riverpod を使用

## DB スキーマの変更

- テーブル設計は `backend/cmd/server/migrations/init.sql` が正
- カラムの増減は init.sql を基準にする
- 変更後は `make migrate` で適用、`make erd` で ERD を更新
