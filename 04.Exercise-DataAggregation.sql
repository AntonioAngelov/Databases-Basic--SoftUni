--problem 1
USE Gringotts

SELECT COUNT(Id) AS [Count] FROM WizzardDeposits 

--problem 2
SELECT MAX(MagicWandSize) AS [LongestMagicWand] FROM WizzardDeposits

--problem 3
SELECT DepositGRoup, MAX(MagicWandSize) FROM WizzardDeposits
GROUP BY DepositGroup

--problem 4
select DepositGroup from WizzardDeposits
group by DepositGroup
having avg(MagicWandSize) = (
select min(wizarAvgdWandSize.AvggMagicWandSize) from
(
select DepositGroup,avg(MagicWandSize) as AvggMagicWandSize from WizzardDeposits
group by DepositGroup --vlojena sushtata grupa
) AS wizarAvgdWandSize
)

--problem 5
SELECT DepositGroup, SUM(DepositAmount) FROM WizzardDeposits
GROUP BY DepositGroup

--problem 6
SELECT FromOlivander.DepositGroup, SUM(FromOlivander.DepositAmount) AS TotalSum 
   FROM (SELECT DepositGroup, MagicWandCreator, DepositAmount 
             FROM WizzardDeposits
	         WHERE MagicWandCreator = 'Ollivander family') AS FromOlivander
GROUP BY FromOlivander.DepositGroup

--problem 7
SELECT 
   DepositGroup, 
   SUM(DepositAmount) 
   AS [TotalSum] 
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup
HAVING  SUM(DepositAmount) < 150000
ORDER BY TotalSum DESC

--problem 8
SELECT DepositGroup, MagicWandCreator, MIN(DepositCharge) AS [MinDepositCharge]
FROM WizzardDeposits
GROUP BY DepositGroup,
         MagicWandCreator
ORDER BY MagicWandCreator ASC, 
         DepositGroup ASC

--problem 9
SELECT 
      CASE 
	    WHEN Age BETWEEN  0 AND 10 THEN '[0-10]'
	    WHEN Age BETWEEN  11 AND 20 THEN '[11-20]'
	    WHEN Age BETWEEN  21 AND 30 THEN '[21-30]'
	    WHEN Age BETWEEN  31 AND 40 THEN '[31-40]'
	    WHEN Age BETWEEN  41 AND 50 THEN '[41-50]'
	    WHEN Age BETWEEN  51 AND 60 THEN '[51-60]'
	    WHEN Age > 60 THEN '[61+]'
	    END AS [AgeGroup],
	 COUNT(*) AS [WizardCount]
FROM WizzardDeposits
GROUP BY CASE  
          WHEN Age BETWEEN  0 AND 10 THEN '[0-10]'
	      WHEN Age BETWEEN  11 AND 20 THEN '[11-20]'
	      WHEN Age BETWEEN  21 AND 30 THEN '[21-30]'
	      WHEN Age BETWEEN  31 AND 40 THEN '[31-40]'
	      WHEN Age BETWEEN  41 AND 50 THEN '[41-50]'
	      WHEN Age BETWEEN  51 AND 60 THEN '[51-60]'
	      WHEN Age > 60 THEN '[61+]'
	     END 
           
--problem 10 
SELECT DISTINCT LEFT(FirstName, 1) AS [FirstLetter] FROM WizzardDeposits
WHERE DepositGroup = 'Troll Chest'
ORDER BY FirstLetter ASC

--problem 11
SELECT DepositGroup, 
       IsDepositExpired, 
	   AVG(DepositInterest)
         AS [AverageInterest] 
FROM WizzardDeposits
WHERE DepositStartDate > '01/01/1985'
GROUP BY DepositGroup, 
         IsDepositExpired
ORDER BY DepositGroup DESC,
         IsDepositExpired ASC

--problem 12
SELECT 
   SUM(w.DepositAmount - wi.DepositAmount) 
FROM WizzardDeposits AS w
   JOIN WizzardDeposits wi
   on wi.Id = 1 + w.Id

--problem 13
USE SoftUni

SELECT DepartmentId, SUM(Salary) AS [TotalSalary] FROM Employees
GROUP BY DepartmentID
ORDER BY DepartmentID

--problem 14
SELECT DepartmentId, MIN(Salary) AS [MinimumSAlary] FROM Employees
WHERE DepartmentID IN (2, 5, 7) 
      AND HireDate > '01/01/2000' 
GROUP BY DepartmentID
ORDER BY DepartmentID

--problem 15
SELECT * 
INTO RichPeople 
FROM Employees
WHERE Salary > 30000

DELETE 
FROM RichPeople
WHERE ManagerID = 42

UPDATE RichPeople
SET Salary += 5000
WHERE DepartmentID = 1

SELECT DepartmentId , AVG(Salary) AS [AverageSalary]
FROM RichPeople
GROUP BY DepartmentID

--problem 16
SELECT 
  DepartmentID, 
  MAX(Salary) AS [MaxSalary] 
FROM Employees
GROUP BY DepartmentID
HAVING MAX(Salary) < 30000 OR MAX(Salary) > 70000

--problem 17
SELECT COUNT(EmployeeID) AS [Count]
FROM Employees
WHERE ManagerID IS NULL
GROUP BY ManagerID

--problem 18
SELECT DepartmentID, 
(SELECT DISTINCT Salary FROM Employees 
WHERE DepartmentID = e.DepartmentID 
ORDER BY Salary DESC OFFSET 2 ROWS FETCH NEXT 1 ROWS ONLY) AS ThirdHighestSalary
FROM Employees e
WHERE (SELECT DISTINCT Salary FROM Employees 
WHERE DepartmentID = e.DepartmentID 
ORDER BY Salary DESC OFFSET 2 ROWS FETCH NEXT 1 ROWS ONLY) IS NOT NULL
GROUP BY DepartmentID

--problem 19
SELECT TOP(10) FirstName,
       LastName,
	   DepartmentID
FROM Employees AS e1
WHERE Salary > (Select
                   AVG(Salary) 
                 From Employees AS e2
				 WHERE e2.DepartmentID = e1.DepartmentID)
ORDER BY DepartmentID