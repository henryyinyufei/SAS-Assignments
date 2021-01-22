/* Assignment 1 Question 3*/

data Student_data;
infile "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A1\stud_info.txt";/* infile before input*/
input Student_ID 1-4 name $ 6-16 weight 29-31;/* weight in pounds*/
run;

proc print data = Student_data;
run;
