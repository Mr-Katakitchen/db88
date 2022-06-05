#Opsi Deyteri

SELECT title, department #SELECT program 
FROM program
GROUP BY prog_id;

SELECT program_title, department, project_title, budget, started_on, ends_on
FROM proj_per_prog
WHERE program_title = 'Adams Inc'
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
WHERE concat(first_name, ' ', last_name) = 'Verile D''Adda'
GROUP BY project.proj_id;


