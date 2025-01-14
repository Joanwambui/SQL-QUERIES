SELECT 	LEN(REPLACE(REPLACE(REPLACE(business_name, '-', ''), '_', ''), '&', '')) AS no_Spaces_removed,
LEN(REPLACE(REPLACE(REPLACE(REPLACE(business_name, '-', ''), '_', ''), '&', ''), ' ', '')) + 1 AS spaces_removed,
	LEN(REPLACE(REPLACE(REPLACE(business_name, '-', ''), '_', ''), '&', '')) -
    LEN(REPLACE(REPLACE(REPLACE(REPLACE(business_name, '-', ''), '_', ''), '&', ''), ' ', '')) + 1 AS cleaned_string, 
    business_name
FROM 
    sf_restaurant_health_violations;
