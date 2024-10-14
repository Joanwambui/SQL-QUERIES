--select * from airbnb_search_details;
SELECT city, property_type,AVG(cast(bathrooms as float)),AVG(cast(bedrooms as float))
from airbnb_search_details
GROUP BY city, property_type