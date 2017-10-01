--section 4
--task 15 Radians
CREATE FUNCTION udf_GetRadians (@degree float)
RETURNS float
AS
BEGIN 
RETURN (@degree * PI()) / 180
END 