-- Active Borrowers with CTEs: Identify borrowers who've borrowed 2 or more books but haven't returned any using CTEs.

WITH ActiveBorrowers AS (
	SELECT l.BorrowerID, b.FirstName, b.LastName FROM Loans AS l
	JOIN Borrowers AS b
	ON l.BorrowerID = b.BorrowerID
	WHERE l.DateReturned IS NULL
	GROUP BY l.BorrowerID, b.FirstName, b.LastName
	HAVING COUNT(l.BorrowerID) >= 2
)
SELECT * FROM ActiveBorrowers;