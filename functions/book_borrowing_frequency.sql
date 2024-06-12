--Database Function - Book Borrowing Frequency:
--**Function Name**: **`fn_BookBorrowingFrequency`**
-- **Purpose**: Gauge the borrowing frequency of a book.
-- **Parameter**: **`BookID`**
-- **Implementation**: Count the number of times the book has been issued.
-- **Return**: Borrowing count of the book.

CREATE FUNCTION fn_BookBorrowingFrequency (@BookID INT)
RETURNS INT AS
BEGIN
	DECLARE @borrowingFrequency INT;

	SELECT @borrowingFrequency = COUNT(*) FROM Loans
	WHERE BookID = @bookID

	RETURN @borrowingFrequency;
END;

SELECT *, dbo.fn_BookBorrowingFrequency(BookID) as borrowingFrequency FROM Books
ORDER BY borrowingFrequency DESC;