SELECT DISTINCT *
FROM proj_count_per_res
WHERE projects = (SELECT max(projects) FROM proj_count_per_res)
AND birthdate > "1983-01-01";