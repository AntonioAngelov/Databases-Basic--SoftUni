CREATE FUNCTION udf_GetRating(@Name nvarchar(25))
RETURNS varchar(10)
AS
BEGIN 
DECLARE @rating decimal(4, 2) = (SELECT AVG(f.Rate)
                                 FROM Products AS p
								 LEFT OUTER JOIN
								 Feedbacks AS f
								 ON f.ProductId = p.Id
								 WHERE p.Name = @Name)
IF(NOT EXISTS(SELECT *
              FROM Products AS p
			       INNER JOIN
				   Feedbacks AS f
				   ON f.ProductId = p.Id
				   WHERE p.Name = @Name))
	RETURN 'No rating';
ELSE
 BEGIN
  IF(@rating < 5)
   RETURN 'Bad';
  ELSE IF(@rating BETWEEN 5 AND 8)
   RETURN 'Average';
 END

 RETURN 'Good';
END