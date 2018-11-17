SELECT
      R.reg_name,
      C.cus_code,
      ROUND( SUM( S.sale_units ) * 
             AVG( S.sale_price ), 2 ) AS total_sales
FROM
    dwdaysalesfact S
    INNER JOIN dwcustomer C
          ON S.cus_code = C.cus_code
    INNER JOIN dwregion R
          ON C.reg_id = R.reg_id
    INNER JOIN dwproduct P
          on S.p_code = P.p_code
GROUP BY
      C.cus_code,
      R.reg_name
ORDER BY
      R.reg_name,
      total_sales
;