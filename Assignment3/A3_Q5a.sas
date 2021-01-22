data doloop;
	do x=0 to 10 by 0.10;
		y = 3 * x**2 - 5 * x +10;
	output;
	end;
run;

ods pdf file = "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A3\A3_Q5a_output.pdf"; 
proc gplot data = doloop;
	plot y*x;
run;
quit;
ods pdf close;
