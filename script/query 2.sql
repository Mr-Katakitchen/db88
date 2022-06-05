#Opsi Deyteri

SELECT res_id AS researcher_id, concat(first_name,' ',last_name) AS researcher_name #SELECT researcher
FROM researcher
GROUP BY res_id;

SELECT concat(first_name,' ',last_name) AS researcher_name, 
		title AS evaluated_project, started_on AS project_started_on, proj_id AS project_id,
		grade AS grade_given,
		date AS evaluation_date
FROM evaluation 
WHERE res_id = 13 #id OF selected researcher-evaluator
GROUP BY proj_id;

#Opsi Prwti

SELECT concat(first_name, ' ', last_name) AS researcher_name, gender, birthdate, name AS organization_name #SELECT researcher 
FROM researcher 
INNER JOIN organization ON researcher.org_id = organization.org_id 
GROUP BY res_id;

SELECT concat(first_name, ' ', last_name) AS researcher_name, title AS project_title, budget, started_on, ends_on
FROM project 
INNER JOIN works_on ON works_on.proj_id = project.proj_id 
INNER JOIN researcher ON researcher.res_id = works_on.res_id 
WHERE researcher.res_id = 100 #id OF selected researcher
GROUP BY project.proj_id;


