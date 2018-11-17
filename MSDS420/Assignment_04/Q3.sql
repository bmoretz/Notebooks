SELECT
      C.cus_code,
      P.p_descript,
      ROUND( SUM( S.sale_units ) * 
             AVG( S.sale_price ), 2 ) AS total_sales
FROM
    dwdaysalesfact S
    INNER JOIN dwcustomer C
          ON S.cus_code = C.cus_code
    INNER JOIN dwproduct P
          on S.p_code = P.p_code
GROUP BY
      C.cus_code,
      P.p_code
ORDER BY
      C.cus_code,
      total_sales desc,
      P.p_code
;