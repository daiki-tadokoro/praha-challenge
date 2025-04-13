-- 記事を作成する

INSERT INTO Articles (id, created_by, latest_history_id) VALUES ('5', '1', NULL);
INSERT INTO Article_histories (id, article_id, edited_by, title, body, visibility) VALUES ('5', '5', '1', 'Article 5', 'This is the fifth article5', 'public');
UPDATE Articles SET latest_history_id = '5' WHERE id = '5';

-- 記事の文言を変更する

INSERT INTO Article_histories (id, article_id, edited_by, title, body, visibility) VALUES ('6', '5', '1', 'Article 5.1', 'This is the fifth article5.1', 'public');
UPDATE Articles SET latest_history_id = '6' WHERE id = '5';

-- 記事を下書きにする

INSERT INTO Article_histories (id, article_id, edited_by, title, body, visibility) VALUES ('7', '5', '1', 'Article 5.1', 'This is the fifth article5.1', 'draft');
UPDATE Articles SET latest_history_id = '7' WHERE id = '5';

-- 記事を公開する

INSERT INTO Article_histories (id, article_id, edited_by, title, body, visibility) VALUES ('8', '5', '1', 'Article 5.1', 'This is the fifth article5.1', 'public');
UPDATE Articles SET latest_history_id = '8' WHERE id = '5';

-- 記事を復元する

INSERT INTO Article_histories (id, article_id, edited_by, title, body, visibility) VALUES ('9', '5', '1', 'Article 5', 'This is the fifth article5', 'public');
UPDATE Articles SET latest_history_id = '9' WHERE id = '5';

-- 最新記事を表示する

SELECT Articles.id, Article_histories.*
  FROM Articles
  JOIN Article_histories ON Article_histories.id = Articles.id
  WHERE Article_histories.visibility = "public";

-- ユーザー1が作成した記事の最新状態を取得

SELECT Articles.id, Article_histories.*
FROM Articles
JOIN Article_histories ON Articles.latest_history_id = Article_histories.id
WHERE Articles.created_by = '1'
  AND Article_histories.visibility = 'public';

-- 記事を削除する

INSERT INTO Article_histories (id, article_id, edited_by, title, body, visibility) VALUES ('10', '5', '1', 'Article 5', 'This is the fifth article5', 'archive');
UPDATE Articles SET latest_history_id = '10' WHERE id = '5';

-- 特定の記事の履歴を一覧表示できる

SELECT Article_histories.*
FROM Article_histories
WHERE article_id = '5';
