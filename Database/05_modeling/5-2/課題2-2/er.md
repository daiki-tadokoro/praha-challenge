```mermaid

erDiagram
  Users ||--o{ Articles : "作成"
  Users ||--o{ Article_created_events : "作成"
  Users ||--o{ Article_edited_events : "編集"
  Users ||--o{ Article_visibility_events : "状態変更"
  Articles ||--o{ Article_created_events : "作成履歴"
  Articles ||--o{ Article_edited_events : "編集履歴"
  Articles ||--o{ Article_visibility_events : "状態変更履歴"
  Articles ||--|| Article_current_states : "現在の状態"

  Users {
    varchar(36) id PK
    string name
    timestamp created_at
  }

  Articles {
    varchar(36) id PK
    varchar(36) created_by FK "Users.id"
    timestamp created_at
  }

  Article_created_events {
    varchar(36) id PK
    varchar(36) article_id FK "Articles.id"
    varchar(36) user_id FK "Users.id"
    string title
    text body
    enum initial_visibility "draft, public, archive"
    timestamp event_time
    int sequence_number
  }

  Article_edited_events {
    varchar(36) id PK
    varchar(36) article_id FK "Articles.id"
    varchar(36) user_id FK "Users.id"
    string old_title
    string new_title
    text old_body
    text new_body
    timestamp event_time
    int sequence_number
  }

  Article_visibility_events {
    varchar(36) id PK
    varchar(36) article_id FK "Articles.id"
    varchar(36) user_id FK "Users.id"
    enum old_visibility "draft, public, archive"
    enum new_visibility "draft, public, archive"
    timestamp event_time
    int sequence_number
  }

  Article_current_states {
    varchar(36) article_id PK,FK "Articles.id"
    string title
    text body
    enum visibility "draft, public, archive"
    varchar(36) created_by FK "Users.id"
    varchar(36) last_edited_by FK "Users.id"
    timestamp created_at
    timestamp updated_at
    int last_event_sequence
  }