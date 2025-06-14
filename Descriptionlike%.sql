--METHOD 1
/*
SELECT DISTINCT winery
FROM winemag_p1
WHERE description LIKE '%plum[,. /-]%'
OR description LIKE '%cherry[,. /-]%' 
OR description LIKE '%rose[,. /-]%' 
OR description LIKE '%hazelnut[,. /-]%' 
ORDER BY 1
*/


--METHOD 2
SELECT DISTINCT winery
FROM winemag_p1
WHERE description LIKE '%[^a-z]plum[^a-z]%'
OR description LIKE '%[^a-z]cherry[^a-z]%' 
OR description LIKE '%[^a-z]rose[^a-z]%' 
OR description LIKE '%[^a-z]hazelnut[^a-z]%' 
ORDER BY 1
