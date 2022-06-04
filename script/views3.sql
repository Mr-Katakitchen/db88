DROP VIEW IF EXISTS yearly_projects_per_org;

CREATE VIEW yearly_projects_per_org AS
SELECT organization.org_id, organization.name,
base.started_on AS from_date,
adddate(base.started_on, INTERVAL 1 year) AS to_date, 
YEAR(base.started_on) AS from_year,
YEAR(base.started_on) + 1 AS to_year,
count(other.proj_id) AS projects
FROM organization
INNER JOIN project base ON
organization.org_id = base.org_id
INNER JOIN project other ON
other.started_on >= base.started_on
AND to_days(other.started_on) <= to_days(base.started_on) + 365
GROUP BY organization.org_id, base.proj_id;