SELECT 
    from_user, 
    COUNT(*) AS total_emails, 
    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC, from_user ASC) AS row_number
FROM 
    google_gmail_emails
GROUP BY 
    from_user
ORDER BY total_emails DESC, from_user ASC