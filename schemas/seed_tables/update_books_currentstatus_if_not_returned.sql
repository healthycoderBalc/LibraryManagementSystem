UPDATE Books
SET CurrentStatus = 
    CASE 
        WHEN EXISTS (
            SELECT 1
            FROM Loans
            WHERE Loans.BookID = Books.BookID
            AND Loans.DateReturned IS NULL
        ) THEN 'Borrowed'
        ELSE 'Available'
    END
WHERE EXISTS (
    SELECT 1
    FROM Loans
    WHERE Loans.BookID = Books.BookID
);
