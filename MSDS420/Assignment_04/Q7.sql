WITH all_sales as (
SELECT
      T.tm_month,
      P.p_code,
      P.p_category,
      S.sale_units * S.sale_price AS total_sales
FROM
    dwdaysalesfact S
    INNER JOIN dwtime T
          on S.tm_id = T.tm_id
    INNER JOIN dwproduct P
          on S.p_code = P.p_code
)
SELECT
      tm_month,
      p_category,
      p_code,      
      COUNT( * ) as total_sold,
      SUM( total_sales ) as total_sales
FROM
    all_sales
GROUP BY
    tm_month,
    p_code,
    p_category
ORDER BY
    tm_month,
    p_category,
    p_code,
    total_sales
;