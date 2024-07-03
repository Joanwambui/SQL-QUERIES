SELECT  a.Item AS ItemCart1,
        b.Item AS ItemCart2
FROM    #Cart1 a FULL OUTER JOIN
        #Cart2 b ON a.Item = b.Item;