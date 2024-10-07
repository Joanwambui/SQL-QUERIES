SELECT *
FROM StudentEngagement

ALTER TABLE StudentEngagement
ADD Countoffirstdaywatched INT,
    Countoffirstdaypurchased INT;


UPDATE StudentEngagement
SET 
    Countoffirstdaywatched = CASE 
                                WHEN first_date_watched IS NULL THEN NULL 
                                ELSE 1 
                             END,
    Countoffirstdaypurchased = CASE 
                                WHEN first_date_purchased IS NULL THEN NULL 
                                ELSE 1 
                               END;


SELECT * 
FROM StudentEngagement;



SELECT 
    ROUND(COUNT(date_diff_watch_purch) * 1.0 / NULLIF(COUNT(date_registered), 0), 2) AS conversion_rate,
    ROUND(SUM(COALESCE(Countoffirstdaywatched, 0)) * 1.0 / NULLIF(COUNT(student_id), 0), 2) AS av_reg_watch,
    ROUND(SUM(COALESCE(Countoffirstdaypurchased, 0)) * 1.0 / NULLIF(COUNT(student_id), 0), 2) AS av_watch_purch
FROM StudentEngagement;


