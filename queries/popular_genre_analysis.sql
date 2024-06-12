-- Popular Genre Analysis using Joins and Window Functions: Identify the most popular genre for a given month.

DECLARE @month INT = 11;
DECLARE @year INT = 2023;

SELECT b.Genre, COUNT(*) AS BorrowCount,
	RANK() OVER(ORDER BY COUNT(*) DESC) AS GenreRank, 
	DENSE_RANK() OVER(ORDER BY COUNT(*) DESC) AS GenreDenseRank 
FROM Loans AS l
JOIN Books AS b
ON l.BookID = b.BookID
WHERE MONTH(l.DateBorrowed) = @month AND YEAR(l.DateBorrowed) = @year
GROUP BY b.Genre;