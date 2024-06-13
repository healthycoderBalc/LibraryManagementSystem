--Weekly peak days: 
-- The library is planning to employ a new part-time worker. This worker will work 3 days weekly in the library. 
-- From the data you have, determine the most 3 days in the week that have the most share of the loans and display the result of each day 
-- as a percentage of all loans. Sort the results from the highest percentage to the lowest percentage. (eg. 25.18% of the loans happen on Monday...)

WITH LoanCounts AS (
    SELECT 
        DATENAME(WEEKDAY, DateBorrowed) AS DayOfWeek, 
        COUNT(*) AS LoanCount
    FROM Loans
    GROUP BY DATENAME(WEEKDAY, DateBorrowed)
),
TotalLoans AS (
    SELECT COUNT(*) AS TotalLoanCount
    FROM Loans
),
DayPercentages AS (
    SELECT 
        lc.DayOfWeek,
        lc.LoanCount,
        (CAST(lc.LoanCount AS FLOAT) / tl.TotalLoanCount) * 100 AS PercentageOfLoans
    FROM LoanCounts lc
    CROSS JOIN TotalLoans tl
)

SELECT 
    DayOfWeek,
    LoanCount,
    PercentageOfLoans
FROM DayPercentages
ORDER BY PercentageOfLoans DESC;
