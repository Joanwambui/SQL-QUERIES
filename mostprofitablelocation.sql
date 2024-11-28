--Find the most profitable location. 
--Write a query that calculates the average signup duration and average transaction amount for each location, 
--and then compare these two measures together by taking the ratio of the average transaction amount and average duration for each location.

--Your output should include the location, average duration, average transaction amount, and ratio. Sort your results from highest ratio to lowest.

CREATE TABLE signups (signup_id INT PRIMARY KEY, signup_start_date DATETIME, signup_stop_date DATETIME, plan_id INT, location VARCHAR(100));

INSERT INTO signups (signup_id, signup_start_date, signup_stop_date, plan_id, location) VALUES (1, '2020-01-01 10:00:00', '2020-01-01 12:00:00', 101, 'New York'), 
(2, '2020-01-02 11:00:00', '2020-01-02 13:00:00', 102, 'Los Angeles'),
(3, '2020-01-03 10:00:00', '2020-01-03 14:00:00', 103, 'Chicago'), (4, '2020-01-04 09:00:00', '2020-01-04 10:30:00', 101, 'San Francisco'),
(5, '2020-01-05 08:00:00', '2020-01-05 11:00:00', 102, 'New York');

CREATE TABLE transactions (transaction_id INT PRIMARY KEY,signup_id INT,transaction_start_date DATETIME,amt FLOAT,FOREIGN KEY (signup_id) 
REFERENCES signups(signup_id));

INSERT INTO transactions (transaction_id, signup_id, transaction_start_date, amt) VALUES (1, 1, '2020-01-01 10:30:00', 50.00), 
(2, 1, '2020-01-01 11:00:00', 30.00), (3, 2, '2020-01-02 11:30:00', 100.00), (4, 2, '2020-01-02 12:00:00', 75.00), (5, 3, '2020-01-03 10:30:00', 120.00), 
(6, 4, '2020-01-04 09:15:00', 80.00), (7, 5, '2020-01-05 08:30:00', 90.00);

-- Select everything from signups
SELECT *
FROM signups;

-- Select everything from transactions
SELECT *
FROM transactions;

-- Common Table Expression (CTE) for initial calculations
WITH cte AS (
    SELECT 
        S.signup_id, 
        S.signup_start_date, 
        S.signup_stop_date, 
        S.plan_id,
        S.location, 
        T.transaction_id,
        T.transaction_start_date,
        T.amt, 
        DATEDIFF(MINUTE, S.signup_start_date, S.signup_stop_date) AS diffinminutes
    FROM signups S
    INNER JOIN transactions T
    ON S.signup_id = T.signup_id
),
-- Aggregate data by location
aggregated_data AS (
    SELECT 
        location,
        AVG(amt) AS average_transaction_amount,
        AVG(diffinminutes) AS average_signup_duration
    FROM cte
    GROUP BY location
),
-- Calculate the ratio of average transaction amount to average signup duration
final_data AS (
    SELECT 
        location,
        average_signup_duration,
        average_transaction_amount,
        CASE 
            WHEN average_signup_duration = 0 THEN NULL -- Handle division by zero
            ELSE (average_transaction_amount / average_signup_duration)
        END AS ratio
    FROM aggregated_data
)
-- Output sorted by ratio from highest to lowest
SELECT 
    location,
    average_signup_duration AS average_duration_in_minutes,
    average_transaction_amount AS average_amount,
    ratio
FROM final_data
ORDER BY ratio DESC;
