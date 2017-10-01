-- problem 2
USE SoftUni

SELECT * FROM Departments

--problem 3
SELECT [Name] FROM Departments

--problem 4
SELECT [FirstName], [LastName], [Salary] FROM Employees

--problem 5
SELECT [FirstName], [MiddleName], [LastName] FROM Employees

--problem 6
SELECT FirstName + '.' + LastName + '@softuni.bg' AS 'Full Email Address' FROM Employees


--problem 7
SELECT DISTINCT Salary FROM Employees

--problem 8
SELECT * FROM Employees
WHERE JobTitle = 'Sales Representative'

--problem 9
SELECT FirstName, LastName, JobTitle FROM Employees
WHERE Salary BETWEEN 20000 AND 30000

--problem 10
SELECT FirstName + ' ' + MiddleName + ' ' + LastName AS [Full Name] FROM Employees
WHERE Salary IN (25000, 14000, 12500, 23600)

--problem 11
SELECT FirstName, LastName From Employees
WHERE ManagerID IS NULL

--problem 12
SELECT FirstName, LastName, Salary From Employees
WHERE Salary > 50000
ORDER BY Salary DESC

--problem 13
SELECT TOP(5) FirstName, LastName From Employees
ORDER BY Salary DESC

--problem 14
SELECT FirstName, LastName From Employees
WHERE NOT DepartmentID = 4

--problem 15
SELECT * FROM Employees
ORDER BY Salary DESC, FirstName ASC, LastName DESC, MiddleName ASC

--problem 16
 CREATE VIEW V_EmployeesSalaries AS 
 SELECT FirstName, LastName, Salary FROM Employees

 SELECT * FROM V_EmployeesSalaries

 --problem 17
 CREATE VIEW V_EmployeeNameJobTitle AS
 SELECT CONCAT (FirstName, ' ', MiddleName, ' ', LastName) AS 'Full Name', JobTitle FROM Employees

 SELECT * FROM V_EmployeeNameJobTitle

 --problem 18
 SELECT DISTINCT JobTitle FROM Employees

 --problem 19
 SELECT TOP (10) * FROM Projects
 ORDER BY StartDate ASC, Name ASC

 --problem 20
 SELECT TOP (7) FirstName, LastName, HireDate FROM Employees
 ORDER BY HireDate DESC

 --problem 21
 UPDATE Employees
 SET Salary += (Salary * 12) / 100
WHERE DepartmentID IN (1, 2, 4, 11)

SELECT Salary FROM Employees

--problem 22
USE Geography

SELECT PeakName FROM Peaks
ORDER BY PeakName ASC

--problem 23
SELECT TOP (30) CountryName, Population FROM Countries
WHERE ContinentCode = 'EU' 
ORDER BY Population DESC, CountryName ASC


--problem 24
SELECT CountryName, CountryCode, (CASE(CurrencyCode)
WHEN 'EUR' THEN 'Euro'
ELSE 'Not Euro'
END) AS 'Currency' FROM Countries
ORDER BY CountryName ASC


--problem 25
USE Diablo

SELECT Name FROM Characters
ORDER BY Name ASC

