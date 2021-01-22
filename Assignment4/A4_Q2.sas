libname mylib "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A4\Q2";

/* a) */

ods pdf file = "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A4\A4_Q2_output.pdf";

Title ' frequency count for each Destinatation ';
proc freq data = mylib.Sanfran;
	table Destination;
run;

Title 'frequency count for each DepartDay';
proc freq data = mylib.Sanfran;
	table DepartDay;
run;

/* b) */

Title 'frequency count for each Destinatation but without the cumulative';
proc freq data = mylib.Sanfran;
	table Destination / nocum;
run;

Title 'frequency count for each DepartDay but without the cumulative';
proc freq data = mylib.Sanfran;
	table DepartDay / nocum;
run;

/* c) */

Title 'A two-way table of Destination by DepartDay';
proc freq data = mylib.Sanfran;
	table Destination * DepartDay;
run;

ods pdf close;
