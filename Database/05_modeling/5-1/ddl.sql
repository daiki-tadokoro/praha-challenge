-- ユーザテーブル(R)
CREATE TABLE Users (
    id VARCHAR(36) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 記事テーブル(R)
CREATE TABLE Articles (
    id VARCHAR(36) PRIMARY KEY,
    latest_history_id VARCHAR(36),
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by int NOT NULL,
    CONSTRAINT fk_articles_latest_history_id FOREIGN KEY (latest_history_id) REFERENCES Article_histories(id),
    CONSTRAINT fk_articles_created_by FOREIGN KEY (created_by) REFERENCES Users(id)
);

-- 記事履歴テーブル(R)
CREATE TABLE Article_histories (
    id VARCHAR(36) PRIMARY KEY,
    article_id VARCHAR(36) NOT NULL,
    edited_by VARCHAR(36) NOT NULL,
    title VARCHAR(255) NOT NULL,
    body TEXT NOT NULL,
    visibility enum('draft', 'public', 'archive') NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_article_histories_edited_by FOREIGN KEY (edited_by) REFERENCES Users(id),
    CONSTRAINT fk_article_histories_article_id FOREIGN KEY (article_id) REFERENCES Articles(id)
);

-- INDEX 追加
-- Article_histories から特定記事の履歴一覧を取りたい場合
CREATE INDEX idx_article_histories_article_id ON Article_histories(article_id);

-- 公開中の記事だけ一覧に出したい場合（visibility を WHERE で絞る）
CREATE INDEX idx_article_histories_visibility ON Article_histories(visibility);

-- Articles の作成者ごとの記事をよく見るなら
CREATE INDEX idx_articles_created_by ON Articles(created_by);