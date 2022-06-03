SELECT *
FROM proj_per_res 
WHERE res_id < 100
GROUP BY proj_id;

SELECT *
FROM proj_per_org 
WHERE org_id < 50
GROUP BY proj_id;