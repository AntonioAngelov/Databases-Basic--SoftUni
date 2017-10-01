CREATE PROC usp_GetEmployeesSalaryAboveNumber
(@salary money)
AS
SELECT FirstName, LastName 
FROM Employees
WHERE Salary >= @salary