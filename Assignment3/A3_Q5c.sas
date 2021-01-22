data investment;
	Amount = 0;
	do Year = 1 to 100 while (Amount < 30000); /* until (Amount >= 30000) */
		Amount = Amount + 1000;
		do Quarter = 1 to 4;
			Amount = Amount * ( 1 + 0.0425/4);
			output;
		end;
	end;
	format Amount dollar10.2;
run;

ods pdf file = "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A3\A3_Q5c_output.pdf"; 
proc print data = investment;
run;
ods pdf close;
