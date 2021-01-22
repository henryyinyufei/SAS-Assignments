data One;
	input Subj $ Height Weight;

datalines;
001 68 155
002 75 20
003 65 99
005 79 266
006 70 190
009 61 122
;

run;

data Two;
	input Subj $ Salary dollar7.;
	format Salary dollar7.;

datalines;
001 $46,000
003 $67,900
004 $28,200
005 $98,202
006 $88,000
007 $57,200
;

run;

proc sql;
	
	create table Both1 as
	select * from One
	join Two                     
	on One.Subj = Two.Subj;


	create table Both2 as
	select One.Subj as One_Subj,
		   Two.Subj as Two_Subj,
		   Height, Weight, Salary
	from One full join Two
	on One.Subj = Two.Subj;


	create table Both3 as 
	select One.Subj as One_Subj,
	       Two.Subj as Two_Subj,
		   Height, Weight, Salary
	from One left join Two
	on One.Subj = Two.Subj;
quit;

ods pdf file = "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A4\A4_Q4a_output.pdf";

title 'include only those subjects who are in both data sets';
proc print data = Both1;
run;

title 'include all subjects from both data sets';
proc print data = Both2;
run;

title 'include only those subjects who are in data set ONE';
proc print data = Both3;
run;

ods pdf close;
