USE SoftUni

--problem 1
SELECT TOP(5) EmployeeId, JobTitle, e.AddressId, AddressText 
FROM Employees AS e 
     JOIN
	 Addresses AS a
     ON e.AddressID = a.AddressID
ORDER BY e.AddressID ASC

--problem 2
SELECT TOP(50) FirstName, 
               LastName, 
			   t.Name AS [Town], 
			   a.AddressText
FROM Employees AS e
     JOIN 
	 Addresses AS a
	 ON e.AddressID = a.AddressID
	 JOIN 
	 Towns AS t
	 ON t.TownID = a.TownID
ORDER BY FirstName ASC, LastName ASC

--problem 3
SELECT EmployeeId,
       FirstName,
	   LastName,
	   Name AS [DepartmentName]
FROM Employees AS e 
     JOIN
	 Departments AS d
	 ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'
ORDER BY EmployeeID ASC

--problem 4
SELECT TOP(5)
       EmployeeID,
       FirstName,
	   Salary,
	   Name AS [DepartmentName]
FROM Employees AS e 
     JOIN
	 Departments AS d
	 ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 15000
ORDER BY d.DepartmentID ASC


--problem 5
SELECT TOP(3)
       e.EmployeeID,
	   FirstName
FROM Employees AS e
     LEFT OUTER JOIN 
	 EmployeesProjects AS p
	 ON e.EmployeeID = p.EmployeeID
WHERE p.ProjectID IS NULL
ORDER BY e.EmployeeID ASC

--problem 6
SELECT FirstName,
       LastName,
	   HireDate,
	   Name AS [DeptName]
FROM Employees AS e
     JOIN
	 Departments AS d
	 ON e.DepartmentID = d.DepartmentID
WHERE e.HireDate > '1/1/1999'  AND Name IN ('Sales', 'Finance')

--problem 7
SELECT TOP(5)
       e.EmployeeID,
	   FirstName,
	   p.Name AS [ProjetName]
FROM Employees AS e
     JOIN 
	 EmployeesProjects AS ep
	 ON e.EmployeeID = ep.EmployeeID
	 JOIN
	 Projects as p
	 ON p.ProjectID = ep.ProjectID
WHERE p.StartDate > '08.13.2002' AND p.EndDate IS NULL
ORDER BY e.EmployeeID ASC

--problem 8
SELECT e.EmployeeID,
	   FirstName,
	   (CASE 
	   WHEN  p.StartDate > '01.01.2005' THEN NULL
	   ELSE p.Name
	   END) AS [ProjetName]
FROM Employees AS e
     JOIN 
	 EmployeesProjects AS ep
	 ON e.EmployeeID = ep.EmployeeID
	 JOIN
	 Projects as p
	 ON p.ProjectID = ep.ProjectID
WHERE e.EmployeeID = 24

--problem 9
SELECT e.EmployeeID,
       e.FirstName,
	   m.EmployeeID,
	   m.FirstName AS [ManagerName]
FROM Employees AS e 
     JOIN
	 Employees AS m
	 ON e.ManagerID = m.EmployeeID
WHERE m.EmployeeID IN (3, 7)
ORDER BY e.EmployeeID ASC


--problem 10
SELECT TOP(50)
       e.EmployeeID,
       e.FirstName + ' ' + e.LastName AS [EmployeeName],
	   m.FirstName + ' ' + m.LastName AS [ManagerName],
	   d.Name AS [DepartmentName]
FROM Employees AS e 
     JOIN
	 Employees AS m
	 ON e.ManagerID = m.EmployeeID
	 JOIN 
	 Departments AS d
	 ON d.DepartmentID = e.DepartmentID
ORDER BY e.EmployeeID ASC

--problem 11
SELECT TOP(1)
       AVG(Salary) AS [MinAverageSalary]
FROM Employees
GROUP BY DepartmentID
ORDER BY AVG(Salary) ASC

--problem 12
USE Geography

SELECT c.CountryCode,
       m.MountainRange,
	   PeakName,
	   Elevation
FROM Peaks AS p
     JOIN 
	 Mountains AS m
	 ON m.Id = p.MountainId
	 JOIN MountainsCountries AS mc
	 on m.Id = mc.MountainId
	 JOIN 
	 Countries AS c
	 ON c.CountryCode = mc.CountryCode
WHERE c.CountryCode = 'BG' 
      AND p.Elevation > 2835
ORDER BY p.Elevation DESC

--problem 13
SELECT c.CountryCode,
       COUNT(MountainRange)
FROM Mountains AS m
     JOIN 
	 MountainsCountries AS mc
	 ON m.Id = mc.MountainId
	 JOIN 
	 Countries AS c
	 ON c.CountryCode = mc.CountryCode
WHERE c.CountryCode IN ('US', 'BG', 'RU')
GROUP BY c.CountryCode

--problem 14
SELECT TOP(5)
       CountryName,
	   RiverName
FROM Rivers AS r
     JOIN
	 CountriesRivers AS cr
	 ON r.Id = cr.RiverId
	 RIGHT OUTER JOIN
	 Countries AS c
	 ON cr.CountryCode = c.CountryCode
WHERE c.ContinentCode = 'AF'
ORDER BY CountryName ASC


--problem 15
SELECT ContinentCode,
       CurrencyCode,
	   COUNT(c.CountryCode) AS [CurrencyUsage]
FROM Countries AS c
GROUP BY ContinentCode, CurrencyCode
HAVING COUNT(c.CountryCode) = (SELECT TOP(1) COUNT(CountryCode)
                               FROM Countries AS c1
							   WHERE c.ContinentCode = c1.ContinentCode
							   GROUP BY ContinentCode, CurrencyCode
							   ORDER BY COUNT(CountryCode) DESC)
	   AND COUNT(c.CountryCode) > 1
ORDER BY ContinentCode

--problem 16
SELECT COUNT(c.CountryCode) AS [CountryCode]
FROM Countries AS c
     FULL JOIN
	 MountainsCountries AS mc
	 ON  mc.CountryCode = c.CountryCode
	 FULL JOIN
	 Mountains AS m
	 ON m.Id = mc.MountainId
WHERE m.MountainRange IS NULL

--problem 17
SELECT TOP(5)
       c.CountryName,
       MAX(p.Elevation) AS [HighestPeakElevation],
	   MAX(r.Length) AS [LongestRiverLength]
FROM Countries AS c
     FULL JOIN
	 MountainsCountries as mc
	 ON mc.CountryCode = c.CountryCode
	 FULL JOIN 
	 Peaks AS p
	 ON p.MountainId = mc.MountainId
	 FULL JOIN
	 CountriesRivers AS cr
	 ON cr.CountryCode = c.CountryCode
	 FULL JOIN 
	 Rivers AS r
	 ON r.Id = cr.RiverId
GROUP BY c.CountryName
ORDER BY [HighestPeakElevation] DESC,
         [LongestRiverLength] DESC,
		 c.CountryName ASC

--problem 18

