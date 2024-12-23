SELECT *
FROM qbstats_2015_2016 

Find the quarterback who threw the longest throw in 2016. Output the quarterback name along with their corresponding longest throw.
The 'lg' column contains the longest completion by the quarterback.

SELECT TOP 1 qb, lg AS Longest_throw
FROM qbstats_2015_2016 
WHERE lg = (SELECT MAX(lg) FROM qbstats_2015_2016 )