WITH yearly_spend AS (SELECT 
EXTRACT(YEAR FROM transaction_date) as year,
product_id,
spend as curr_year_spend,
LAG(spend) OVER(PARTITION BY product_id ORDER BY product_id,
EXTRACT(YEAR FROM transaction_date)) AS prev_year_spend
FROM user_transactions)

SELECT 
*,
Round(100.0 * (curr_year_spend - prev_year_spend)/prev_year_spend, 2) as yoy_rate
FROM yearly_spend
ORDER BY product_id,year ASC;
