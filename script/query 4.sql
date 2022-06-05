SELECT #org1.org_id AS id1, 
	   org1.name AS organization_1, 
	   #org2.org_id AS id2, 
	   org2.name AS organization_2,
	   org1.from_date AS base_date, max(org1.two_year_count) AS projects
FROM biyearly_projects_per_org org1
INNER JOIN biyearly_projects_per_org org2 ON org1.org_id <> org2.org_id
WHERE org2.from_date > org1.from_date AND org2.tail_date < org1.from_date_plus_two
AND org1.org_id < org2.org_id
AND org1.two_year_count = org2.two_year_count
AND (SELECT one_year_count 
	FROM yearly_projects_per_org 
	WHERE org_id = org1.org_id
	AND from_date = org1.from_date
	AND base_id = org1.base_id
	) >= 10
AND (SELECT temp.one_year_count 
	FROM yearly_projects_per_org temp
	WHERE temp.org_id = org1.org_id
	AND temp.from_date >= adddate(org1.from_date, INTERVAL 1 YEAR)
	AND temp.tail_date <= adddate(org1.from_date, INTERVAL 2 year)
	AND temp.one_year_count =
		(SELECT max(one_year_count) FROM yearly_projects_per_org WHERE org_id = org1.org_id
															     AND from_date >= adddate(org1.from_date, INTERVAL 1 YEAR)
																 AND temp.tail_date <= adddate(org1.from_date, INTERVAL 2 year))
	GROUP BY temp.from_date
	) >= 10
AND (SELECT one_year_count 
	FROM yearly_projects_per_org 
	WHERE org_id = org2.org_id
	AND from_date = org2.from_date
	AND base_id = org2.base_id
	) >= 10
AND (SELECT temp.one_year_count 
	FROM yearly_projects_per_org temp
	WHERE temp.org_id = org2.org_id
	AND temp.from_date >= adddate(org2.from_date, INTERVAL 1 YEAR)
	AND temp.tail_date <= adddate(org2.from_date, INTERVAL 2 year)
	AND temp.one_year_count =
		(SELECT max(one_year_count) FROM yearly_projects_per_org WHERE org_id = org2.org_id
																 AND from_date >= adddate(org2.from_date, INTERVAL 1 YEAR)
																 AND temp.tail_date <= adddate(org2.from_date, INTERVAL 2 year))
	GROUP BY temp.from_date
	) >= 10
GROUP BY org1.org_id, org2.org_id, org1.from_date
ORDER BY projects desc;

