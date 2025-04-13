-- ユーザーテーブル
CREATE TABLE Users (
    id VARCHAR(36) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 記事テーブル
CREATE TABLE Articles (
    id VARCHAR(36) PRIMARY KEY,
    created_by VARCHAR(36) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_articles_created_by FOREIGN KEY (created_by) REFERENCES Users(id)
);

-- 記事作成イベントテーブル
CREATE TABLE Article_created_events (
    id VARCHAR(36) PRIMARY KEY,
    article_id VARCHAR(36) NOT NULL,
    user_id VARCHAR(36) NOT NULL,
    title VARCHAR(255) NOT NULL,
    body TEXT NOT NULL,
    initial_visibility ENUM('draft', 'public', 'archive') NOT NULL,
    event_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    sequence_number INT NOT NULL,
    CONSTRAINT fk_article_created_events_article_id FOREIGN KEY (article_id) REFERENCES Articles(id),
    CONSTRAINT fk_article_created_events_user_id FOREIGN KEY (user_id) REFERENCES Users(id),
    INDEX idx_article_created_events_article_id (article_id),
    INDEX idx_article_created_events_sequence (article_id, sequence_number)
);

-- 記事編集イベントテーブル
CREATE TABLE Article_edited_events (
    id VARCHAR(36) PRIMARY KEY,
    article_id VARCHAR(36) NOT NULL,
    user_id VARCHAR(36) NOT NULL,
    old_title VARCHAR(255) NOT NULL,
    new_title VARCHAR(255) NOT NULL,
    old_body TEXT NOT NULL,
    new_body TEXT NOT NULL,
    event_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    sequence_number INT NOT NULL,
    CONSTRAINT fk_article_edited_events_article_id FOREIGN KEY (article_id) REFERENCES Articles(id),
    CONSTRAINT fk_article_edited_events_user_id FOREIGN KEY (user_id) REFERENCES Users(id),
    INDEX idx_article_edited_events_article_id (article_id),
    INDEX idx_article_edited_events_sequence (article_id, sequence_number)
);

-- 記事公開状態変更イベントテーブル
CREATE TABLE Article_visibility_events (
    id VARCHAR(36) PRIMARY KEY,
    article_id VARCHAR(36) NOT NULL,
    user_id VARCHAR(36) NOT NULL,
    old_visibility ENUM('draft', 'public', 'archive') NOT NULL,
    new_visibility ENUM('draft', 'public', 'archive') NOT NULL,
    event_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    sequence_number INT NOT NULL,
    CONSTRAINT fk_article_visibility_events_article_id FOREIGN KEY (article_id) REFERENCES Articles(id),
    CONSTRAINT fk_article_visibility_events_user_id FOREIGN KEY (user_id) REFERENCES Users(id),
    INDEX idx_article_visibility_events_article_id (article_id),
    INDEX idx_article_visibility_events_sequence (article_id, sequence_number)
);

-- 記事の現在の状態テーブル
CREATE TABLE Article_current_states (
    article_id VARCHAR(36) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    body TEXT NOT NULL,
    visibility ENUM('draft', 'public', 'archive') NOT NULL,
    created_by VARCHAR(36) NOT NULL,
    last_edited_by VARCHAR(36) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    updated_at TIMESTAMP NOT NULL,
    last_event_sequence INT NOT NULL,
    CONSTRAINT fk_article_current_states_article_id FOREIGN KEY (article_id) REFERENCES Articles(id),
    CONSTRAINT fk_article_current_states_created_by FOREIGN KEY (created_by) REFERENCES Users(id),
    CONSTRAINT fk_article_current_states_last_edited_by FOREIGN KEY (last_edited_by) REFERENCES Users(id),
    INDEX idx_article_current_states_visibility (visibility)
);