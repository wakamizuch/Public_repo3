# ER 図

## TODO リストデータベース

```mermaid
%%{init:{'theme':'forest'}}%%
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
