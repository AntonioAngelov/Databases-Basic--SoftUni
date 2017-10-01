CREATE PROC usp_EmployeesBySalaryLevel
(@levelOFSalary varchar(10))
AS
SELECT FirstName,
       LastName
FROM Employees
WHERE dbo.ufn_GetSalaryLevel(Salary) = @levelOFSalary
