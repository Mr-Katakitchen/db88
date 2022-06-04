SELECT concat(first_name, ' ', last_name) AS researcher_name, birthdate, projects
FROM proj_count_per_res
WHERE projects = (SELECT max(projects)
					FROM proj_count_per_res)
AND birthdate > adddate(sysdate(), INTERVAL -40 YEAR);