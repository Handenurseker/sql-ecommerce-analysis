-- =====================================================
-- Query: Top 10 Customers by Revenue
-- Description: This query identifies the top 10 customers who generated the highest total revenue and shows their
-- total order count.
-- Tables Used: ORDERS, USERS
-- =====================================================

SELECT TOP 10
	U.ID AS UserID,
	U.NAMESURNAME AS UserName,
	SUM(O.TOTALPRICE) AS TotalRevenue,
	COUNT(DISTINCT O.ID) AS OrderCount
FROM ORDERS O
JOIN USERS U ON U.ID=O.USERID
GROUP BY U.ID, U.NAMESURNAME
ORDER BY TotalRevenue DESC
