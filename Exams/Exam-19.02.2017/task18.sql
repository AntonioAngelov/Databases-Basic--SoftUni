CREATE PROC usp_SendFeedback (@CustomerId int, 
                              @ProductId int,
							  @Rate decimal(4, 2),
							  @Description nvarchar(255))
AS
BEGIN TRANSACTION
IF((SELECT COUNT(*)
    FROM Feedbacks
	WHERE CustomerId = @CustomerId) >= 3)
  BEGIN
  ROLLBACK
  RAISERROR('You are limited to only 3 feedbacks per product!', 16, 1)
  RETURN;
  END
ELSE
  BEGIN 
  INSERT INTO Feedbacks(CustomerId, ProductId, Rate, Description)
  VALUES (@CustomerId, @ProductId, @Rate, @Description)
  END
COMMIT
