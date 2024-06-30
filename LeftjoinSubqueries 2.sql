SELECT A.author_id, A.author_name, B.book_title AS last_book_title
FROM Authors A
LEFT JOIN (
    SELECT B.author_id, B.book_id, MAX(S.sale_date) AS last_sale_date
    FROM Sales S
    INNER JOIN Books B ON S.book_id = B.book_id
    GROUP BY B.author_id, B.book_id
) AS LastSale
ON A.author_id = LastSale.author_id
LEFT JOIN Books B
ON LastSale.book_id = B.book_id
AND LastSale.last_sale_date = (SELECT MAX(S2.sale_date) 
                               FROM Sales S2 
                               WHERE S2.book_id = B.book_id);
