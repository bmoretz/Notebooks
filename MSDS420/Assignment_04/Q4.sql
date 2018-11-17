SELECT
      T.tm_month,
      P.p_category,
      ROUND( SUM( S.sale_units ) * 
             AVG( S.sale_price ), 2 ) AS total_sales
FROM
    dwdaysalesfact S
    INNER JOIN dwtime T
          on S.tm_id = T.tm_id
    INNER JOIN dwproduct P
          on S.p_code = P.p_code
GROUP BY
      T.tm_month,
      P.p_category
ORDER BY
      T.tm_month,
      P.p_category,
      total_sales desc
;