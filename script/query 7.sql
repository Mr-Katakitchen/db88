SELECT executive.*, company.org_id, organization.name AS company_name, sum(project.budget) AS total_fund
FROM executive 
INNER JOIN project ON
project.exec_id = executive.exec_id
INNER JOIN organization ON
organization.org_id = project.org_id
INNER JOIN company ON
organization.org_id = company.org_id
GROUP BY executive.exec_id
ORDER BY total_fund DESC
LIMIT 5;

