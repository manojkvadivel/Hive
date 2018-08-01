/*
Problem Statement
1. Find the list of people with grade “B” who have taken loan.
2. Find the list of people having interest more than 1000.
3. Find the list of people having loan amount more than 1000.
4. Get the highest loan amount given to grade users (A-G).
5. Highest loan amount given in that year with that Employee id and Employees annual income.
6. Get the total number of loans with loan id and load amount which are having loan status as Late.
7. Average loan interest rate with 60-month term and 36-month term. 
*/

--1. Find the list of people with grade “B” who have taken loan.

select member_id from makv.loan_data where grade ='B';


--2. Find the list of people having interest more than 1000.

select member_id from makv.loan_data where installment > 1000;

--3. Find the list of people having loan amount more than 1000.

select member_id from makv.loan_data where loan_amnt > 1000;


--4. Get the highest loan amount given to grade users (A-G).

select max(loan_amnt) from makv.loan_data where grade between 'A' and  'G' ;
--35000

select grade, max(loan_amnt) AS max_loan_amnt from loan_data where grade between 'A' and  'G' group by grade order by grade;
/*
grade	max_loan_amnt
    A	35000
    B	35000
    C	35000
    D	35000
    E	35000
    F	35000
    G	35000
*/

--5. Highest loan amount given in that year with that Employee id and Employees annual income.

SELECT member_id,annual_inc,loan_amnt FROM

(SELECT member_id,annual_inc,loan_amnt, RANK() over (partition by substring(issue_d,1,2) order by loan_amnt desc) as rank

FROM makv.loan_data) ranked_loans

WHERE ranked_loans.rank=1;


--6. Get the total number of loans with loan id and loan amount which are having loan status as Late.
select id, loan_amnt,loan_status, count(*) as total_number_of_loans from makv.loan_data where (loan_status like '%Late%') group by id, loan_amnt, loan_status;

--7. Average loan interest rate with 60-month term and 36-month term. 

select term,avg(regexp_replace(int_rate,'%','')) from makv.loan_data where trim(term) in ('60 months','36 months') group by term ;
/*
 	term	_c1
1	 60 months	17.96790255912411
2	 36 months	13.143560305884431
*/
