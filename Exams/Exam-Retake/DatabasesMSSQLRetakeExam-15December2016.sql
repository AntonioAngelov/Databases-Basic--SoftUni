--section 1 
--task 1

CREATE DATABASE TheNerdHerd

USE TheNerdHerd

CREATE TABLE Locations
(
Id int IDENTITY(1, 1) PRIMARY KEY,
Latitude float,
Longitude float
)

CREATE TABLE Credentials
(
Id int IDENTITY(1, 1) PRIMARY KEY,
Email varchar(30),
Password varchar(20)
)

CREATE TABLE Users
(
Id int IDENTITY(1, 1) PRIMARY KEY,
Nickname varchar(25),
Gender char,
Age int,
LocationId int,
CredentialId int UNIQUE,
CONSTRAINT FK_Users_Locations
FOREIGN KEY (LocationId)
REFERENCES Locations(Id),
CONSTRAINT FK_Users_Credentials
FOREIGN KEY (CredentialId)
REFERENCES Credentials(Id)
)

CREATE TABLE Chats
(
Id int IDENTITY(1, 1) PRIMARY KEY,
Title varchar(32),
StartDate date,
IsActive Bit
)

CREATE TABLE Messages
(
Id int IDENTITY(1, 1) PRIMARY KEY,
Content varchar(200),
SentOn date,
ChatId int,
UserId int,
CONSTRAINT FK_Messages_Chats
FOREIGN KEY (ChatId)
REFERENCES Chats(Id),
CONSTRAINT FK_Messages_Users
FOREIGN KEY (UserId)
REFERENCES Users(Id)
)

CREATE TABLE UsersChats
(
UserId int,
ChatId int,
CONSTRAINT FK_UsersChats_Chats
FOREIGN KEY (ChatId)
REFERENCES Chats(Id),
CONSTRAINT FK_UsersChats_Users
FOREIGN KEY (UserId)
REFERENCES Users(Id),
CONSTRAINT PK_UserId_ChatId
PRIMARY KEY (ChatId, UserId)
)


--section 2
--task 2

INSERT INTO Messages(Content, SentOn, ChatId, UserId)
SELECT CONCAT(u.Age,'-', u.Gender, '-', l.Latitude, '-', l.Longitude),
       GETDATE(),
	   (CASE
	    WHEN u.Gender = 'F' THEN CEILING(SQRT(u.Age * 2))
		WHEN u.Gender = 'M' THEN CEILING(POWER(u.Age/18, 3))
		END),
		u.Id
FROM Users AS u
     JOIN 
	 Locations AS l
	 ON l.Id = u.LocationId
WHERE u.Id BETWEEN 10 AND 20
ORDER BY u.Id ASC

--task 3 UPDATE
UPDATE Chats
SET StartDate = (SELECT MIN(m.SentOn)
                 FROM Messages AS m
				 WHERE Chats.Id = m.ChatId)
WHERE Chats.Id IN (SELECT ch.Id
                   FROM Chats AS ch
				        JOIN 
						Messages AS m1
						ON m1.ChatId = ch.Id
						GROUP BY ch.Id, ch.StartDate
						HAVING ch.StartDate > MIN(m1.SentOn)
                  )

--task 4 DELETE
DELETE FROM Locations 
WHERE Locations.Id IN (SELECT l.Id
                       FROM Locations AS l
					        LEFT OUTER JOIN 
							Users AS u
							ON u.LocationId = l.Id
							WHERE u.Id IS NULL)

--section 3
--task 5 Age Range
SELECT Nickname, Gender, Age
FROM Users
WHERE Age BETWEEN 22 AND 37

--task 6 Messages
SELECT Content, SentOn
FROM Messages
WHERE SentOn > '05.12.2014 '
      AND
	  CHARINDEX('just', Content) > 0
ORDER BY Id DESC

--task 7 Chats
SELECT Title, IsActive
FROM Chats
WHERE IsActive = 0
      AND
	  LEN(Title) < 5
	  OR
	  SUBSTRING(Title, 3, 2) = 'tl'	  
ORDER BY Title DESC

--task 8 Chat Messages
SELECT DISTINCT ch.Id,
                ch.Title,
				m.Id
FROM Chats as ch
     INNER JOIN
	 Messages AS m
	 ON m.ChatId = ch.Id
WHERE m.SentOn < '03.26.2012 '
      AND 
	  RIGHT(ch.Title, 1) = 'x'
ORDER BY ch.Id ASC,
         m.Id ASC

--task 9 Message Count
SELECT TOP(5) ch.Id,
       COUNT(m.Id) AS [TotalMessages]
FROM Chats AS ch
     RIGHT JOIN
     Messages AS m
	 ON m.ChatId = ch.Id
WHERE m.Id < 90
GROUP BY ch.Id
ORDER BY [TotalMessages] DESC,
         ch.Id ASC

--task 10 Credentials
SELECT u.Nickname, 
       c.Email, 
	   c.Password
FROM Users AS u
     JOIN
	 Credentials AS c
	 ON u.CredentialId = c.Id
WHERE RIGHT(RTRIM(c.Email), 5) = 'co.uk'
ORDER BY c.Email ASC

--task 11 Locations
SELECT Id,
       Nickname,
	   Age
FROM Users  
WHERE LocationId IS NULL

--task 12 Left Users
SELECT m.Id,
       m.ChatId,
	   m.UserId
FROM Messages AS m
WHERE m.ChatId = 17
      AND (m.UserId NOT IN (SELECT UserId FROM UsersChats WHERE ChatId = m.ChatId) OR m.UserId IS NULL)
ORDER BY m.Id DESC

--task 13 Users in Bulgaria
SELECT u.Nickname,
       c.Title,
       l.Latitude,
	   l.Longitude
FROM Users AS u
     LEFT JOIN Locations AS l
	 ON l.Id = u.LocationId
	 LEFT JOIN UsersChats AS uc
	 ON u.Id = uc.UserId
	 LEFT JOIN 
	 Chats AS c
	 ON c.Id = uc.ChatId
WHERE l.Latitude BETWEEN 41.13999999 AND 44.12999999999
      AND
	  l.Longitude BETWEEN 22.209999999999 AND 28.3599999999
ORDER BY c.Title ASC

--task 14 Last Chat
SELECT ch.Title,
       m.Content
FROM (SELECT TOP(1) *
      FROM Chats
      ORDER BY StartDate DESC) AS ch
	  FULL OUTER JOIN
	  (SELECT *
	  FROM Messages
	  WHERE ChatId IN (SELECT TOP(1) Id
                       FROM Chats
                       ORDER BY StartDate DESC)) AS m
	  ON ch.Id = m.ChatId

--section 4
--task 19
CREATE TABLE MessagesLogs
(
Id int IDENTITY(1, 1) PRIMARY KEY,
Content varchar(200),
SentOn date,
ChatId int,
UserId int
)


