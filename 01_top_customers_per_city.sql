-- =====================================================
-- Query: Top Customer per City
-- Description: This query identifies the customer who generated the highest total revenue in each city.
-- Tables Used: ORDERS, USERS, ADDRESS, CITIES
-- =====================================================

SELECT T.CityName, T.UserID, T.UserName, T.TotalRevenue FROM
	(SELECT
		C.ID AS CityID,
		C.CITY AS CityName,
		U.ID AS UserID,
		U.NAMESURNAME AS UserName,
		SUM(O.TOTALPRICE) AS TotalRevenue,
		COUNT(DISTINCT O.ID) AS OrderCount
	FROM ORDERS O
	JOIN USERS U ON U.ID=O.USERID
	JOIN ADDRESS A ON A.ID=O.ADDRESSID
	JOIN CITIES C ON C.ID=A.CITYID
	GROUP BY U.ID, U.NAMESURNAME, C.ID, C.CITY) AS T
JOIN 
(SELECT T2.CityID , MAX(T2.TotalRevenue) AS TotalRevenue FROM
	(SELECT
		C.ID AS CityID,
		C.CITY AS CityName,
		U.ID AS UserID,
		U.NAMESURNAME AS UserName,
		SUM(O.TOTALPRICE) AS TotalRevenue,
		COUNT(DISTINCT O.ID) AS OrderCount
	FROM ORDERS O
	JOIN USERS U ON U.ID=O.USERID
	JOIN ADDRESS A ON A.ID=O.ADDRESSID
	JOIN CITIES C ON C.ID=A.CITYID
	GROUP BY U.ID, U.NAMESURNAME, C.ID, C.CITY) AS T2
GROUP BY T2.CityID) M
ON M.TotalRevenue=T.TotalRevenue
AND M.CityID=T.CityID
ORDER BY M.CityID, M.TotalRevenue
