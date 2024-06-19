-- Books Table indexes
CREATE INDEX IDX_Books_CurrentStatus ON Books(CurrentStatus);

-- Borrowers Table indexes
CREATE INDEX IDX_Borrowers_DateOfBirth ON Borrowers(DateOfBirth);

-- Loans Table indexes
CREATE INDEX IDX_Loans_BookID ON Loans(BookID);
CREATE INDEX IDX_Loans_BorrowerID ON Loans(BorrowerID);
CREATE INDEX IDX_Loans_DateBorrower ON Loans(DateBorrowed);
CREATE INDEX IDX_Loans_DueDate_DateReturned ON Loans(DueDate, DateReturned);

-- AuditLog table indexes
CREATE INDEX IDX_AuditLog_BookID ON AuditLog(BookID);
CREATE INDEX IDX_AuditLog_ChangeDate ON AuditLog(ChangeDate);
CREATE INDEX IDX_AuditLog_StatusChange ON AuditLog(StatusChange);

EXEC sp_helpindex 'Books';
EXEC sp_helpindex 'Borrowers';
EXEC sp_helpindex 'Loans';
EXEC sp_helpindex 'AuditLog';