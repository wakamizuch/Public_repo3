# アプリケーション名

タスク共有アプリ

# アプリケーション概要

タスクを作成し、他の人の投稿を見たり、いいねを押すことができます。フォローをすることで、その人のタスク一覧を見ることもできます。

## 開発背景

今までは、自分の作りたいアプリを作っていました。しかし、それだけではいけないと思い、既存のサービスへの理解度を深めるべく Twitter のクローンのようなアプリの開発を行っています。今後機能を増やしていきたいと考えています。

## 機能と細かい要件

1. ログイン機能
   - パスワードは暗号化し保存
   - リロードしてもログイン維持
   - ログイン時は新規登録・ログインページに遷移できない
   - 未ログイン時はトップページ・新規登録・ログインページ以外に遷移できない
   - (名前 or メールアドレス) + パスワード でログイン
2. タスク機能
   - 新しい自分のタスクを作成する
   - 自分のタスクを一覧表示
   - 自分のタスクを完了することができる。(他人のタスクは完了できない)
   - ページを遷移したとしても完了フラグを保持
   - みんなのタスクを一覧表示
3. フォロー機能 (フォローした人の全投稿のページへ遷移)
   - 他ユーザーをフォロー/フォロー解除
   - フォローしたユーザーのタスクを一覧表示
4. いいね機能 (いいねしたタスクページへ遷移、またいいねの数のカウント)
   - タスクに対していいね/いいね解除
   - タスクごとにそのタスクのいいね数が表示

## 動作確認(30s)

1.  タスクの作成
2.  タスクの完了フラグの保持(リロード後)
3.  自分のタスク一覧
4.  自分がいいねしたタスク一覧
5.  いいね解除によりタスク非表示
6.  フォロワー(投稿者:将棋大好き)の全投稿一覧
    <img src="gif_for_readme/機能説明.gif" >

# ER 図

```mermaid
%%{init:{'theme':'base'}}%%
---
title: "TODO リストデータベース"
---
erDiagram
    user_infos ||--o{ tasks : "1人で複数のタスクを保持可能"
    user_infos o|--o{ relationships : "follower"
    user_infos o|--o{ relationships : "followed"
    tasks ||--o{ fights : "1タスクで複数のファイトを保持可能"
    user_infos ||--o{ fights : "1人で複数のタスクにいいね可能"
    user_infos {
        int id PK
        string name "名前"
        string e-mail "メールアドレス"
        timestamp created_at "作成日時"
        timestamp updated_at "更新日時"
    }
    tasks {
        int id PK
        int user_id "投稿者"
        string text "投稿内容"
        boolean is_task_finished "タスク完了フラグ"
        int fight_num "いいねの数"
        timestamp created_at "作成日時"
        timestamp updated_at "更新日時"
    }

    relationships {
      int id PK
      int follower_id FK "フォローする側"
      int followed_id  FK "フォローされる側"
      boolean follow_now "フォローフラグ"
      timestamp created_at "作成日時"
      timestamp updated_at "更新日時"
    }

    fights {
      int id PK
      int user_id FK "いいねを押したユーザー"
      int task_id FK "いいねを押されたタスク"
      boolean fight_now "いいねフラグ"
      timestamp created_at "作成日時"
      timestamp updated_at "更新日時"
    }
```

## 使用技術

Rails x Vue

- フロントエンド: vue.js
- バックエンド: rails
- API 通信: Axios
- 開発環境: Docker
- その他: Vuex, Vue Router

## 今後の展望

Twitter のクローンのようなアプリ開発を行っています。よって、Twitter で実装されている機能を作成していきたいと考えています。

1. ブロック機能:ブロックしたユーザの投稿を非表示
2. タスク固定機能: 自分が一番上に表示したい投稿を固定可能(しなくても良い)
3. 引用機能: 他のユーザーの投稿を引用し、自分のタスクを作成
