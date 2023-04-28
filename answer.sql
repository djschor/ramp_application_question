WITH daily_total AS (
    SELECT
        DATE(transaction_time) AS day,
        SUM(transaction_amount) AS total_amount
    FROM transactions
    WHERE DATE(transaction_time) BETWEEN '2021-01-29' AND '2021-01-31'
    GROUP BY day
),
rolling_avg AS (
    SELECT
        day,
        AVG(total_amount) OVER (
            ORDER BY day
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS rolling_average
    FROM daily_total
)
SELECT
    day,
    rolling_average
FROM rolling_avg
WHERE day = '2021-01-31';
