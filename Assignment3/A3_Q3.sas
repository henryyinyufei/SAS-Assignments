libname mylib "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A3\Q3";

data work.q3vienna;
	merge mylib.aprtarget(rename = (Flight = FlightID FClassTar = FTarget EClassTar = ETarget))
		  mylib.maytarget
		  mylib.juntarget;
	by Date;
	TotalTar = ETarget + FTarget;
	TotalRev = ERev + FRev;
run;

/* Browse the SAS log. There should be no warning or error messages. How many observations are written to the new data set? Comment on the code. */

/* There are 307 observations ( 120 from APR 120 from MAY 67 from JUN).
   Dataset is showing label, so we need to use proc contents to find the variable names for each dataset. we noticed that dataset aprtarget is using  different 
variable names, so we use rename option to rename them; Moreover, each dataset is sorted by date, so we merge them by date. */

ods pdf file = "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A3\A3_Q3_output.pdf"; 
proc print data = work.q3vienna (obs = 10);
	var FlightID Destination Date TotalTar TotalRev;
run;
ods pdf close;
