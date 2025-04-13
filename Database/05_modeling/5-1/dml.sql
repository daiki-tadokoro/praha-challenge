-- ユーザ作成
INSERT INTO Users (id, name) VALUES ('1', 'John Doe');
INSERT INTO Users (id, name) VALUES ('2', 'Jane Smith');
INSERT INTO Users (id, name) VALUES ('3', 'Jim Beam');

-- 記事作成
INSERT INTO Articles (id, created_by, latest_history_id) VALUES ('1', '1', NULL);
INSERT INTO Articles (id, created_by, latest_history_id) VALUES ('2', '1', NULL);
INSERT INTO Articles (id, created_by, latest_history_id) VALUES ('3', '1', NULL);
INSERT INTO Articles (id, created_by, latest_history_id) VALUES ('4', '2', NULL);

-- 記事履歴作成
INSERT INTO Article_histories (id, article_id, edited_by, title, body, visibility) VALUES ('1', '1', '1', 'Article 1', 'This is the first article.', 'public');
INSERT INTO Article_histories (id, article_id, edited_by, title, body, visibility) VALUES ('2', '2', '1', 'Article 2', 'This is the second article.', 'draft');
INSERT INTO Article_histories (id, article_id, edited_by, title, body, visibility) VALUES ('3', '3', '1', 'Article 3', 'This is the third article.', 'archive');
INSERT INTO Article_histories (id, article_id, edited_by, title, body, visibility) VALUES ('4', '4', '2', 'Article 4', 'This is the fourth article.', 'public');

-- 記事履歴の更新
UPDATE Articles SET latest_history_id = '1' WHERE id = '1';
UPDATE Articles SET latest_history_id = '2' WHERE id = '2';
UPDATE Articles SET latest_history_id = '3' WHERE id = '3';
UPDATE Articles SET latest_history_id = '4' WHERE id = '4';


-- INDEX 追加
-- Article_histories から特定記事の履歴一覧を取りたい場合
CREATE INDEX idx_article_histories_article_id ON Article_histories(article_id);

-- 公開中の記事だけ一覧に出したい場合（visibility を WHERE で絞る）
CREATE INDEX idx_article_histories_visibility ON Article_histories(visibility);

-- Articles の作成者ごとの記事をよく見るなら
CREATE INDEX idx_articles_created_by ON Articles(created_by);