-- ユーザー作成
INSERT INTO Users (id, name) VALUES ('1', 'user1');

-- 記事作成
INSERT INTO Articles (id, created_by) VALUES ('1', '1');

-- 記事作成イベント
INSERT INTO Article_created_events 
(id, article_id, user_id, title, body, initial_visibility, event_time, sequence_number) 
VALUES ('1', '1', '1', '初めての記事', 'これは最初の記事です。', 'draft', NOW(), 1);

-- 記事編集イベント
INSERT INTO Article_edited_events 
(id, article_id, user_id, old_title, new_title, old_body, new_body, event_time, sequence_number) 
VALUES ('2', '1', '1', '初めての記事', '更新された記事', 'これは最初の記事です。', 'これは更新された記事です。', NOW(), 2);

-- 公開状態変更イベント
INSERT INTO Article_visibility_events 
(id, article_id, user_id, old_visibility, new_visibility, event_time, sequence_number) 
VALUES ('3', '1', '1', 'draft', 'public', NOW(), 3);

-- 現在の状態を更新
INSERT INTO Article_current_states 
(article_id, title, body, visibility, created_by, last_edited_by, created_at, updated_at, last_event_sequence) 
VALUES ('1', '更新された記事', 'これは更新された記事です。', 'public', '1', '1', NOW(), NOW(), 3);