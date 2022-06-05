DROP VIEW IF EXISTS yearly_projects_per_org;
DROP VIEW IF EXISTS biyearly_projects_per_org;

CREATE VIEW yearly_projects_per_org AS
SELECT org.org_id, org.name,
base.started_on AS from_date,
adddate(base.started_on, INTERVAL 1 year) AS from_date_plus_one, 
count(tail.proj_id) AS one_year_count,
base.proj_id, 
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
GROUP BY org.org_id, base.started_on;

CREATE VIEW biyearly_projects_per_org AS
SELECT org.org_id, org.name,
base.started_on AS from_date,
adddate(base.started_on, INTERVAL 2 year) AS from_date_plus_two, 
count(tail.proj_id) AS two_year_count, 
base.proj_id,
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
GROUP BY org.org_id, base.started_on;