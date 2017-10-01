CREATE PROC udp_SendMessage(@UserId int,
                            @ChatId int,
							@Content varchar(200))
AS
IF NOT EXISTS(SELECT *
              FROM UsersChats
			  WHERE UserId = @UserId
			        AND 
					ChatId = @ChatId)
	RAISERROR('There is no chat with that user!', 16, 1)
ELSE
  BEGIN
  INSERT INTO Messages(ChatId, SentOn, UserId, Content)
  VALUES (@ChatId, GETDATE(), @UserId, @Content)
  END