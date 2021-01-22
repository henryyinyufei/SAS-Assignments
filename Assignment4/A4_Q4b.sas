libname mylib "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A4\Q4";

proc sql;
	create table Percentage as
	select Subj, RBC, WBC, 
		   mean(RBC) as Mean_RBC,
		   mean(WBC) as Mean_WBC,
		   100*RBC/calculated Mean_RBC as Percent_RBC format = 10.3,
		   100*WBC/calculated Mean_WBC as Percent_WBC format = 10.3
	from mylib.Blood;
quit;

ods pdf file = "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A4\A4_Q4b_output.pdf";

proc print data = Percentage;
run;

ods pdf close;
