CREATE DATABASE AMS

USE AMS

--section 0
CREATE TABLE Towns (
	TownID INT,
	TownName VARCHAR(30) NOT NULL,
	CONSTRAINT PK_Towns PRIMARY KEY(TownID)
)

CREATE TABLE Airports (
	AirportID INT,
	AirportName VARCHAR(50) NOT NULL,
	TownID INT NOT NULL,
	CONSTRAINT PK_Airports PRIMARY KEY(AirportID),
	CONSTRAINT FK_Airports_Towns FOREIGN KEY(TownID) REFERENCES Towns(TownID)
)

CREATE TABLE Airlines (
	AirlineID INT,
	AirlineName VARCHAR(30) NOT NULL,
	Nationality VARCHAR(30) NOT NULL,
	Rating INT DEFAULT(0),
	CONSTRAINT PK_Airlines PRIMARY KEY(AirlineID)
)

CREATE TABLE Customers (
	CustomerID INT,
	FirstName VARCHAR(20) NOT NULL,
	LastName VARCHAR(20) NOT NULL,
	DateOfBirth DATE NOT NULL,
	Gender VARCHAR(1) NOT NULL CHECK (Gender='M' OR Gender='F'),
	HomeTownID INT NOT NULL,
	CONSTRAINT PK_Customers PRIMARY KEY(CustomerID),
	CONSTRAINT FK_Customers_Towns FOREIGN KEY(HomeTownID) REFERENCES Towns(TownID)
)

CREATE TABLE Flights
(
FlightID int PRIMARY KEY,
DepartureTime datetime NOT NULL,
ArrivalTime datetime NOT NULL,
Status varchar(9) NOT NULL,
OriginAirportID int,
DestinationAirportID int,
AirlineID int,
CONSTRAINT chk_Status
CHECK (Status IN ('Departing', 'Delayed' , 'Arrived', 'Cancelled')),
CONSTRAINT FK_Flinghts_Aitports_Origin
FOREIGN KEY (OriginAirportID)
REFERENCES Airports(AirportID),
CONSTRAINT FK_Flinghts_Aitports_Destination
FOREIGN KEY (DestinationAirportID)
REFERENCES Airports(AirportID),
CONSTRAINT FK_Flinghts_Airlines
FOREIGN KEY (AirlineID)
REFERENCES Airlines(AirlineID)
)

CREATE TABLE Tickets
(
TicketID int PRIMARY KEY,
Price decimal(8,2) NOT NULL,
Class varchar(6),
Seat varchar(6),
CustomerID int ,
FlightID int ,
CONSTRAINT chk_Class
CHECK (Class IN ('First', 'Second' , 'Third')),
CONSTRAINT FK_Tickets_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID),
CONSTRAINT FK_Tickets_Flights
FOREIGN KEY (FlightID)
REFERENCES Flights(FlightID)
)

--section 2
INSERT INTO Towns(TownID, TownName)
VALUES
(1, 'Sofia'),
(2, 'Moscow'),
(3, 'Los Angeles'),
(4, 'Athene'),
(5, 'New York')

INSERT INTO Airports(AirportID, AirportName, TownID)
VALUES
(1, 'Sofia International Airport', 1),
(2, 'New York Airport', 5),
(3, 'Royals Airport', 1),
(4, 'Moscow Central Airport', 2)

INSERT INTO Airlines(AirlineID, AirlineName, Nationality, Rating)
VALUES
(1, 'Royal Airline', 'Bulgarian', 200),
(2, 'Russia Airlines', 'Russian', 150),
(3, 'USA Airlines', 'American', 100),
(4, 'Dubai Airlines', 'Arabian', 149),
(5, 'South African Airlines', 'African', 50),
(6, 'Sofia Air', 'Bulgarian', 199),
(7, 'Bad Airlines', 'Bad', 10)

INSERT INTO Customers(CustomerID, FirstName, LastName, DateOfBirth, Gender, HomeTownID)
VALUES
(1, 'Cassidy', 'Isacc', '19971020', 'F', 1),
(2, 'Jonathan', 'Half', '19830322', 'M', 2),
(3, 'Zack', 'Cody', '19890808', 'M', 4),
(4, 'Joseph', 'Priboi', '19500101', 'M', 5),
(5, 'Ivy', 'Indigo', '19931231', 'F', 1)


--task 1
INSERT INTO Flights
VALUES (1, '2016-10-13 06:00 AM', '2016-10-13 10:00 AM', 'Delayed', 1, 4, 1),
       (2, '2016-10-12 12:00 PM', '2016-10-12 12:01 PM', 'Departing', 1, 3, 2),
	   (3, '2016-10-14 03:00 PM', '2016-10-20 04:00 AM', 'Delayed', 4, 2, 4),
	   (4, '2016-10-12 01:24 PM', '2016-10-12 4:31 PM', 'Departing', 3, 1, 3),
	   (5, '2016-10-12 08:11 AM', '2016-10-12 11:22 PM', 'Departing', 4, 1, 1),
	   (6, '1995-06-21 12:30 PM', '1995-06-22 08:30 PM', 'Arrived', 2, 3, 5),
	   (7, '2016-10-12 11:34 PM', '2016-10-13 03:00 AM', 'Departing', 2, 4, 2),
	   (8, '2016-11-11 01:00 PM', '2016-11-12 10:00 PM', 'Delayed', 4, 3, 1),
	   (9, '2015-10-01 12:00 PM', '2015-12-01 01:00 AM', 'Arrived', 1, 2, 1),
	   (10, '2016-10-12 07:30 PM', '2016-10-13 12:30 PM', 'Departing', 2, 1, 7)

INSERT INTO Tickets
VALUES (1, 3000.00, 'First',  '233-A', 3, 8),
       (2, 1799.90, 'Second',  '123-D', 1, 1),
	   (3, 1200.50, 'Second',  '12-Z', 2, 5),
	   (4, 410.68, 'Third',  '45-Q', 2, 8),
	   (5, 560.00, 'Third',  '201-R', 4, 6),
	   (6, 2100.00, 'Second',  '13-T', 1, 9),
	   (7, 5500.00, 'First',  '98-O', 2, 7)
        
--task 2
UPDATE Flights
SET AirlineID = 1
WHERE Status = 'Arrived'

--task 3
UPDATE Tickets
SET Price += Price * 0.5
WHERE TicketID IN (SELECT TicketID
                   FROM Tickets AS t
				   INNER JOIN 
				   Flights as f
				   ON t.FlightID = f.FlightID
				   INNER JOIN 
				   Airlines as a
				   ON a.AirlineID = f.AirlineID
				   WHERE a.Rating = (SELECT TOP(1)
				                       Rating
									 FROM Airlines
									 ORDER BY Rating DESC)
				   )

--task 4
CREATE TABLE CustomerReviews
(
ReviewID int PRIMARY KEY,
ReviewContent varchar(255) NOT NULL,
ReviewGrade int CHECK (ReviewGrade BETWEEN 0 AND 10),
AirlineID int,
CustomerID int,
CONSTRAINT FK_CustomerReviews_Airlines
FOREIGN KEY (AirlineID)
REFERENCES Airlines(AirlineID),
CONSTRAINT FK_CustomerReviews_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID)
)


CREATE TABLE CustomerBankAccounts
(
AccountID int PRIMARY KEY,
AccountNumber varchar(10) NOT NULL UNIQUE,
Balance decimal(10,2) NOT NULL,
CustomerID int,
CONSTRAINT FK_CustomerBankAccounts_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID)
)


--task 5
INSERT INTO CustomerReviews
VALUES (1, 'Me is very happy. Me likey this airline. Me good.', 10, 1, 1),
       (2, 'Ja, Ja, Ja... Ja, Gut, Gut, Ja Gut! Sehr Gut!', 10, 1, 4),
       (3, 'Meh...', 5, 4, 3),
       (4, 'Well Ive seen better, but Ive certainly seen a lot worse...', 7, 3, 5)

INSERT INTO CustomerBankAccounts
VALUES (1, '123456790', 2569.23, 1),
       (2, '18ABC23672', 14004568.23, 2),
	   (3, 'F0RG0100N3', 19345.20, 5)

--section 3
--task 1
SELECT TicketID, Price, Class, Seat
FROM Tickets
ORDER BY TicketID ASC

--task 2
SELECT CustomerID, FirstName + ' ' + LastName AS [FullName], Gender
FROM Customers
ORDER BY [FullName] ASC, 
         CustomerID ASC 

--task3
SELECT FlightID, DepartureTime, ArrivalTime
FROM Flights
WHERE Status = 'Delayed'
ORDER BY FlightID ASC

--task 4
SELECT DISTINCT TOP(5) a.AirlineID, a.AirlineName, a.Nationality, a.Rating
FROM Airlines AS a
     JOIN Flights as f
	 ON f.AirlineID = a.AirlineID
ORDER BY a.Rating DESC, a.AirlineID ASC

--task 5
SELECT t.TicketID, 
       a.AirportName AS Destination,
	   c.FirstName + ' ' + c.LastName AS [CustomerName]
FROM Tickets AS t
     INNER JOIN
	 Flights AS f
	 ON F.FlightID = t.FlightID
	 INNER JOIN Airports AS a
	 ON a.AirportID = f.DestinationAirportID
	 INNER JOIN Customers AS c
	 ON c.CustomerID = t.CustomerID
WHERE t.Price < 5000 
      AND
	  t.Class = 'First'
ORDER BY TicketID ASC


--task 6
SELECT DISTINCT c.CustomerID,
       c.FirstName + ' ' + c.LastName AS [FullName],
	   twn.TownName AS [HomeName]
FROM Customers AS c
     INNER JOIN
	 Tickets AS t
	 ON t.CustomerID = c.CustomerID
	 INNER JOIN
	 Flights AS f
	 ON f.FlightID = t.FlightID
	 INNER JOIN 
	 Airports AS a
	 ON a.AirportID = f.OriginAirportID
	 INNER JOIN
	 Towns as twn
	 ON twn.TownID = a.TownID
WHERE c.HomeTownID = twn.TownID
ORDER BY c.CustomerID ASC
	  
--task 7
SELECT DISTINCT 
       c.CustomerID,
       c.FirstName + ' ' + c.LastName AS [FullName],
	   2016 - YEAR(c.DateOfBirth) AS [Age]
FROM Customers AS c
     INNER JOIN 
	 Tickets AS t
	 ON c.CustomerID = t.CustomerID
	 INNER JOIN
	 Flights AS f
	 ON f.FlightID = t.FlightID
WHERE f.Status = 'Departing'
ORDER BY [Age] ASC,
         c.CustomerID ASC

--task 8
SELECT TOP(3) c.CustomerID,
       c.FirstName + ' ' + c.LastName AS [FullName],
	   t.Price AS [TicketPrice],
	   a.AirportName AS [Destination]
FROM Customers AS c
     INNER JOIN Tickets AS t
	 ON t.CustomerID = c.CustomerID
	 INNER JOIN 
	 Flights AS f
	 ON f.FlightID = t.FlightID
	 INNER JOIN 
	 Airports AS a
	 ON a.AirportID = f.DestinationAirportID
WHERE f.Status = 'Delayed'
ORDER BY t.Price DESC,
         c.CustomerID ASC

--task 9
SELECT f.FlightID,
       f.DepartureTime,
	   f.ArrivalTime,
	   a1.AirportName AS [Origin],
	   a2.AirportName AS [Destination]
FROM (SELECT TOP(5) * 
      FROM Flights
	  WHERE Status = 'Departing'
	  ORDER BY DepartureTime DESC) AS f
     INNER JOIN 
	 Airports AS a1
	 ON a1.AirportID = f.OriginAirportID
	 INNER JOIN
	 Airports AS a2
	 ON a2.AirportID = f.DestinationAirportID
ORDER BY f.DepartureTime ASC,
         f.FlightID ASC

--task 10
SELECT DISTINCT c.CustomerID,
       CONCAT(c.FirstName, ' ', c.LastName) AS [FullName],
	   DATEDIFF(year, c.DateOfBirth, '20160101') AS [Age]
FROM (SELECT *
      FROM Customers
	  WHERE  DATEDIFF(year, DateOfBirth, '20160101') < 21) AS c
     INNER JOIN 
	 Tickets AS t
	 ON t.CustomerID = c.CustomerID
	 INNER JOIN
	 Flights AS f
	 ON f.FlightID = t.FlightID
	 AND
	 f.Status = 'Arrived'
ORDER BY [Age] DESC,
         c.CustomerID ASC

--task 11
SELECT a.AirportID,
       a.AirportName,
	  COUNT(t.TicketID) AS [Passengers]
FROM Airports AS a
     INNER JOIN Flights AS f
	 ON f.OriginAirportID = a.AirportID
	 AND 
	 f.Status = 'Departing'
	 INNER JOIN 
	 Tickets AS t 
	 ON t.FlightID = f.FlightID
GROUP BY a.AirportID,
         a.AirportName
ORDER BY a.AirportID ASC

