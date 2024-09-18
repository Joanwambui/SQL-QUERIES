SELECT FullName, MentionedAuthors1 AS MentionedAuthors
FROM Mamamboga
WHERE MentionedAuthors1 IS NOT NULL

UNION ALL

SELECT FullName, MentionedAuthors2 AS MentionedAuthors
FROM Mamamboga
WHERE MentionedAuthors2 IS NOT NULL

UNION ALL

SELECT FullName, MentionedAuthors3 AS MentionedAuthors
FROM Mamamboga
WHERE MentionedAuthors3 IS NOT NULL

UNION ALL

SELECT FullName, MentionedAuthors4 AS MentionedAuthors
FROM Mamamboga
WHERE MentionedAuthors4 IS NOT NULL

UNION ALL

SELECT FullName, MentionedAuthors5 AS MentionedAuthors
FROM Mamamboga
WHERE MentionedAuthors5 IS NOT NULL

UNION ALL

SELECT FullName, MentionedAuthors6 AS MentionedAuthors
FROM Mamamboga
WHERE MentionedAuthors6 IS NOT NULL;
