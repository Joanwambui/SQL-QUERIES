
--select * from airbnb_search_details;
SELECT city, property_type,AVG(cast(bathrooms as float)),AVG(cast(bedrooms as float))
from airbnb_search_details
GROUP BY city, property_type

  
SELECT AVG(booking_cost) AS avg_booking_cost
FROM fct_corporate_bookings f
INNER JOIN dim_companies d
  ON f.company_id = d.company_id
WHERE strftime('%Y-%m', f.booking_date) = '2024-01';
