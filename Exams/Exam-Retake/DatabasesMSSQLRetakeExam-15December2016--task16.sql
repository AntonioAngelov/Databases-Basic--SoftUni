--task 16
CREATE PROC udp_ChangePassword (@Email varchar(30), 
                                @NewPassword varchar(20))
AS
IF NOT EXISTS(SELECT *
              FROM Credentials
			  WHERE Email = @Email)
     RAISERROR('The email does''t exist!',16, 1)
ELSE 
BEGIN
UPDATE Credentials
SET Password = @NewPassword
WHERE Email = @Email
END