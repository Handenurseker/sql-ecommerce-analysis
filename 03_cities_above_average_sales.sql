-- =====================================================
-- Query: Cities Above Average Total Sales
-- Description: This query identifies cities whose total sales are above the average total sales
--across all cities.
-- Tables Used: ORDERS, ADDRESS, CITIES
-- =====================================================

SELECT C.ID AS CityID, C.CITY AS CityName, SUM(O.TOTALPRICE) AS TotalSales 
FROM ORDERS O
JOIN ADDRESS A ON A.ID=O.ADDRESSID
JOIN CITIES C ON C.ID=A.CITYID
GROUP BY C.ID, C.CITY
HAVING SUM(O.TOTALPRICE) > 
  (
  SELECT AVG(T.TotalPrice) FROM 
    (SELECT SUM(O2.TOTALPRICE) AS TotalSales FROM ORDERS O2
    JOIN ADDRESS A2 ON A2.ID=O2.ADDRESSID
    JOIN CITIES C2 ON C2.ID=A2.CITYID
    GROUP BY C2.ID, C2.CITY) AS T)
ORDER BY C.ID
