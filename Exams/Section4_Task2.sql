CREATE PROC usp_PurchaseTicket(@CustomerID int,
                               @FlightID int,
							   @TicketPrice decimal(8,2),
							   @Class varchar(6),
							   @Seat varchar(6))
AS
BEGIN TRANSACTION

DECLARE @Balance decimal(10, 2) = (SELECT Balance
     FROM CustomerBankAccounts
	 WHERE CustomerID = @CustomerID)
IF (@Balance < @TicketPrice OR @Balance IS NULL)
  BEGIN
  ROLLBACK;
  RAISERROR('Insufficient bank account balance for ticket purchase.', 16, 1)
  END
ELSE
  BEGIN
      UPDATE CustomerBankAccounts
      SET Balance -= @TicketPrice
      WHERE CustomerID = @CustomerID

      INSERT INTO Tickets(TicketID, Price, Class, Seat, CustomerID, FlightID)
      VALUES (ISNULL((SELECT MAX(TicketID)
                      FROM Tickets), 0) + 1, @TicketPrice, @Class, @Seat, @CustomerID, @FlightID)
COMMIT;
END