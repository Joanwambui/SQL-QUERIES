with jan as (
SELECT *
FROM sf_exchange_rates
WHERE CAST(date AS Date) = '2020-01-01'),

july as (
SELECT *
FROM sf_exchange_rates
WHERE CAST(date AS Date) = '2020-07-01')


SELECT JN.source_currency, JN.exchange_rate AS jan_exchange_rate, JL.exchange_rate AS july_exchange_Rate, (JL.exchange_rate-JN.exchange_rate) AS difference_in_exchange_rates
FROM jan AS JN
JOIN july AS JL
ON JN.source_currency = JL.source_currency

--GROUP BY source_currency

--You are given a list of exchange rates from various currencies to US Dollars (USD) in different months.
--Show how the exchange rate of all the currencies changed in the first half of 2020.
--Output the currency code and the difference between values of the exchange rate between July 1, 2020 and January 1, 2020.

WITH exchange_rate_changes AS (
    SELECT
        source_currency,
        MAX(CASE WHEN date = '2020-01-01' THEN exchange_rate END) AS rate_jan,
        MAX(CASE WHEN date = '2020-07-01' THEN exchange_rate END) AS rate_july
    FROM
        sf_exchange_rates
    WHERE
        target_currency = 'USD'
        AND date IN ('2020-01-01', '2020-07-01')
    GROUP BY
        source_currency
)
SELECT
    source_currency,
    COALESCE(rate_july, 0) - COALESCE(rate_jan, 0) AS rate_change
FROM
    exchange_rate_changes
ORDER BY
    source_currency;

