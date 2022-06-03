SELECT guy1.*, company.org_id, organization.name AS company_name, project.budget
FROM executive guy1
INNER JOIN project ON
project.exec_id = guy1.exec_id
INNER JOIN organization ON
organization.org_id = project.org_id
INNER JOIN company ON
organization.org_id = company.org_id
WHERE project.budget = (SELECT max(project.budget) 
						FROM project 
						INNER JOIN executive ON executive.exec_id = project.exec_id 
						WHERE guy1.exec_id = executive.exec_id)
ORDER BY project.budget DESC
LIMIT 5;
