--**Stored Procedure - Borrowed Books Report**:
-- **Procedure Name**: **`sp_BorrowedBooksReport`**
-- **Purpose**: Generate a report of books borrowed within a specified date range.
-- **Parameters**: **`StartDate`**, **`EndDate`**
-- **Implementation**: Retrieve all books borrowed within the given range, with details like borrower name and borrowing date.
-- **Return**: Tabulated report of borrowed books.

DROP PROCEDURE IF EXISTS sp_BorrowedBooksReport;
GO
CREATE PROCEDURE sp_BorrowedBooksReport (@StartDate DATE, @EndDate DATE)
AS BEGIN
  SELECT b.Title AS BookTitle, bor.FirstName AS borrowerFirstName, bor.LastName AS borrowerLastName, l.DateBorrowed, l.DueDate FROM Loans AS l
  JOIN Books AS b ON b.BookID = l.BookID
  JOIN Borrowers AS bor ON bor.BorrowerID = l.BorrowerID
  WHERE l.DateBorrowed BETWEEN @StartDate AND @EndDate;
END;


DECLARE @StartDateTest DATE = '12/10/2023';
DECLARE @EndDateTest DATE = '12/20/2023';

EXEC sp_BorrowedBooksReport @StartDateTest, @EndDateTest;