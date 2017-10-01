CREATE TRIGGER tr_DeletConnectinsToProdct ON Products INSTEAD OF DELETE
AS
DECLARE @deletedId int = (SELECT Id
                      FROM DELETED)

DELETE FROM Feedbacks
WHERE ProductId = @deletedId

DELETE FROM ProductsIngredients
WHERE ProductId = @deletedId