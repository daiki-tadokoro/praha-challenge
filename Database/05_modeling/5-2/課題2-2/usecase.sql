-- 最新の公開記事一覧を取得
SELECT a.id, cs.title, cs.body, cs.visibility, cs.updated_at
FROM Articles a
JOIN Article_current_states cs ON a.id = cs.article_id
WHERE cs.visibility = 'public'
ORDER BY cs.updated_at DESC;

-- 特定の記事の編集履歴を取得
SELECT e.event_time, e.old_title, e.new_title, u.name as editor_name
FROM Article_edited_events e
JOIN Users u ON e.user_id = u.id
WHERE e.article_id = '1'
ORDER BY e.sequence_number ASC;

-- 特定の記事の公開状態変更履歴を取得
SELECT v.event_time, v.old_visibility, v.new_visibility, u.name as changed_by
FROM Article_visibility_events v
JOIN Users u ON v.user_id = u.id
WHERE v.article_id = '1'
ORDER BY v.sequence_number ASC;

-- 特定の時点の記事の状態を再構築（2番目の編集後の状態）
SELECT 
    e.new_title as title, 
    e.new_body as body,
    (SELECT v.new_visibility 
     FROM Article_visibility_events v 
     WHERE v.article_id = '1' AND v.sequence_number <= 2 
     ORDER BY v.sequence_number DESC LIMIT 1) as visibility
FROM Article_edited_events e
WHERE e.article_id = '1' AND e.sequence_number = 2;

-- 特定のユーザーが編集した記事一覧
SELECT DISTINCT a.id, cs.title, cs.updated_at
FROM Articles a
JOIN Article_current_states cs ON a.id = cs.article_id
JOIN Article_edited_events e ON a.id = e.article_id
WHERE e.user_id = '1'
ORDER BY cs.updated_at DESC;