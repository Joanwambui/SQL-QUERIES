SELECT 
    content_id,
    content_text AS Original_Text,
    STRING_AGG(UPPER(LEFT(value, 1)) + LOWER(SUBSTRING(value, 2, LEN(value))), ' ') AS Modified_Text
    
FROM 
    user_content
CROSS APPLY 
    STRING_SPLIT(content_text, ' ') -- Split the text into words
GROUP BY 
    content_id, content_text;
