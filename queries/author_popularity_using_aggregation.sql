-- Author Popularity using Aggregation: Rank authors by the borrowing frequency of their books.

SELECT Author, COUNT(*) AS BorrowingFrequency,
	DENSE_RANK() OVER(ORDER BY COUNT(*) DESC) AS Popularity
FROM Loans AS l
JOIN Books AS b
ON l.BookID = b.BookID
GROUP BY Author
ORDER BY BorrowingFrequency DESC;