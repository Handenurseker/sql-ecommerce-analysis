-- =====================================================
-- Query: High-Contribution Customers
-- Description: This query identifies customers whose total spending represents a noticeable share of overall revenue.
-- Tables Used: ORDERS, USERS
-- =====================================================

SELECT T.UserID, T.UserName, T.TotalSales,
(T.TotalSales / 
(SELECT SUM(X.TotalSales) FROM
	(
  	SELECT U.ID AS UserID, U.NAMESURNAME AS UserName, SUM(O.TOTALPRICE) AS TotalSales FROM ORDERS O 
  	JOIN USERS U ON U.ID=O.USERID
  	GROUP BY U.ID, U.NAMESURNAME
	) AS X
) *100) AS SalesPercentage
FROM
(
  SELECT U.ID AS UserID, U.NAMESURNAME AS UserName, SUM(O.TOTALPRICE) AS TotalSales FROM ORDERS O 
  JOIN USERS U ON U.ID=O.USERID
  GROUP BY U.ID, U.NAMESURNAME
) AS T
WHERE 
(T.TotalSales / 
(SELECT SUM(X.TotalSales) FROM
	(
  	SELECT U.ID AS UserID, U.NAMESURNAME AS UserName, SUM(O.TOTALPRICE) AS TotalSales FROM ORDERS O 
  	JOIN USERS U ON U.ID=O.USERID
  	GROUP BY U.ID, U.NAMESURNAME
	) AS X
) *100)>0.1
ORDER BY SalesPercentage DESC
