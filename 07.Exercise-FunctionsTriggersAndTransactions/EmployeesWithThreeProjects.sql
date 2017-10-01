CREATE PROC usp_AssignProject(@emloyeeId int, @projectID int)
AS
BEGIN TRANSACTION

INSERT INTO EmployeesProjects(EmployeeID, ProjectID)
VALUES (@emloyeeId, @projectID)

IF ((SELECT COUNT(*)
     FROM EmployeesProjects
	 WHERE EmployeeID = @emloyeeId) >3)
	 BEGIN
	   ROLLBACK
	   RAISERROR('The employee has too many projects!', 16, 1)
	 END

COMMIT