DROP VIEW IF EXISTS proj_per_res;
DROP VIEW IF EXISTS proj_count_per_org;
DROP VIEW IF EXISTS evaluation;
DROP VIEW IF EXISTS field_pair;
DROP VIEW IF EXISTS proj_count_per_res;
DROP VIEW IF EXISTS taskless_proj_count_per_res;
DROP VIEW IF EXISTS yearly_projects_per_org;
DROP VIEW IF EXISTS biyearly_projects_per_org;

CREATE VIEW proj_per_res AS SELECT  
		researcher.res_id, first_name, last_name, project.proj_id, title, budget, started_on, ends_on
FROM
	works_on
INNER JOIN researcher ON
	works_on.res_id = researcher.res_id
INNER JOIN project ON
	works_on.proj_id = project.proj_id
GROUP BY researcher.res_id;

CREATE VIEW evaluation AS SELECT 
	project.proj_id, title, started_on, researcher.res_id, first_name, last_name, grade, evaluates.date
FROM
	evaluates
INNER JOIN project ON
	project.proj_id = evaluates.proj_id
INNER JOIN researcher ON
	researcher.res_id = evaluates.res_id 
GROUP BY proj_id;

CREATE VIEW field_pair AS
	SELECT field1.title AS title1, field2.title AS title2,  table1.field_id AS id1, table2.field_id AS id2, table1.proj_id
FROM
		field_project table1
INNER JOIN field_project table2 ON
table1.proj_id = table2.proj_id AND table1.field_id <> table2.field_id
INNER JOIN scientific_field field1 ON
field1.field_id = table1.field_id
INNER JOIN scientific_field field2 ON
field2.field_id = table2.field_id;

CREATE VIEW proj_count_per_res AS
	SELECT works_on.res_id, first_name, last_name, gender, birthdate, COUNT(works_on.proj_id) AS projects, year("2022-06-06") - year(birthdate) AS age
FROM works_on
INNER JOIN researcher ON researcher.res_id = works_on.res_id
INNER JOIN project ON works_on.proj_id = project.proj_id
AND ends_on > "2022-06-06"
GROUP BY researcher.res_id;

CREATE VIEW taskless_proj_count_per_res AS 
SELECT 
	researcher.res_id, first_name, last_name, count(project.proj_id) AS projects
FROM researcher
INNER JOIN works_on ON works_on.res_id = researcher.res_id
INNER JOIN project ON project.proj_id = works_on.proj_id
WHERE project.proj_id NOT IN (SELECT task.proj_id FROM task)
GROUP BY researcher.res_id;

CREATE VIEW yearly_projects_per_org AS
SELECT org.org_id, org.name,
base.started_on AS from_date,
adddate(base.started_on, INTERVAL 1 year) AS from_date_plus_one, 
count(tail.proj_id) AS one_year_count,
base.proj_id AS base_id, 
max(tail.started_on) AS tail_date
FROM organization org
INNER JOIN project base ON
org.org_id = base.org_id
INNER JOIN project tail ON 
tail.started_on >= base.started_on AND tail.started_on <= adddate(base.started_on, INTERVAL 1 year)
WHERE EXISTS 
	(SELECT organization.org_id, project.proj_id 
	FROM organization 
	INNER JOIN project ON organization.org_id = project.org_id
	WHERE organization.org_id = org.org_id 
	AND project.proj_id = tail.proj_id)
GROUP BY org.org_id, base.proj_id;

CREATE VIEW biyearly_projects_per_org AS
SELECT org.org_id, org.name,
base.started_on AS from_date,
adddate(base.started_on, INTERVAL 2 year) AS from_date_plus_two, 
count(tail.proj_id) AS two_year_count, 
base.proj_id AS base_id,
max(tail.started_on) AS tail_date
FROM organization org
INNER JOIN project base ON
org.org_id = base.org_id
INNER JOIN project tail ON 
tail.started_on >= base.started_on AND tail.started_on <= adddate(base.started_on, INTERVAL 2 year)
WHERE EXISTS 
	(SELECT organization.org_id, project.proj_id 
	FROM organization 
	INNER JOIN project ON organization.org_id = project.org_id
	WHERE organization.org_id = org.org_id 
	AND project.proj_id = tail.proj_id)
GROUP BY org.org_id, base.proj_id;
