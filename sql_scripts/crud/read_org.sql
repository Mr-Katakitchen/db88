#Company

SELECT organization.*, priv_funds
FROM organization
INNER JOIN company ON organization.org_id = company.org_id
WHERE company.org_id = 70
GROUP BY organization.org_id;

SELECT phone_numbers.*
FROM phone_numbers
WHERE phone_numbers.org_id = 70
AND EXISTS 
		(SELECT company.org_id FROM company WHERE company.org_id = phone_numbers.org_id)
GROUP BY phone_numbers.ph_number;

#university

SELECT organization.*, pub_funds
FROM organization
INNER JOIN university ON organization.org_id = university.org_id
WHERE university.org_id = 15
GROUP BY organization.org_id;

SELECT phone_numbers.*
FROM phone_numbers
WHERE phone_numbers.org_id = 15
AND EXISTS 
		(SELECT university.org_id FROM university WHERE university.org_id = phone_numbers.org_id)
GROUP BY phone_numbers.ph_number;

#research center

SELECT organization.*, priv_funds, pub_funds
FROM organization
INNER JOIN research_center ON organization.org_id = research_center.org_id
WHERE research_center.org_id = 35
GROUP BY organization.org_id;

SELECT phone_numbers.*
FROM phone_numbers
WHERE phone_numbers.org_id = 35
AND EXISTS 
		(SELECT research_center.org_id FROM research_center WHERE research_center.org_id = phone_numbers.org_id)
GROUP BY phone_numbers.ph_number;




