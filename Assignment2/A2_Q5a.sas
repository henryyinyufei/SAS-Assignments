/* Assignment 2 Question 5a */

/* Create a temporary SAS data set called Cache using this data file. Use column input to read the data values and produce a PDF to present dataset */

data Cache;
	infile "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A2\geocaching.txt";
	input Name $ 1-20 LongDeg 21-22 LongMin 23-28 LatDeg 29-30 LatMin 31-36;
run;

ods pdf file = "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A2\A2_Q5a_output.pdf";
proc print data = Cache;
run;
ods pdf close;
