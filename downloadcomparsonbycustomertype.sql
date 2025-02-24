--Find the total number of downloads for paying and non-paying users by date.
--Include only records where non-paying customers have more downloads than paying customers.
--The output should be sorted by earliest date first and contain 3 columns date, non-paying downloads, paying downloads. 


SELECT 
    CAST(md.date AS DATE) AS date,
    SUM(CASE WHEN ma.paying_customer = 'Yes' THEN md.downloads ELSE 0 END) AS paying_downloads,
    SUM(CASE WHEN ma.paying_customer = 'No' THEN md.downloads ELSE 0 END) AS non_paying_downloads
FROM 
    ms_user_dimension mu
JOIN 
    ms_acc_dimension ma ON mu.acc_id = ma.acc_id
JOIN 
    ms_download_facts md ON mu.user_id = md.user_id
GROUP BY 
    CAST(md.date AS DATE)
HAVING 
    SUM(CASE WHEN ma.paying_customer = 'No' THEN md.downloads ELSE 0 END) >
    SUM(CASE WHEN ma.paying_customer = 'Yes' THEN md.downloads ELSE 0 END)
ORDER BY 
    date ASC;
