create database bank_loan;
use bank_loan;
select * from finance1;
select * from finance2;

/* Questions 
1.Year wise loan amount Stats
2.Grade and sub grade wise revol_bal
3.Total Payment for Verified Status Vs Total Payment for Non Verified Status
4.State wise and last_credit_pull_d wise loan status
5.Home ownership Vs last payment date stats
*/


#1.Year wise loan amount Stats
select year(issue_d) as year_issue , concat(format(sum(loan_amnt)/1000,0),'k') as loan_amount from finance1
group by 1
order by 1;

#2.Grade and sub grade wise revol_bal
select grade, sub_grade, concat(format(sum(revol_bal)/1000,0),'k') as revol_bal from finance1 f
join finance2 g on f.id = g.id
group by 1,2
order by 1,2;

#3.Total Payment for Verified Status Vs Total Payment for Non Verified Status
select verification_status, concat(format(sum(total_pymnt)/1000000,0),'m') as total_payment from finance1 f
join finance2 g on f.id = g.id 
group by 1 
limit 2;

#4.State wise and last_credit_pull_d wise loan status
select * from finance1;
select * from finance2;

select addr_state, last_credit_pull_d, loan_status from finance1 f 
join finance2 g on f.id = g.id 
group by 1,2,3 
order by 2;


#5.Home ownership Vs last payment date stats
select home_ownership, last_pymnt_d from finance1 f
join finance2 g on f.id = g.id
group by 1,2
order by 1;

select home_ownership, last_pymnt_d , round(sum(last_pymnt_amnt)) as Total_Last_Payment from finance1 f 
join finance2 g on f.id = g.id 
group by 1,2
order by 1 ;

/* Etc Questions
6.Purpose wise Max and Min Loan amount 
7.Average annual income for Home ownership w.r.t emp_length
8.Quarterly debt to income ratio 
*/

#6.Purpose wise Max and Min Loan amount
select * from finance1;
select * from finance2; 

select year(issue_d) as year,
		purpose,
	    max(loan_amnt) as "Max Loan Amount" ,
	    min(loan_amnt) as "Min Loan Amount" from finance1
group by 1,2
order by 1,2;

#7.Average annual income for Home ownership w.r.t emp_length
select emp_length, home_ownership, round(avg(annual_inc),2) as "Annual Income" from finance1
group by 1,2
order by 1,2;

#8.Quarterly debt to income ratio 
select year(issue_d) as year,
	   concat(quarter(issue_d), ' QTR') as quarter,
        round(avg(dti),2) as avg
 from finance1
 group by 1,2
 order by 1,2;
 