libname mylib "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A4\Q3";

ods pdf file = "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A4\A4_Q3a_output.pdf";

proc freq data= mylib.Mechanics;
	table Gender;
run;

proc freq data = mylib.Mechanics;
	table JobCode;
run;

proc freq data = mylib.Mechanics;
	table Gender * JobCode;
run;

ods pdf close;

/* 
Comment

i. What do you notice about the values of the variable Gender?
   I noticed that except F/M there are also B/G in variable Gender, I assume it recorded as boy/girl instead of male/female by accident. 

ii. What do you notice about the values of the variable JobCode?
	I noticed that there is 1 missing value in the variable JobCode.

What are the JobCode values for the invalid values of Gender?
The JobCode value for the invalid value of Gender B is MECH02, and
The JobCode value for the invalid value of Gender G is MECH03.
*/
