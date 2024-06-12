-- Genre Preference by Age using Group By and Having: 
-- Determine the preferred genre of different age groups of borrowers. (Groups are (0,10), (11,20), (21,30)…)

-- FUNCTION FOR RETURNING AGE RANGE
CREATE FUNCTION fn_ageRange (@DateOfBirth DATE)
RETURNS CHAR(5) AS
BEGIN
	DECLARE @ageRange CHAR(5), @age INT;

	SET @age = DATEDIFF(YEAR, @DateOfBirth, GETDATE());

	IF @age BETWEEN 0 AND 10
	BEGIN SET @ageRange = '0-10'; END
	ELSE IF @age BETWEEN 11 AND 20 BEGIN SET @ageRange = '11-20'; END
	ELSE IF @age BETWEEN 21 AND 30 BEGIN SET @ageRange = '21-30'; END
	ELSE IF @age BETWEEN 31 AND 40 BEGIN SET @ageRange = '31-40'; END
	ELSE IF @age BETWEEN 41 AND 50 BEGIN SET @ageRange = '41-50'; END
	ELSE IF @age BETWEEN 51 AND 60 BEGIN SET @ageRange = '51-60'; END
	ELSE IF @age BETWEEN 61 AND 70 BEGIN SET @ageRange = '61-70'; END
	ELSE IF @age BETWEEN 71 AND 80 BEGIN SET @ageRange = '71-80'; END
	ELSE BEGIN SET @ageRange = 'Other'; END

	RETURN @ageRange;
END;

WITH GenreBorrowCounts AS (
	SELECT
		dbo.fn_ageRange(bor.DateOfBirth) AS AgeRange,
		b.Genre, 
		COUNT(*) AS BorrowCount,
		ROW_NUMBER() OVER (PARTITION BY dbo.fn_ageRange(bor.DateOfBirth) ORDER BY COUNT(*) DESC) AS RowNum
		FROM Loans AS l
		JOIN Books AS b ON l.BookID = b.BookID
		JOIN Borrowers AS bor ON bor.BorrowerID = l.BorrowerID
		GROUP BY dbo.fn_ageRange(bor.DateOfBirth), b.Genre
		HAVING COUNT (*) > 1
)

SELECT AgeRange, Genre, BorrowCount
FROM GenreBorrowCounts
WHERE RowNum = 1
ORDER BY AgeRange;