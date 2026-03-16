-- =====================================================
-- Query: Customer Lifecycle Analysis
-- Description: This query analyzes customer purchasing behavior by identifying each customer's first order date,
-- last order date, and total number of orders
-- Tables Used: ORDERS, USERS
-- =====================================================

SELECT 
	U.ID AS UserID,
	U.NAMESURNAME AS UserName,
	MIN(O.DATE_) AS FirstOrderDate,
	MAX(O.DATE_) AS LastOrderDate,
	COUNT(DISTINCT O.ID) AS OrderCount
FROM ORDERS O
JOIN USERS U ON U.ID=O.USERID
GROUP BY U.ID, U.NAMESURNAME
ORDER BY U.ID
