-- =====================================================
-- Query: Users Above Average Total Spend
-- Description: This query identifies users whose total spending is above the average total spending
--across all users.
-- Tables Used: ORDERS, USERS
-- =====================================================

SELECT U.ID AS UserID, U.NAMESURNAME AS UserName, SUM(O.TOTALPRICE) AS TotalSpend 
FROM USERS U
JOIN ORDERS O ON U.ID=O.USERID
GROUP BY U.ID, U.NAMESURNAME
HAVING SUM(O.TOTALPRICE) > 
  (SELECT AVG(T.TOTALPRICE) FROM 
    (SELECT U2.ID AS UserID, SUM(O2.TOTALPRICE) AS TotalSpend 
    FROM USERS U2
    JOIN ORDERS O2 ON U2.ID=O2.USERID
    GROUP BY U2.ID) AS T
  )
ORDER BY TotalSpend DESC
