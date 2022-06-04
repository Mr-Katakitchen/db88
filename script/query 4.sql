SELECT org_id, name, from_date, from_year, count(projects) AS two_year_projects
FROM yearly_projects_per_org org1;/*
WHERE EXISTS (SELECT org2.org_id FROM yearly_projects_per_org org2 
				WHERE (SELECT count(projects) )
*/

