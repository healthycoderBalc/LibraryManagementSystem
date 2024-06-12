-- Borrowing Frequency using Window Functions: Rank borrowers based on borrowing frequency.

SELECT BorrowerID, COUNT(*) AS BorrowCount, 
       RANK() OVER (ORDER BY COUNT(*) DESC) AS BorrowRank,
	   DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) AS BorrowDenseRank
FROM Loans
GROUP BY BorrowerID;