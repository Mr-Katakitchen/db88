SELECT title1 AS field1, title2 AS field2, count(proj_id) AS projects
FROM
	field_pair
WHERE id1 > id2
GROUP by id1, id2
ORDER BY projects DESC, id1 desc
LIMIT 3;
