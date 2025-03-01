SELECT 
    ticker, 
    date, 
    close, 
    ROUND(((close - LAG(close) OVER (PARTITION BY ticker ORDER BY date)) / LAG(close) OVER (PARTITION BY ticker ORDER BY date)) * 100, 2) AS percentage_change
FROM 
    stock_prices
    
LIMIT 
    20;
