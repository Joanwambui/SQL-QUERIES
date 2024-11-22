WITH AggregatedData AS (
    SELECT 
        cust.id AS id, 
        cust.first_name, 
        cust.last_name, 
        SUM(ord.total_order_cost) AS totalcost
    FROM 
        customers3 cust
    INNER JOIN 
        card_orders ord
    ON 
        cust.id = ord.cust_id
    GROUP BY 
        cust.id, cust.first_name, cust.last_name
),
RankedData AS (
    SELECT 
        id, 
        first_name, 
        last_name, 
        totalcost,
        RANK() OVER (ORDER BY totalcost DESC) AS rank
    FROM 
        AggregatedData
)
SELECT 
    id, 
    first_name, 
    last_name, 
    totalcost,
    rank
FROM 
    RankedData
WHERE 
    rank = 3;
