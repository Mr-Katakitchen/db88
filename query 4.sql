SELECT
	org1.name,
	org1.org_id,
	count(proj_id) projects
FROM
	organization org1
INNER JOIN project ON
	project.org_id = org1.org_id
INNER JOIN organization org2 ON
	org1.org_id != org2.org_id
	AND
	(SELECT
		count(proj_id)
	FROM
		project
	WHERE
		org1.org_id = project.org_id)
		=
		(SELECT
		count(proj_id)
	FROM
		project
	WHERE
		org2.org_id = project.org_id)
GROUP BY org1.org_id;
