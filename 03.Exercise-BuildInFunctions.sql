--problem 1
USE SoftUni

SELECT FirstName, LastName FROM Employees
 WHERE LEFT(FirstName, 2) = 'SA' 

 --problem 2
 SELECT FirstName, LastName FROM Employees
  WHERE CHARINDEX('ei', LastName) > 0

--problem 3
SELECT FirstName FROM Employees
 WHERE DepartmentID IN (3, 10)
 AND YEAR(HireDate) BETWEEN 1995 AND 2005

 --problem 4
 SELECT FirstName, LastName FROM Employees
 WHERE CHARINDEX('engineer', JobTitle) = 0

--problem 5
SELECT Name FROM Towns
WHERE LEN(Name) IN (5, 6)
ORDER BY Name ASC

--problem 6
SELECT TownId, Name FROM Towns
WHERE LEFT(Name, 1) IN ('M', 'K', 'B', 'E')
ORDER BY Name ASC

--problem 7
SELECT TownId, Name FROM Towns
WHERE NOT LEFT(Name, 1) IN ('R', 'D', 'B')
ORDER BY Name ASC

--problem 8
CREATE VIEW V_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName FROM Employees
WHERE YEAR(HireDate) > 2000

SELECT * FROM V_EmployeesHiredAfter2000

--problem 9
SELECT FirstName, LastName FROM Employees
WHERE LEN(LastName) = 5

--problem 10
USE Geography

SELECT CountryName, IsoCode FROM Countries
WHERE LEN(CountryName) - LEN(REPLACE(CountryName, 'A', '')) >= 3
ORDER BY IsoCode ASC

--problem 11
SELECT Peaks.PeakName, Rivers.RiverName,LOWER(CONCAT(Peaks.PeakName, STUFF(Rivers.RiverName, 1, 1, ''))) AS [Mix]
FROM Peaks JOIN Rivers ON RIGHT(Peaks.PeakName, 1) = LEFT(Rivers.RiverName, 1)
ORDER BY Mix

--problem 12
USE Diablo

SELECT TOP (50) Name, FORMAT(Start, 'yyyy-MM-dd') FROM Games
WHERE YEAR(Start) IN (2011, 2012)
ORDER BY Start ASC, Name ASC

--problem 13
SELECT Username, SUBSTRING(Email, CHARINDEX('@', Email) + 1, LEN(Email) - CHARINDEX('@', Email)) AS [Email Provider] FROM Users
ORDER BY [Email Provider] ASC, Username ASC

--problem 14
SELECT Username, IpAddress FROM Users
WHERE IpAddress LIKE '___.1_%._%.___'
ORDER BY Username ASC

--problem 15

SELECT Name, Start, DATEPART(QUARTER, Start) FROM Games ORDER BY Name
--SELECT Game, (CASE )
--WHEN Start >=0 AND ) FROM Games

--problem 16
USE Orders

SELECT ProductName, OrderDate, DATEADD(day, 3, OrderDate) AS [Pay Due],
DATEADD(month, 1, OrderDate) AS [Deliver Due] From Orders