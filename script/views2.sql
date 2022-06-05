DROP VIEW IF EXISTS field_pair;
DROP VIEW IF EXISTS proj_count_per_res;
DROP VIEW IF EXISTS taskless_proj_count_per_res;

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
GROUP BY works_on.res_id;

CREATE VIEW taskless_proj_count_per_res AS 
SELECT 
	researcher.res_id, first_name, last_name, count(project.proj_id) AS projects
FROM researcher
INNER JOIN works_on ON works_on.res_id = researcher.res_id
INNER JOIN project ON project.proj_id = works_on.proj_id
WHERE project.proj_id NOT IN (SELECT task.proj_id FROM task)
GROUP BY researcher.res_id;
