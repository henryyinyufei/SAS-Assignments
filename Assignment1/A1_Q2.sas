/* Assignment 1 Question 2*/

data Student_expense;
input subject_ID 1-4 name $ 5-15 expense 16-22; /* Use $ to indicate character. Use number to specify column number*/ 
datalines;
1024Alice      1001.98
1167Maryann    2999.34
1168Thomas     3904.89
1201Benedictine1450.23
1302Felicia    1209.94
1471John       1763.09
1980Jane       3567.00
;
run;

proc print data = Student_expense;
run;
