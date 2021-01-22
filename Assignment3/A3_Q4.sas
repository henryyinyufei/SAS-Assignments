libname mylib "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A3\Q4";

proc sort data = mylib.target121999 out = work.sort_b;
	by FlightID;
	where Date = '15DEC1999'd;
run;

proc sort data = mylib.sales121999 out = work.sort_s;
	by FlightID;
	where Date = '15DEC1999'd;
run;

data compare;
	merge work.sort_b
	      work.sort_s;
	by FlightID;
	LostCargoRev = CargoTarRev - CargoRev;
	format LostCargoRev dollar10.2;
	label LostCargoRev = cargo revenue lost on December15,1995 due to the weather;
run;

ods pdf file = "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A3\A3_Q4_output.pdf";
proc print data = compare;
	var CargoTarRev CargoRev LostCargoRev;
run;
ods pdf close;
