SELECT
	scientific_field.field_id,
	scientific_field.title,
	project.proj_id,
	project.title
FROM
	field_project
INNER JOIN scientific_field ON
	scientific_field.field_id = field_project.field_id
INNER JOIN project ON
	project.proj_id = field_project.proj_id
WHERE
	project.ends_on > "2022-06-08"
GROUP BY
	project.proj_id;

SELECT
	scientific_field.field_id,
	scientific_field.title,
	researcher.res_id,
	researcher.first_name,
	researcher.last_name,
	started_on
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
	project.started_on > "2021-06-08"
GROUP BY
	researcher.res_id;