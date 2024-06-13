-- List of Borrowed Books: Retrieve all books borrowed by a specific borrower, including those currently unreturned.
DECLARE @BorrowerID INT = 254;
SELECT b.BookId, b.Title, b.ISBN, b.PublishedDate, b.Genre, b.ShelfLocation, b.CurrentStatus, l.BorrowerID, l.DateBorrowed, l.DueDate, l.DateReturned FROM Books as b
JOIN Loans as l ON b.BookId = l.BookID
WHERE l.BorrowerID = @BorrowerID;