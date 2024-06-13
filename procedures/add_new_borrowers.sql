-- Stored Procedure - Add New Borrowers:
DROP PROCEDURE IF EXISTS sp_AddNewBorrower;
GO
CREATE PROCEDURE sp_AddNewBorrower(
	@FirstName VARCHAR(100), 
	@LastName VARCHAR(100), 
	@Email VARCHAR(100), 
	@DateOfBirth DATE, 
	@MembershipDate DATE, 
	@BorrowerID INT OUTPUT
)
AS BEGIN
	IF EXISTS (SELECT 1 FROM Borrowers WHERE Email = @Email)
	BEGIN
		RAISERROR('Borrower with email provided already exist', 16, 1);
		RETURN;
	END

	INSERT INTO Borrowers (FirstName, LastName, Email, DateOfBirth, MembershipDate) 
	VALUES (@FirstName, @LastName, @Email, @DateOfBirth, @MembershipDate);
	
	SET @BorrowerID = SCOPE_IDENTITY();
	SELECT b.BorrowerID FROM Borrowers AS b
	WHERE b.BorrowerID = @BorrowerID
END;


-- Execute procedure
DECLARE @FirstNameTest VARCHAR(100) = 'John';
DECLARE @LastNameTest VARCHAR(100) = 'Doe';
DECLARE @EmailTest VARCHAR(100) = 'john.doe3@example.com';
DECLARE @DateOfBirthTest DATE = '01/01/1990';
DECLARE @MembershipDateTest DATE = '01/01/2023';
DECLARE @BorrowerIDTest INT;

EXEC sp_AddNewBorrower @FirstNameTest, @LastNameTest, @EmailTest, @DateOfBirthTest, @MembershipDateTest, @BorrowerIDTest;
