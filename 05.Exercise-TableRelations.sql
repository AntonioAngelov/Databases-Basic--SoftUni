CREATE DATABASE TableRelations
USE TableRelations

--problem 1
CREATE TABLE Persons
(
PersonID int IDENTITY(1,1),
FirstName varchar(30) NOT NULL,
Salary money NOT NULL,
PassportID int NOT NULL UNIQUE
)

CREATE TABLE Passports
(
PassportID int IDENTITY(101,1),
PassportNumber varchar(50) NOT NULL UNIQUE
)

INSERT INTO Persons (FirstName,Salary,PassportID)
VALUES('Roberto',43300.00,102),('Tom',56100.00,103),('Yana',60200.00,101)
 
INSERT INTO Passports(PassportNumber)
VALUES ('N34FG21B'),('K65LO4R7'),('ZE657QP2')
 

ALTER TABLE Persons
ADD PRIMARY KEY (PersonID)

ALTER TABLE Passports
ADD PRIMARY KEY (PassportID)

ALTER TABLE Persons
ADD CONSTRAINT fk_Person_Passport
FOREIGN KEY (PassportID)
REFERENCES Passports(PassportID)

--problem 2
CREATE TABLE Models
(
ModelID int IDENTITY(101,1),
Name varchar(50) NOT NULL,
ManufacturerID int NOT NULL
)

CREATE TABLE Manufacturers
(
ManufacturerID int IDENTITY(1,1) NOT NULL,
Name varchar(50) NOT NULL,
EstablishedOn date NOT NULL
)

INSERT INTO Models(Name, ManufacturerID)
VALUES ('X1', 1),
       ('i6', 1),
       ('Model S', 2),
       ('Model X', 2),
       ('Model 3', 2),
       ('Nova', 3)

INSERT INTO Manufacturers(Name, EstablishedOn)
VALUES ('BMW', '07/03/1916'),
       ('Tesla', '01/01/2003'),
	   ('Lada', '01/05/1966')

ALTER TABLE Models
ADD PRIMARY KEY (ModelID)

ALTER TABLE Manufacturers
ADD PRIMARY KEY (ManufacturerID)

ALTER TABLE Models
ADD FOREIGN KEY (ManufacturerID)
REFERENCES Manufacturers(ManufacturerID)

--problem 3
CREATE TABLE Students
(
StudentID int IDENTITY(1,1),
Name varchar(50) NOT NULL
)

CREATE TABLE Exams
(
ExamID int IDENTITY(101,1),
Name varchar(50) NOT NULL
)

CREATE TABLE StudentsExams
(
StudentID int NOT NULL,
ExamID int NOT NULL
)

INSERT INTO Students(Name)
VALUES ('Mila'),
       ('Toni'),
	   ('Ron')

	   
INSERT INTO Exams(Name)
VALUES ('SpringMVC'),
       ('Neo4j'),
	   ('Oracle 11g')

INSERT INTO StudentsExams(StudentID, ExamID)
VALUES (1, 101),
       (1, 102),
	   (2, 101),
	   (3, 103),
	   (2, 102),
	   (2, 103)

ALTER TABLE Students
ADD PRIMARY KEY (StudentID)

ALTER TABLE Exams
ADD PRIMARY KEY (ExamID)

ALTER TABLE StudentsExams
ADD PRIMARY KEY (StudentID, ExamID)

ALTER TABLE StudentsExams
ADD FOREIGN KEY (StudentID)
REFERENCES Students(StudentID)

ALTER TABLE StudentsExams
ADD FOREIGN KEY (ExamID)
REFERENCES Exams(ExamID)
--problem 4
CREATE TABLE Teachers
(
TeacherID int IDENTITY(101, 1),
Name varchar(40) NOT NULL,
ManagerID int 
)

INSERT INTO Teachers(Name, ManagerID)
VALUES ('John', NULL),
       ('Maya', 106),
	   ('Silvia', 106),
	   ('Ted', 105),
	   ('Mark', 101),
	   ('Greta', 101)

ALTER TABLE Teachers
ADD CONSTRAINT PK_Teachers
PRIMARY KEY (TeacherID)

ALTER TABLE Teachers
ADD CONSTRAINT FK_Teachers_Teachers
FOREIGN KEY (ManagerID)
REFERENCES Teachers(TeacherID)

--problem 5
CREATE DATABASE OnlineStore

USE OnlineStore

CREATE TABLE Cities
(
CityID int IDENTITY(1,1),
Name varchar(50) NOT NULL,
CONSTRAINT PK_CityID
PRIMARY KEY (CityID)
)

CREATE TABLE Customers
(
CustomerID int IDENTITY(1,1),
Name varchar(50) NOT NULL,
Birthday date,
CityID int NOT NULL,
CONSTRAINT PK_CustomerID
PRIMARY KEY (CustomerID),
CONSTRAINT FK_Customers_Cities
FOREIGN KEY (CityID)
REFERENCES Cities(CityID)
)

CREATE TABLE Orders
(
OrderID int IDENTITY(1,1),
CustomerID int NOT NULL,
CONSTRAINT PK_OrderID
PRIMARY KEY (OrderID),
CONSTRAINT FK_Orders_Customers
FOREIGN KEY (CustomerID)
REFERENCES Customers(CustomerID)
)

CREATE TABLE OrderItems
(
OrderID int NOT NULL,
ItemID int NOT NULL,
CONSTRAINT PK_OrderID_ItemID
PRIMARY KEY (OrderID, ItemID),
CONSTRAINT FK_OrderItems_Orders
FOREIGN KEY (OrderID)
REFERENCES Orders(OrderID)
)

CREATE TABLE Items
(
ItemID int IDENTITY(1,1),
Name varchar(50) NOT NULL,
ItemTypeID int NOT NULL,
CONSTRAINT PK_ItemID
PRIMARY KEY (ItemID)
)

ALTER TABLE OrderItems
ADD CONSTRAINT FK_OrderItems_Items
FOREIGN KEY (ItemID)
REFERENCES Items(ItemID)

CREATE TABLE ItemTypes
(
ItemTypeID int IDENTITY(1,1),
Name varchar(50) NOT NULL,
CONSTRAINT PK_ItemTypeID
PRIMARY KEY (ItemTypeID)
)

ALTER TABLE Items
ADD CONSTRAINT FK_Items_ItemTypes
FOREIGN KEY (ItemTypeID)
REFERENCES ItemTypes(ItemTypeID)

--problem 6
CREATE DATABASE University

USE University

CREATE TABLE Students
(
StudentID int IDENTITY(1,1),
StudentNumber int NOT NULL UNIQUE,
StudentName varchar(50) NOT NULL,
MajorID int NOT NULL,
CONSTRAINT PK_StudentID
PRIMARY KEY (StudentID)
)

CREATE TABLE Subjects
(
SubjectID int IDENTITY(1,1),
SubjectName varchar(50) NOT NULL,
CONSTRAINT PK_SubjectID
PRIMARY KEY (SubjectID)
)

CREATE TABLE Agenda
(
StudentID int ,
SubjectID int,
CONSTRAINT PK_StudentID_SubjectID
PRIMARY KEY (StudentID, SubjectID),
CONSTRAINT FK_Agenda_Students
FOREIGN KEY (StudentID)
REFERENCES Students(StudentID),
CONSTRAINT FK_Agenda_Subjects
FOREIGN KEY (SubjectID)
REFERENCES Subjects(SubjectID)
)

CREATE TABLE Majors
(
MajorID int IDENTITY(1,1),
Name varchar(50) NOT NULL,
CONSTRAINT PK_MajorID
PRIMARY KEY (MajorID)
)

ALTER TABLE Students
ADD CONSTRAINT FK_Students_Majors
FOREIGN KEY (MajorID)
REFERENCES Majors(MajorID)

CREATE TABLE Payments 
(
PaymentID int IDENTITY(1, 1),
PaymentDate date DEFAULT GETDATE(),
PaymentAmount float(2) NOT NULL,
StudentID int NOT NULL,
CONSTRAINT PK_PaymentID
PRIMARY KEY (PaymentID),
CONSTRAINT FK_Payments_Students
FOREIGN KEY (StudentID)
REFERENCES Students(StudentID)
)

--problem 9
USE Geography

SELECT m.MountainRange, p.PeakName, p.Elevation
FROM Mountains AS m,
     Peaks AS p
WHERE m.MountainRange = 'Rila' AND
      p.MountainId = 17
ORDER BY  p.Elevation DESC
                            