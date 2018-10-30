-- 1.) Write a query to count the number of invoices.

SELECT COUNT(*) AS [Q1] FROM INVOICE;

-- 2.) Write a query to count the number of customers with a customer balance over $500.
SELECT COUNT(*) AS [Q2] FROM CUSTOMER WHERE [CUS_BALANCE] > 500;

-- 3.) Generate a listing of all purchases made by customers.

SELECT 
    I.[CUS_CODE] AS [CustomerId],
    C.[CUS_FNAME] || ' ' || C.[CUS_LNAME] AS [Customer Name],
    COUNT( [ALL | DISTINCT] ) AS [Orders]
FROM 
    [INVOICE] I
    INNER JOIN CUSTOMER C ON 
        I.[CUS_CODE] = C.[CUS_CODE]
GROUP BY
    I.[CUS_CODE];
    
-- 4.) Generate a listing of customer purchases, including the subtotals for each of the invoice line numbers.

SELECT 
    C.[CUS_FNAME] || ' ' || C.[CUS_LNAME] AS [Customer Name],
    COUNT( * ) AS [Orders],
    SUM( C.[CUS_BALANCE] ) AS [Balance]
FROM 
    CUSTOMER C
GROUP BY
    C.[CUS_CODE];
    
-- 5.) List the balance characteristics of the customers who have made purchases during the current invoice cycle—that is, for the customers who appear in the INVOICE table.

SELECT 
    I.[CUS_CODE] AS [CustomerId],
    C.[CUS_FNAME] || ' ' || C.[CUS_LNAME] AS [Customer Name],
    COUNT( [ALL | DISTINCT] ) AS [Orders],
    SUM( C.[CUS_BALANCE] ) AS [Balance]
FROM 
    [INVOICE] I
    INNER JOIN CUSTOMER C ON 
        I.[CUS_CODE] = C.[CUS_CODE]
GROUP BY
    I.[CUS_CODE];
    
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