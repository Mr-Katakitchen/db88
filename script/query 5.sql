SELECT DISTINCT field_pair.*, count(proj_id) AS projects
FROM
	field_pair
GROUP by id1, id2
ORDER BY projects DESC
LIMIT 6;
