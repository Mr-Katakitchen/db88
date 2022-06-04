DROP VIEW IF EXISTS proj_per_res;
DROP VIEW IF EXISTS proj_count_per_org;
DROP VIEW IF EXISTS proj_per_org;

CREATE VIEW proj_per_res AS SELECT  
		researcher.res_id, researcher.first_name, researcher.last_name, project.proj_id, project.title, project.budget, started_on, ends_on
FROM
	works_on
INNER JOIN researcher ON
	works_on.res_id = researcher.res_id
INNER JOIN project ON
	works_on.proj_id = project.proj_id
GROUP BY researcher.res_id;

CREATE VIEW proj_per_org AS SELECT 
	organization.org_id, name AS org_name, abbrev, postal_code, street, city, proj_id, title AS project_title, budget, started_on, ends_on
FROM
	organization
INNER JOIN project ON
	organization.org_id = project.org_id;

CREATE VIEW proj_count_per_org AS
	SELECT organization.org_id, name AS org_name, count(project.org_id) AS projects, proj_id, started_on
FROM organization
INNER JOIN project ON
		organization.org_id = project.org_id
GROUP BY
		organization.org_id;
