---
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git branch:*), Bash(git log:*), Bash(git add:*), Bash(git commit:*)
description: 変更内容を確認し、Conventional Commits 形式でコミットする
---

# Gitコミット

以下を確認してから進めてください。

- git status: !`git status`
- git diff: !`git diff HEAD`
- current branch: !`git branch --show-current`
- recent commits: !`git log --oneline -10`

## やること

1. 差分を確認して変更の主目的を把握する
2. Conventional Commits 形式でコミットメッセージ候補を日本語で3つ作る
3. 以下の形式で候補を提示する
4. 必要なら `git add` する
5. 選ばれたメッセージで `git commit` する

## 形式

- `feat`: 新機能
- `fix`: バグ修正
- `docs`: ドキュメント
- `refactor`: リファクタ
- `test`: テスト
- `build`: ビルド関連
- `ci`: CI関連
- `chore`: 雑務
- `style`: 整形のみ
- `perf`: 性能改善
- `revert`: 差し戻し

コミットメッセージは原則以下:

```text
<type>[optional scope]: <description>
候補の出し方
→ 1. feat(auth): add Google login flow
→ 2. fix(login): prevent duplicate submit
→ 3. refactor(auth): simplify login handler
ルール

差分がなければ commit しない

変更内容に忠実なメッセージにする

変更が複数ある場合は主目的を優先する

scope は必要なときだけ付ける

不要に長くしない

AI生成の署名や Claude の co-authorship footer は入れない

出力

コミット候補3つ

実行した git add / git commit

コミット結果
```
