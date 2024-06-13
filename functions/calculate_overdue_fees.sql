-- Database Function - Calculate Overdue Fees:
-- **Function Name**: **`fn_CalculateOverdueFees`**
-- **Purpose**: Compute overdue fees for a given loan.
-- **Parameter**: **`LoanID`**
-- **Implementation**: Charge fees based on overdue days: $1/day for up to 30 days, $2/day after.
-- **Return**: Overdue fee for the **`LoanID`**.

CREATE FUNCTION fn_CalculateOverdueFees (@loanID INT)
RETURNS DECIMAL(10, 2) AS
BEGIN
	DECLARE @overdueFee DECIMAL(10,2), @DueDate DATE, @DateReturned DATE, @overdueDays INT;

	SELECT @DueDate = DueDate, @DateReturned = DateReturned FROM Loans
	WHERE LoanID = @loanID;

	IF @DateReturned IS NULL
		SET @DateReturned = GETDATE();
	SET @overdueDays = DATEDIFF(DAY, @DueDate, @DateReturned)
	IF @overdueDays <= 0
		SET @overdueFee = 0;
	ELSE IF @overdueDays <= 30
		SET @overdueFee = @overdueDays * 1.0;
	ELSE
		SET @overdueFee = 30 + (@overdueDays-30) * 2.0;

	RETURN @overdueFee;
END;

SELECT *, dbo.fn_CalculateOverdueFees(LoanID) as overduefee FROM Loans 
WHERE LoanID IN (1001, 1002, 1003);