libname mylib "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A4\Q3";

ods pdf file = "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A4\A4_Q3b_output.pdf";

proc means data = mylib.Sanfran;
	var CargoRev TotPassCap;
run;

proc means data = mylib.Sanfran n mean median mode range std maxdec = 2; 
	var CargoRev TotPassCap;
	class Destination;
run;

ods pdf close;
