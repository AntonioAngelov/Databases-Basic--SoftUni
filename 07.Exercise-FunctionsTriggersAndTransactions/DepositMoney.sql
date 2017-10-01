CREATE PROC usp_DepositMoney (@accId int, @moneyAmount money)
AS
BEGIN TRANSACTION
UPDATE Accounts
SET Balance += @moneyAmount
WHERE Id = @accId
COMMIT