-- Overdue Analysis: List all books overdue by more than 30 days with their associated borrowers.

SELECT b.BookID, b.Title, b.CurrentStatus, 
	l.DateBorrowed, l.DueDate, l.DateReturned, 
	bor.BorrowerID, bor.FirstName, bor.LastName, bor.Email, 
	DATEDIFF(Day, l.DueDate, GETDATE()) AS daysFromDueDate, 
	DATEDIFF(Day, l.DueDate, l.DateReturned) AS daysOfLateReturn 
FROM Loans AS l
JOIN Books AS b
ON b.BookID = l.BookID
JOIN Borrowers AS bor
ON bor.BorrowerID = l.BorrowerID
WHERE (DATEDIFF(day, l.DueDate, GETDATE()) > 30 AND 
	l.DateReturned IS NULL) OR DATEDIFF(DAY, l.DueDate, l.DateReturned) > 30;