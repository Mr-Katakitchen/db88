SELECT concat(first_name, ' ', last_name) AS researcher_name, age, projects
FROM proj_count_per_res
WHERE projects = (SELECT max(projects)
					FROM proj_count_per_res
					WHERE birthdate > adddate(sysdate(), INTERVAL -40 YEAR)
					)
AND birthdate > adddate(sysdate(), INTERVAL -40 YEAR)
ORDER BY age;