SELECT SalesRepID
FROM #Orders
GROUP BY SalesRepID
HAVING count(Salestype)>1