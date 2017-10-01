--section 4
--task 1
CREATE PROC usp_SubmitReview (@CustomerID int, 
                              @ReviewContent varchar(25),
							  @ReviewGrade int,
							  @AirlineName varchar(30)) 
AS 
IF ((SELECT COUNT(*) 
     FROM Airlines
	 WHERE AirlineName = @AirlineName) = 0)
  BEGIN
  RAISERROR('Airline does not exist.',16 , 1);
  END
ELSE 
  BEGIN 
    INSERT INTO CustomerReviews(ReviewID, CustomerID, ReviewContent, ReviewGrade, AirlineID)
	VALUES (ISNULL((SELECT MAX(ReviewID) FROM CustomerReviews), 0) + 1 , @CustomerID, @ReviewContent, @ReviewGrade, (SELECT AirlineID
	                                                                                                                 FROM Airlines
														                                                             WHERE AirlineName = @AirlineName))
  END