SELECT 
    VALUE,
    COUNT(*) as No_Of_Occurrences
FROM google_file_store
CROSS APPLY STRING_SPLIT(REPLACE(REPLACE(contents , ',', '') , '.' , '') , ' ')
WHERE filename in ('draft1.txt' , 'draft2.txt')
GROUP BY VALUE;

