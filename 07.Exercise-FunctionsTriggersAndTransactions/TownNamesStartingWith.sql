CREATE PROC usp_GetTownsStartingWith
(@substr varchar(100))
AS
SELECT Name AS [Town]
FROM Towns
WHERE LEFT(Name, LEN(@substr)) = @substr