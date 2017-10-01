CREATE PROC usp_GetHoldersWithBalanceHigherThan(@balance money)
AS
SELECT ah.FirstName AS [First Name],
       ah.LastName AS [Last Name]
FROM AccountHolders AS ah
     JOIN
	 Accounts AS a
	 ON ah.Id = a.AccountHolderId
GROUP BY  ah.FirstName, ah.LastName
HAVING SUM(a.Balance) > @balance