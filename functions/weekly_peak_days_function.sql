DROP FUNCTION IF EXISTS fn_loansPercentageByDayOfWeek;
GO
CREATE FUNCTION fn_loansPercentageByDayOfWeek (@loans INT, @totalLoans int)
RETURNS  DECIMAL(5,2)
AS BEGIN
	DECLARE	@percentageOfLoans DECIMAL(5,2);

	SET @percentageOfLoans = (CAST(@loans AS FLOAT) / @totalLoans) * 100;
	RETURN @percentageOfLoans;
END;

WITH LoanCounts AS (
    SELECT 
        DATENAME(WEEKDAY, DateBorrowed) AS DayOfWeek, 
        COUNT(*) AS LoanCount
    FROM Loans
    GROUP BY DATENAME(WEEKDAY, DateBorrowed)
),
TotalLoans AS (
	SELECT COUNT(*) AS totalLoans FROM Loans
)

SELECT 
	DayOfWeek, 
	LoanCount, 
	dbo.fn_LoansPercentageByDayOfWeek(LoanCount, tl.totalLoans) AS PercentageOfLoans 
FROM LoanCounts 
CROSS JOIN TotalLoans AS tl
ORDER BY PercentageOfLoans DESC;