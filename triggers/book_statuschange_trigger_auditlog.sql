--Trigger Implementation
-- Design a trigger to log an entry into a separate AuditLog table whenever a book's status changes from 'Available' to 'Borrowed' or vice versa. 
-- The AuditLog should capture BookID, StatusChange, and ChangeDate.

CREATE TABLE AuditLog (
	LogID INT PRIMARY KEY IDENTITY(1,1),
	BookID INT,
	StatusChange VARCHAR(50),
	ChangeDate DATETIME
);

CREATE TRIGGER trg_AuditBookStatusChange
ON Books
AFTER UPDATE
AS
BEGIN
    DECLARE @BookID INT, @OldStatus VARCHAR(10), @NewStatus VARCHAR(10);

    SELECT @BookID = INSERTED.BookID, @OldStatus = DELETED.CurrentStatus, @NewStatus = INSERTED.CurrentStatus
    FROM INSERTED
    JOIN DELETED ON INSERTED.BookID = DELETED.BookID;

    IF @OldStatus != @NewStatus
    BEGIN
        INSERT INTO AuditLog (BookID, StatusChange, ChangeDate)
        VALUES (@BookID, CONCAT(@OldStatus, ' to ', @NewStatus), GETDATE());
    END
END;

-- Testing trigger
DECLARE @BookIDToUpdate INT = 1;
DECLARE @NewStatusTest VARCHAR(10) = 'Available';
UPDATE Books
SET CurrentStatus = @NewStatusTest
WHERE BookID = @BookIDToUpdate;

SELECT * FROM AuditLog;
