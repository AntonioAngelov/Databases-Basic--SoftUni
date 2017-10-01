USE Minions

CREATE TABLE Minions
(
Id int NOT NULL PRIMARY KEY,
Name varchar(50) NOT NULL,
Age int 
)

CREATE TABLE Towns
(
Id int NOT NULL PRIMARY KEY,
Name varchar(50) NOT NULL
)

ALTER TABLE Minions
ADD TownId int

ALTER TABLE Minions
ADD CONSTRAINT fk_TownId
FOREIGN KEY (TownId)
REFERENCES Towns(Id)


-- problem 4
INSERT INTO Towns (Id, Name) 
VALUES (1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna')

INSERT INTO Minions (Id, Name, Age, TownId) 
VALUES (1, 'Kevin', 22, 1),
(2, 'Bob', 15, 3),
(3, 'Steward', NULL, 2)

SELECT * FROM Minions

TRUNCATE TABLE Minions

DROP TABLE Towns

--problem 7
CREATE TABLE People
(
Id bigint PRIMARY KEY IDENTITY NOT NULL,
Name nvarchar(200) NOT NULL,
Picture image,
Height float(2),
Weight float(2),
Gender char,
Birthdate date NOT NULL,
Biography nvarchar(max),
CHECK (Gender = 'm' OR Gender = 'f')
) 

INSERT INTO People (Name, Height, Weight, Gender, Birthdate)
VALUES ('Sasho', 2, 70, 'm', '20000601'),
('Pesho', 1.50, 50, 'm', '20000601'),
('Habib', 1.75, 60, 'm', '20000601'),
('Rusica', 1.50, 55, 'm', '20000601'),
('GInka', 2, 80, 'm', '20000601')

SELECT * FROM People

--problem 8
CREATE TABLE Users
(
Id bigint PRIMARY KEY IDENTITY NOT NULL,
Username varchar(30) NOT NULL UNIQUE,
Password varchar(26) NOT NULL,
ProfilePicture image, 
LastLoginTime datetime,
IsDeleted bit
) 

INSERT INTO Users (Username, Password)
VALUES ('gotiniq96', 'sumaz'),
('mazda23', '12311'),
('sexmanqk56', '45611'),
('mashina97', '34511'),
('zeroto', '78900')

SELECT * FROM Users

ALTER TABLE Users
DROP CONSTRAINT [PK__Users__3214EC07C063D1A0]

ALTER TABLE Users 
ADD CONSTRAINT PK_IdAndUsername
PRIMARY KEY (Id, Username)

ALTER TABLE Users 
ADD CONSTRAINT CheckPassword
CHECK (LEN(Password) > 4)

ALTER TABLE Users
ADD DEFAULT CURRENT_TIMESTAMP
FOR LastLoginTime

--problem 13
CREATE DATABASE Movies
USE Movies

CREATE TABLE Directors 
(
Id int PRIMARY KEY NOT NULL IDENTITY, 
DirectorName nvarchar(50) NOT NULL UNIQUE,
Notes nvarchar(200)
)

CREATE TABLE Genres 
(
Id int PRIMARY KEY NOT NULL IDENTITY, 
GenreName nvarchar(50) NOT NULL UNIQUE,
Notes nvarchar(200)
)

CREATE TABLE Categories 
(
Id int PRIMARY KEY NOT NULL IDENTITY, 
CategoryName nvarchar(50) NOT NULL UNIQUE,
Notes nvarchar(200)
)

CREATE TABLE Movies 
(
Id int PRIMARY KEY NOT NULL IDENTITY, 
Title nvarchar(50) NOT NULL UNIQUE,
DirectorId int NOT NULL,
CopyrightYear date NOT NULL,
Length int NOT NULL,
GenreId int NOT NULL,
CategoryId int NOT NULL,
Rating int NOT NULL,
Notes nvarchar(200)
)

INSERT INTO Categories (CategoryName)
VALUES ('Action'),
('Animation'),
('Comedy'),
('Family'),
('Horror')

INSERT INTO Directors (DirectorName)
VALUES ('Alex Fletcher'),
('Steven Spielberg'),
('Martin Scorsese'),
('Quentin Tarantino'),
('Alfred Hitchcock')

INSERT INTO Genres (GenreName)
VALUES ('Comedy'),
('Drama'),
('Horror'),
('Non-fiction'),
('Tragedy')

INSERT INTO Movies (Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Rating)
VALUES ('firstMovie', 1, '20000101', 2, 1, 1, 5),
('secondMovie', 2, '20000101', 2, 2, 2, 4),
('thirdMovie', 3, '20000101', 2, 3, 3, 3),
('fourthMovie', 4, '20000101', 2, 4, 4, 2),
('fifthMovie', 5, '20000101', 2, 5, 5, 1)

--problem 14
CREATE DATABASE CarRental
USE CarRental

CREATE TABLE Categories
(
Id int IDENTITY PRIMARY KEY,
CategoryName varchar(30) NOT NULL UNIQUE, 
DailyRate int,
WeeklyRate int,
MonthlyRate int,
WeekendRate int
)

CREATE TABLE Cars
(
Id int PRIMARY KEY IDENTITY,
PlateNumber varchar(10) NOT NULL UNIQUE,
Manufacturer varchar(20) NOT NULL,
Model varchar(20) NOT NULL,
CarYear int NOT NULL,
CategoryId int NOT NULL,
Doors int NOT NULL,
Picture image,
Condition varchar(30),
Available varchar(3) NOT NULL,
CHECK (Available = 'yes' OR Available = 'no')
)

CREATE TABLE Employees 
(
Id int PRIMARY KEY IDENTITY,
FirstName varchar(30) NOT NULL,
LastNAme varchar(30) NOT NULL,
Title varchar(20),
Notes varchar(200)
)

CREATE TABLE Customers 
(
Id int PRIMARY KEY IDENTITY,
DriverLicenceNumber int UNIQUE NOT NULL,
FullName varchar(50) NOT NULL,
Address varchar(200) NOT NULL,
City varchar(30),
ZIPCode int,
Notes varchar(300)
)

CREATE TABLE RentalOrders
(
Id int PRIMARY KEY IDENTITY,
EmployeeID int Not Null,
CustomerID int NOT NULL,
CarId int NOT NULL,
TankLevel int NOT NULL,
KilometrageStart int,
KilometrageEnt int,
TotalKilometrage int,
StartDate date,
EndDate date,
TotalDays int, 
RateApplied int,
TaxRate int,
OrderStartus varchar(30),
Notes varchar(300)
)

INSERT INTO Categories (CategoryName)
VALUES ('neshto'),
('haide'),
('wtf')

INSERT INTO Cars (PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Available)
VALUES ('AA1234BB','FORD','FOCUS', 2005, 1, 5, 'yes'),
('AB1234BB','FORD','FIESTA', 2005, 2, 5, 'yes'),
('AV1234BB','FORD','MODEO', 2005, 3, 5, 'yes')

INSERT INTO Customers (DriverLicenceNumber, FullName, Address)
VALUES (1234, 'A.A.A', 'na chereshata'),
(12345, 'A.A.A', 'na chereshata'),
(12346, 'A.A.A', 'na chereshata')

INSERT INTO Employees (FirstName, LastName)
VALUES ('Ivan', 'Peshev'),
('Pesho', 'Peshev'),
('Pesho', 'Ivanov')

INSERT INTO RentalOrders (EmployeeId, CustomerId, CarId, TankLevel)
VALUES (1, 1, 1, 40),
(2, 2, 2, 40),
(3, 3, 3, 40)

-- problem 15
CREATE DATABASE Hotel
USE Hotel

CREATE TABLE Employees 
(
Id int PRIMARY KEY IDENTITY,
FirstName varchar(30) NOT NULL,
LastNAme varchar(30) NOT NULL,
Title varchar(20),
Notes varchar(200)
)

CREATE TABLE Customers 
(
AccountNumber int PRIMARY KEY NOT NULL,
FirstName varchar(20) NOT NULL,
LastName varchar(20) NOT NULL,
PhoneNumber int NOT NULL,
EmergencyName varchar(50),
EmergencyNumber int,
Notes varchar(200)
)

CREATE TABLE RoomStatus
(
RoomStatus varchar(20) PRIMARY KEY NOT NULL,
Notes varchar(200)
)

CREATE TABLE RoomTypes
(
RoomType varchar(20) PRIMARY KEY NOT NULL,
Notes varchar(200)
)

CREATE TABLE BedTypes
(
BedType varchar(20) PRIMARY KEY NOT NULL,
Notes varchar(200)
)

CREATE TABLE Rooms 
(
RoomNumber int PRIMARY KEY NOt NULL,
RoomType varchar(20) NOT NULL,
BedType varchar(20) NOT NULL,
Rate int,
RoomStatus varchar(20) NOT NULL,
Notes varchar(300)
)

CREATE TABLE Payments
(
Id int PRIMARY KEY,
EmployeeId int NOT NULL,
PaymentDate date,
AccountNumber int NOT NULL,
FirstDateOccupied date,
LastDateOccupied date,
TotalDays int,
AmountCharged float(2),
TaxRate int,
TaxAmount float(2),
PaymentTotal float(2),
Notes varchar(300) 
)

CREATE TABLE Occupancies
(
Id int PRIMARY KEY IDENTITY,
EmployeeId int NOT NULL,
DateOccupied date NOT NULL,
AccountNumber int NOT NULL,
RoomNumber int NOT NULL,
RateApplied int,
PhoneCharge float(2),
Notes varchar(300) 
)

INSERT INTO Employees (FirstName, LastName)
VALUES ('Gosho', 'Petkov'),
('Petko', 'Petkov'),
('Petk', 'Goshov')

INSERT INTO Customers (AccountNumber, FirstName, LastName, PhoneNumber)
VALUES (123, 'Angel', 'Angelov', 989883448),
(134, 'Kuncho', 'Ivanov', 989883448),
(678, 'Yordan', 'Velev', 989883448)

INSERT INTO RoomStatus (RoomStatus)
VALUES ('available'),
('disabled'),
('dirty')

INSERT INTO RoomTypes (RoomType)
VALUES ('big'),
('small'),
('very big')

INSERT INTO BedTypes (BedType)
VALUES ('big'),
('small'),
('very big')

INSERT INTO Rooms (RoomNumber, RoomType, BedType, RoomStatus)
VALUES (1, 'small', 'small', 'available'),
(2, 'big', 'big', 'disabled'),
(3, 'very big', 'very big', 'dirty')


INSERT INTO Payments (Id, EmployeeId, AccountNumber)
VALUES (1, 1, 1),
(2,2,2),
(3,3,3) 

INSERT INTO Occupancies (EmployeeId, DateOccupied, AccountNumber, RoomNumber)
Values (1, '20170101', 1, 1),
(2, '20170101', 2, 2),
(3, '20170101', 3, 3)


-- problem 16
CREATE DATABASE SoftUni
USE SoftUni

CREATE TABLE Towns 
(
Id int IDENTITY PRIMARY KEY,
Name varchar(20) NOT NULL UNIQUE
)

CREATE TABLE Addresses
(
Id int IDENTITY PRIMARY KEY,
AddressText varchar(40) NOT NULL,
TownId int NOT NULL FOREIGN KEY REFERENCES Towns(Id)
)

CREATE TABLE Departments 
(
Id int IDENTITY PRIMARY KEY,
Name varchar(20) NOT NULL UNIQUE
)

CREATE TABLE Employees
(
Id int IDENTITY PRIMARY KEY,
FirstName varchar(20) NOT NULL,
MiddleName varchar(20) NOT NULL,
LastName varchar(20) NOT NULL,
JobTitle varchar(20),
DepartmentId int NOT NULL FOREIGN KEY REFERENCES Departments(Id),
HireDate date NOT NULL,
Salary float(2) NOT NULL,
AddressId int NOT NULL FOREIGN KEY REFERENCES Addresses(Id)
)

--problem 17
BACKUP DATABASE SoftUni
TO DISK = 'E:\Uchene\SoftUni\DB Fundamentals\DB Basics\softuni-backup.bak'

DROP DATABASE SoftUni

RESTORE DATABASE SoftUni
FROM DISK = 'E:\Uchene\SoftUni\DB Fundamentals\DB Basics\softuni-backup.bak'

--problem 18
USE SoftUni

INSERT INTO Towns (Name)
VALUES ('Sofiq'),
('Plovdiv'),
('Varna'),
('Burgas')

TRUNCATE TABLE Departments

INSERT INTO Departments (Name)
VALUES ('Engineering,'),
('Sales'),
('Marketing'),
('Software Development'),
('Quality Assurance')

INSERT INTO Addresses (AddressText, TownId)
VALUES ('Somewhere', 1),
('Somewhere', 2),
('Somewhere', 3),
('Somewhere', 1),
('Somewhere', 2)

INSERT INTO Employees (FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary, AddressId)
VALUES ('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '20130201', 3500.00, 1),
('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '20040302', 4000.00, 2),
('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '20160828', 525.25, 3),
('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '20071209', 3000.00, 4),
('Peter', 'Pan', 'Pan', 'Intern', 3, '20160828', 599.88, 5)

--problem 19
SELECT * FROM Towns

SELECT * FROM Departments

SELECT * FROM Employees

--problem 20
SELECT * FROM Towns
ORDER BY Name ASC

SELECT * FROM Departments
ORDER BY Name ASC

SELECT * FROM Employees
ORDER BY Salary DESC

--problem 21
SELECT Name FROM Towns
ORDER BY Name ASC

SELECT Name FROM Departments
ORDER BY Name ASC

SELECT FirstName, LastName, JobTitle, Salary FROM Employees
ORDER BY Salary DESC

--problem 22
UPDATE Employees
SET Salary += (Salary * 10) / 100

SELECT Salary FROM Employees

--problem 23
USE Hotel

UPDATE Payments
SET TaxRate -= (TaxRate * 3) / 100

SELECT TaxRate FROM Payments

--problem 24
TRUNCATE TABLE Occupancies