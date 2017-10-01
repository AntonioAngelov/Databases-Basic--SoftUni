--task 16
CREATE VIEW v_UserWithCountries 
AS
SELECT CONCAT(cust.FirstName, ' ', cust.LastName) AS [CustomerName],
       cust.Age,
	   cust.Gender,
	   c.Name
FROM Customers AS cust
     INNER JOIN
	 Countries AS c
	 ON cust.CountryId = c.Id