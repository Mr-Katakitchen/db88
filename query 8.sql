SELECT 
	concat(first_name, ' ', last_name) AS researcher_name, projects
FROM taskless_proj_count_per_res
WHERE projects >= 5;


