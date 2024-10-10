
SELECT 
    from_user, 
    COUNT(from_user) AS total_emails, 
    ROW_NUMBER() OVER (ORDER BY COUNT(from_user) DESC) AS row_number
FROM 
    google_gmail_emails
GROUP BY 
    from_user
ORDER BY 
    total_emails DESC, from_user ASC
