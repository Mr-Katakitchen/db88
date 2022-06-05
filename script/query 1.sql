SELECT 
	title, department #choose program 
FROM program
GROUP BY prog_id; 

SELECT 
	program.title AS program_title, department, 
	project.title AS project_title, project.proj_id AS project_id,
	started_on, ends_on, datediff(ends_on, started_on) AS duration_in_days, 
	concat(first_name,' ',last_name) AS executive_name
FROM 
	project
INNER JOIN program ON
	project.prog_id = program.prog_id AND program.prog_id = 127 #id OF selected program, choose project
INNER JOIN executive ON
	executive.exec_id = project.exec_id
WHERE ends_on > sysdate()
GROUP BY proj_id;   

SELECT project.title AS project_title, concat(first_name,' ',last_name) AS researcher_name, researcher.res_id AS researcher_id
FROM researcher
INNER JOIN works_on ON researcher.res_id = works_on.res_id 
INNER JOIN project ON project.proj_id = works_on.proj_id AND project.proj_id = 129 #id OF selected project
GROUP BY researcher.res_id;
