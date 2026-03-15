# Tools

開発・テスト用のツール集です。

## auth-test.html

Firebase Google ログインで JWT(ID Token) を取得するためのテストページです。
取得したトークンを使って、ローカルの API (`/login` など) をテストできます。

### セットアップ

```bash
# example をコピー
cp auth-test.example.html auth-test.html

# auth-test.html 内の以下の値を書き換える
# - apiKey: Firebase コンソール → プロジェクト設定 → 全般 → ウェブ API キー
# - projectId: Firebase コンソール → プロジェクト設定 → 全般 → プロジェクト ID
```

### 起動

```bash
cd tools
npx serve .
```

http://localhost:3000/auth-test にアクセス

### 使い方

1. 「Google でログイン」ボタンをクリック
2. Google アカウントでログイン
3. ID Token と curl コマンドが表示される
4. 「コピー」ボタンで curl コマンドをコピーしてターミナルで実行

### Swagger / Postman で使う場合

- 認可タイプ: **Bearer Token**
- Token 欄に、ここで取得した ID Token を貼り付ける

※ 「JWT Bearer」(アルゴリズム・シークレット指定) ではないので注意
