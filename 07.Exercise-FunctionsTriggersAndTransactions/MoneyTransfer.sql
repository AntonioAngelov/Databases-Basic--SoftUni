CREATE PROC usp_TransferMoney(@senderId int, @receiverId int, @amount money)
AS
BEGIN TRANSACTION
IF (@amount >= 0)
  BEGIN
  EXEC dbo.usp_DepositMoney @receiverId, @amount
  EXEC dbo.usp_WithdrawMoney @senderId, @amount
  END
ELSE
  BEGIN
  EXEC dbo.usp_DepositMoney @senderId, @amount
  EXEC dbo.usp_WithdrawMoney @receiverId, @amount
  END

COMMIT