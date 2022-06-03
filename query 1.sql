SELECT
	works_on.proj_id,
	researcher.*
FROM
	works_on
INNER JOIN researcher ON
	researcher.res_id = works_on.res_id
INNER JOIN project ON
	(
	SELECT 
		proj_id
	FROM
		project
	WHERE 
		proj_id = 74
	)
		= works_on.proj_id
GROUP BY
	researcher.res_id;

