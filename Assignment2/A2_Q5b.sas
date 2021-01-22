/* Assignment 2 Question 5b */

/* Repeat the problem using formatted input to read the data values instead of column input.*/
data Cache;
	infile "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A2\geocaching.txt"; 
	input @1  Name $20.
          @21 LongDeg 2.
		  @23 LongMin 6.3
		  @29 LatDeg 2.
		  @31 LatMin 6.3;
	format LongMin LatMin 6.3;
run;

/* Produce a simple report using PROC REPORT and produce a PDF document of that report. 
In your report, add a title called “Simple Report of Geocaching”.
When printing the report, replace each variable name with its description. */

ods pdf file = "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A2\A2_Q5b_output.pdf";
proc report data=Cache;
	title 'Simple Report of Geocaching';
	column(Name LongDeg LongMin LatDeg LatMin);
	define Name / 'Cache name';
	define LongDeg / 'Longitude degrees';
	define LongMin / 'Longitude minutes';
	define LatDeg / 'Latitude degrees';
	define LatMin / 'Latitude minutes';
run;
ods pdf close;
