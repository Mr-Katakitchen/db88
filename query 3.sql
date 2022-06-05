SELECT title 
FROM scientific_field; #SELECT field

SELECT
	scientific_field.title,
	project.title
FROM
	field_project
INNER JOIN scientific_field ON
	scientific_field.field_id = field_project.field_id
INNER JOIN project ON
	project.proj_id = field_project.proj_id
WHERE 
	scientific_field.title = 'Epidemiology' #name OF selected field
and
	project.ends_on > sysdate()
GROUP BY
	project.proj_id;

SELECT
	scientific_field.title,
	concat(first_name, ' ', last_name) AS researcher_name
FROM
	field_project
INNER JOIN scientific_field ON
	scientific_field.field_id = field_project.field_id
INNER JOIN project ON
	project.proj_id = field_project.proj_id
INNER JOIN works_on ON
	works_on.proj_id = project.proj_id
INNER JOIN researcher ON
	researcher.res_id = works_on.res_id
WHERE
	scientific_field.title = 'Epidemiology' #name OF selected field
and
	project.started_on >= adddate(sysdate(), INTERVAL -1 YEAR)
GROUP BY
	researcher.res_id;