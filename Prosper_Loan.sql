alter table Prosper_Loan.prosper_loandata
modify LoanOriginationDate date;

SELECT
##LoanOriginationDate, 
date_format(LoanOriginationDate, '%Y-%m-01 00:00:00') as month, 
date_format(LoanOriginationDate, '%Y') as year, 
sum(LoanOriginalAmount) as total_dis, 
round(sum(LP_CustomerPayments),2) as total_paid, 
round(avg(EstimatedReturn),2) as profit, 
round(avg(EstimatedLoss), 2) as lossrate,
round(avg(DebtToIncomeRatio),2) as debtincome

FROM Prosper_Loan.prosper_loandata
WHERE LoanOriginationDate > '2009-12-31'
GROUP by 1, 2
ORDER BY 1;
