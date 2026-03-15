---
description: "現在の変更内容をもとにPull Requestを作成して開く"
allowed-tools: Bash(git status:*), Bash(git diff:*), Bash(git branch:*), Bash(git log:*), Bash(git push:*), Bash(gh pr create:*), Bash(gh pr view:*)
---

# PR作成

以下を確認してから進めてください。

- git status: !`git status`
- git diff: !`git diff HEAD`
- current branch: !`git branch --show-current`
- recent commits: !`git log --oneline -10`

## やること

1. 現在の変更内容と直近コミットからPRタイトルと本文を作る
2. 現在のブランチをリモートに push する
3. `gh pr create` で Draft PR を作る
4. `gh pr view --web` でブラウザ表示する

## ルール

- 新たに `git add` / `git commit` はしない
- PRタイトルは変更内容が一目で分かるように簡潔にする
- PR本文は差分に忠実に書く
- 不明な確認項目を勝手に完了済みにしない
- AI生成の署名は入れない
- 文章は日本語で書く

## タイトル形式

```text
[<app-name>-<server-or-web>] <変更の要約>

例:

[wai-web] ログイン画面のUIを追加
[ai-senpai-server] ユーザー作成APIのバリデーションを修正
実行コマンド
CURRENT_BRANCH="$(git branch --show-current)"
TARGET_BRANCH="${ARGUMENTS:-main}"

git push -u origin "$CURRENT_BRANCH"

gh pr create -d -B "$TARGET_BRANCH" \
  --title "[<app-name>-<server-or-web>] <変更の要約>" \
  --body "<!-- I want to review in Japanese. -->

# レビュー

## WHAT <!-- このPRで行なった変更点は？ -->

-

## WHY <!-- なぜその変更が必要ですか？関連するIssueやSlackのリンクなど-->

-

## FOR REVIEWERS <!-- レビュワーへの参考情報 -->

-

## 動作確認"
```

# 作成後

gh pr view --web
