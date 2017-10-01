--section 1
CREATE DATABASE Bakery

USE Bakery

CREATE TABLE Products
(
Id int IDENTITY(1,1) PRIMARY KEY,
Name nvarchar(25) UNIQUE,
Description nvarchar(250),
Recipe nvarchar(max),
Price money CHECK (Price > 0)
)

CREATE TABLE Countries
(
Id int IDENTITY(1,1) PRIMARY KEY,
Name nvarchar(50) UNIQUE
)


CREATE TABLE Distributors
(
Id int IDENTITY(1,1) PRIMARY KEY,
Name nvarchar(25) UNIQUE,
AddressText nvarchar(30),
Summary nvarchar(200),
CountryId int,
CONSTRAINT FK_Distributors_Countries
FOREIGN KEY (CountryId)
REFERENCES Countries(Id)
)

CREATE TABLE Ingredients
(
Id int IDENTITY(1,1) PRIMARY KEY,
Name nvarchar(30),
Description nvarchar(200),
OriginCountryId int,
DistributorId int,
CONSTRAINT FK_Ingredients_Countries
FOREIGN KEY (OriginCountryId)
REFERENCES Countries(Id),
CONSTRAINT FK_Ingredients_Distributors
FOREIGN KEY (DistributorId)
REFERENCES Distributors(Id)
)

CREATE TABLE ProductsIngredients
(
ProductId int,
IngredientId int,
CONSTRAINT FK_ProductsIngredients_Products
FOREIGN KEY (ProductId)
REFERENCES Products(Id),
CONSTRAINT FK_ProductsIngredients_Ingredients
FOREIGN KEY (IngredientId)
REFERENCES Ingredients(Id),
CONSTRAINT PK_ProductId_IngredientId
PRIMARY KEY (ProductId, IngredientId)
)

CREATE TABLE Customers
(
Id int IDENTITY(1,1) PRIMARY KEY,
FirstName nvarchar(25),
LastName nvarchar(25),
Gender char(1) CHECK (Gender IN ('M', 'F')),
Age int CHECK (Age > 0),
PhoneNumber char(10),
CountryId int,
CONSTRAINT FK_Customers_Countries
FOREIGN KEY (CountryId)
REFERENCES Countries(Id)
)

CREATE TABLE Feedbacks
(
Id int IDENTITY(1,1) PRIMARY KEY,
Description nvarchar(255),
Rate decimal(4, 2) CHECK (Rate BETWEEN -0.00001 AND 9.99999),
ProductId int,
CustomerId int,
CONSTRAINT FK_Feedbacks_Products
FOREIGN KEY (ProductId)
REFERENCES Products(Id),
CONSTRAINT FK_Feedbacks_Customers
FOREIGN KEY (CustomerId)
REFERENCES Customers(Id)
)

--section 2
INSERT INTO Distributors(Name, CountryId, AddressText, Summary)
VALUES ('Deloitte & Touche', 2, '6 Arch St #9757', 'Customizable neutral traveling'),
       ('Congress Title', 13, '58 Hancock St', 'Customer loyalty'),
	   ('Kitchen People', 1, '3 E 31st St #77', 'Triple-buffered stable delivery'),
	   ('General Color Co Inc', 21, '6185 Bohn St #72', 'Focus group'),
	   ('Beck Corporation', 23, '21 E 64th Ave', 'Quality-focused 4th generation hardware')

INSERT INTO Customers(FirstName, LastName, Age, Gender, PhoneNumber, CountryId)
VALUES ('Francoise', 'Rautenstrauch',  15, 'M', '0195698399', 5),
       ('Kendra', 'Loud', 22, 'F', '0063631526', 11),
	   ('Lourdes', 'Bauswell', 50, 'M', '0139037043', 8),
	   ('Hannah', 'Edmison', 18, 'F', '0043343686', 1),
	   ('Tom', 'Loeza', 31, 'M', '0144876096', 23),
	   ('Queenie', 'Kramarczyk', 30, 'F', '0064215793', 29),
	   ('Hiu', 'Portaro', 25, 'M', '0068277755', 16),
	   ('Josefa', 'Opitz', 43, 'F', '0197887645', 17)

 --task 3 UPDATE
 UPDATE Ingredients
 SET DistributorId = 35
 WHERE Name IN ('Bay Leaf', 'Paprika', 'Poppy')

 UPDATE Ingredients
 SET OriginCountryId = 14
 WHERE OriginCountryId = 8

 --task 4 DELETE
 DELETE FROM Feedbacks
 WHERE CustomerId = 14 OR ProductId = 5

 --section 3
 --task 5 Products by Price
 SELECT Name,
        Price,
		Description
 FROM Products
 ORDER BY Price DESC,
          Name ASC

--task 6 Ingredients
SELECT Name,
       Description,
	   OriginCountryId
FROM Ingredients
WHERE OriginCountryId IN (1, 10, 20)
ORDER BY Id ASC

--task 7 Ingredients from Bulgaria and Greece
SELECT  TOP(15) i.Name,
                i.Description,
				c.Name
FROM Ingredients AS i
     INNER JOIN
	 Countries AS c
	 ON i.OriginCountryId = c.Id
WHERE c.Name IN ('Bulgaria', 'Greece')
ORDER BY i.Name ASC,
         c.Name ASC

--task 8 Best Rated Products
SELECT TOP(10) p.Name,
               p.Description,
			   AVG(f.Rate) AS [AverageRate],
			   COUNT(f.Id) AS [FeedbacksAmount]
FROM Products AS p
     INNER JOIN
	 Feedbacks AS f
	 ON p.Id = f.ProductId
GROUP BY p.Name, p.Description
ORDER BY [AverageRate] DESC,
         [FeedbacksAmount]  DESC    

--task 9 Negative Feedback
SELECT f.ProductId,
       f.Rate,
	   f.Description,
	   c.Id,
	   c.Age,
	   c.Gender
FROM Feedbacks AS f
     INNER JOIN
	 Customers AS c
	 ON f.CustomerId = c.Id
WHERE f.Rate < 5.00
ORDER BY f.ProductId DESC,
         f.Rate ASC

--task 10 
SELECT CONCAT(c.FirstName, ' ', c.LastName) AS [CustomerName],
       c.PhoneNumber,
	   c.Gender
FROM Customers AS c
     LEFT OUTER JOIN 
	 Feedbacks AS f
	 ON f.CustomerId = c.Id
WHERE f.Id IS NULL
ORDER BY c.Id ASC

--task 11
SELECT f.ProductId,
       CONCAT(c.FirstName, ' ', c.LastName) AS [CustomerName],
	   f.Description
FROM Feedbacks AS f
     INNER JOIN 
	 Customers AS c
	 ON f.CustomerId = c.Id
WHERE c.Id IN (SELECT c1.Id
               FROM Customers AS c1
			        INNER JOIN 
					Feedbacks AS f1
					ON f1.CustomerId = c1.Id
					GROUP BY c1.Id
					HAVING COUNT(f1.Id) >= 3)
ORDER BY f.ProductId ASC,
         [CustomerName] ASC,
		 f.Id ASC

--task 12 
SELECT FirstName,
       Age,
	   PhoneNumber
FROM Customers
WHERE (Age >= 21 AND CHARINDEX('an', FirstName) > 0)
      OR
	  (RIGHT(PhoneNumber, 2) = '38' AND CountryId <> 31)
ORDER BY FirstName ASC,
         Age DESC

--task 13
SELECT d.Name AS [DistributorName],
       i.Name AS [IngredientName],
	   p.Name AS [ProductName],
	   AVG(f.Rate) AS [AverageRate]
FROM Ingredients AS i
     JOIN 
	 ProductsIngredients AS p_i
	 ON i.Id = p_i.IngredientId
	 JOIN
	 Products AS p
	 ON p.Id = p_i.ProductId
	 JOIN
	 Feedbacks AS f
	 ON f.ProductId = p.Id
	 JOIN
	 Distributors AS d
	 ON d.Id = i.DistributorId
GROUP BY d.Name,
         i.Name,
		 p.Name
HAVING AVG(f.Rate) BETWEEN 5 AND 8
ORDER BY d.Name ASC,
         i.Name ASC,
		 p.Name ASC

--task 14
SELECT c.Name,
       AVG(f.Rate) AS [FeedbackRate]
FROM Countries AS c
     FULL JOIN
	 Customers AS cust
	 ON cust.CountryId = c.Id
	 FULL JOIN
	 Feedbacks AS f
	 ON f.CustomerId = cust.Id
GROUP BY c.Name
HAVING AVG(f.Rate) = (SELECT TOP(1) AVG(f1.Rate) AS [BestRate]
                      FROM Countries AS c1
                      LEFT JOIN
	                  Customers AS cust1
	                  ON cust1.CountryId = c1.Id
	                  LEFT JOIN
	                  Feedbacks AS f1
	                  ON f1.CustomerId = cust1.Id
					  GROUP BY c1.Id, c1.Name
					  ORDER BY [BestRate] DESC)



