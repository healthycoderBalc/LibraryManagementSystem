--SQL Stored Procedure with Temp Table:
-- Design a stored procedure that retrieves all borrowers who have overdue books. 
-- Store these borrowers in a temporary table, then join this temp table with the Loans table to list out the specific overdue books for each borrower.

DROP PROCEDURE IF EXISTS sp_OverdueBooks;
GO
CREATE PROCEDURE sp_OverdueBooks
AS
BEGIN
    CREATE TABLE #OverdueBorrowers (
        BorrowerID INT,
		BorrowerFirstName VARCHAR(100),
		BorrowerLastName VARCHAR(100),
    );

	INSERT INTO #OverdueBorrowers (BorrowerID, BorrowerFirstName, BorrowerLastName)
    SELECT DISTINCT l.BorrowerID, bor.FirstName, bor.LastName
    FROM Loans AS l
	JOIN Borrowers AS bor ON bor.BorrowerID = l.BorrowerID
    WHERE DATEDIFF(DAY, DueDate, GETDATE()) > 0 AND DateReturned IS NULL;

	SELECT ob.BorrowerID, ob.BorrowerFirstName, ob.BorrowerLastName, l.BookID, b.Title AS BookTitle, b.Author AS BookAuthor, l.DateBorrowed, l.DueDate
    FROM #OverdueBorrowers ob
    JOIN Loans l ON ob.BorrowerID = l.BorrowerID
    JOIN Books b ON l.BorrowerID = b.BookID
    WHERE l.DateReturned IS NULL;

	DROP TABLE #OverdueBorrowers;
END;

EXEC sp_OverdueBooks;
