SELECT name, birthday 
FROM family_members
WHERE CAST(strftime('%m', birthday) AS INTEGER) = 12