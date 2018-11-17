WITH all_sales as (
SELECT
      T.tm_month,
      S.sale_units * S.sale_price AS total_sales
FROM
    dwdaysalesfact S
    INNER JOIN dwtime T
          on S.tm_id = T.tm_id
)
SELECT
      tm_month,
      COUNT( * ) as all_products_sold,
      SUM( total_sales ) as total_sales
FROM
    all_sales
GROUP BY
    tm_month 
;