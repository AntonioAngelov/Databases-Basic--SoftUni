CREATE PROC usp_GetEmployeesFromTown
(@townName varchar(100))
AS
SELECT e.FirstName,
       e.LastName
FROM Employees AS e
     INNER JOIN
	 Addresses as a
	 ON e.AddressID = a.AddressID
	 INNER JOIN
	 Towns AS t
	 ON t.TownID = a.TownID
WHERE t.Name = @townName