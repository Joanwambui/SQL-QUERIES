WITH running_time 
AS (
  SELECT
    server_id,
    session_status,
    status_time AS start_time,
    LEAD(status_time) OVER (
      PARTITION BY server_id
      ORDER BY status_time) AS stop_time
  FROM server_utilization
)

SELECT
  DATE_PART('days', JUSTIFY_HOURS(SUM(stop_time - start_time))) AS total_uptime_days
FROM running_time
WHERE session_status = 'start'
  AND stop_time IS NOT NULL;

'''
Breakdown

Calculate total uptime for the fleet of servers as a sum of individual server uptimes.
Calculate individual server uptimes as a pre-requisite for the previous step.
In order to calculate individual server uptimes, we need the start time and stop time to be in different columns. That way, we can perform row-wise subtractions of stop_time - start_time.
Ensure that our results are output in integer units of full days.
'''