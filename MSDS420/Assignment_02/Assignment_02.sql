-- 1.) Write a query to count the number of invoices.

SELECT COUNT(*) AS [Q1] FROM INVOICE;

-- 2.) Write a query to count the number of customers with a customer balance over $500.

SELECT COUNT(*) AS [Q2] FROM CUSTOMER WHERE [CUS_BALANCE] > 500;

-- 3.) Generate a listing of all purchases made by customers.

SELECT 
   C.[CUS_CODE] AS [CustomerCode],
   C.[CUS_FNAME] || ' ' || C.[CUS_LNAME] AS [Customer Name],
   I.[INV_NUMBER] AS [Invoice],
   I.[INV_DATE] AS [InvoiceDate],
   L.[LINE_NUMBER] AS [LineNumber],
   P.[P_CODE] AS [ProductCode],
   P.[P_DESCRIPT] AS [ProductDescription]
FROM 
    [PRODUCT] P
    INNER JOIN [LINE] L
        ON  P.[P_CODE] = L.[P_CODE]
   INNER JOIN [INVOICE] I
       ON I.[INV_NUMBER] = L.[INV_NUMBER]
   INNER JOIN [CUSTOMER] C
       ON I.[CUS_CODE] = C.[CUS_CODE]
;
       
-- 4.) Generate a listing of customer purchases, 
-- including the subtotals for each of the invoice line numbers.

SELECT
    C.[CUS_FNAME] || ' ' || C.[CUS_LNAME] AS [Customer Name],
    I.[INV_NUMBER] AS [Invoice],
    SUM( L.[LINE_PRICE] * L.[LINE_UNITS] ) AS [Balance]
FROM 
    INVOICE I
    INNER JOIN [LINE] L
        ON I.[INV_NUMBER] = L.[INV_NUMBER]
    INNER JOIN [CUSTOMER] C
        ON I.[CUS_CODE] = C.[CUS_CODE]
GROUP BY
    I.[INV_NUMBER]
;
 
-- 5.) List the balance characteristics of the customers who have made
--  purchases during the current invoice cycle—that is, for the customers who 
-- appear in the INVOICE table.

SELECT 
    C.[CUS_FNAME] || ' ' || C.[CUS_LNAME] AS [Customer Name],
    MAX( C.[CUS_BALANCE] ) AS [Current Balance],
    ROUND( SUM( L.[LINE_UNITS] * L.[LINE_PRICE] ), 2) AS [Outstanding],
    ROUND( MAX( C.[CUS_BALANCE] ) + SUM( L.[LINE_UNITS] * L.[LINE_PRICE] ), 2 ) AS [Projected Balance]
FROM 
    [INVOICE] I
    INNER JOIN CUSTOMER C ON 
        I.[CUS_CODE] = C.[CUS_CODE]
    INNER JOIN [LINE] L
        ON I.[INV_NUMBER] = L.[INV_NUMBER]
GROUP BY
    C.[CUS_CODE]
;

-- 6.) Find a listing of customers who did not make purchases during the invoicing period.

SELECT
     C.[CUS_FNAME] || ' ' || C.[CUS_LNAME] AS [Customer Name]
FROM
    [CUSTOMER] C
    LEFT OUTER JOIN [INVOICE] I
        ON C.[CUS_CODE] = I.[CUS_CODE]
WHERE
    [INV_NUMBER] IS NULL
;

-- 7.) Create a query to produce a summary of the value of products currently in inventory.

SELECT
    [P_DESCRIPT] AS [Product],
    [P_QOH] * [P_PRICE] AS [ValueOnHand],
    ( CASE [P_DISCOUNT] WHEN 0 THEN 1 ELSE 1 - [P_DISCOUNT] END ) * 
        [P_PRICE] * [P_QOH] AS [DiscountedValue]
FROM
    [PRODUCT]
;