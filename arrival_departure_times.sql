--You are given a day worth of scheduled departure and arrival times of trains at one train station. 
--One platform can only accommodate one train from the beginning of the minute it's scheduled to arrive until the end of the minute it's scheduled to depart.
--Find the minimum number of platforms necessary to accommodate the entire scheduled traffic.


WITH cte AS (
    SELECT arrival_time AS event_time, 1 AS event_type
    FROM train_arrivals
    UNION ALL
    SELECT departure_time AS event_time, -1 AS event_type
    FROM train_departures
)
SELECT MAX(platforms_needed) AS min_platforms
FROM (
    SELECT event_time, 
           SUM(event_type) OVER (ORDER BY event_time, event_type) AS platforms_needed
    FROM cte
) AS platformcount;
