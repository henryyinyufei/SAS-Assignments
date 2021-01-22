/* Assignment 2 Question 3 */

data earthquake;
	infile "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A2\earthquake.dat" truncover;
/* TRUNCOVER enables you to read variable-length records when some records are shorter than the INPUT statement expects */

/* use an appropriate informat for the date and time of the earthquake */
	input @1  date yymmdd8.
		  @10 time time8.
		  @20 latitude $6. 
		  @27 longitude $7. 
		  @36 depth 4.
		  @41 magnitude $5. 
		  @47 quality $1.
		  @50 location $100.;

/* For each location specified in the comments field, calculate the time between successive earthquakes */
	datetime = dhms(date, 0,0,time);
	prev_datetime = lag(datetime);
	hours = intck('hour', prev_datetime, datetime);
	minutes = intck('minute', prev_datetime, datetime);
	seconds = intck('second', prev_datetime, datetime);
	format date yymmdd8. time time8. datetime prev_datetime datetime19.;
run;	

/* Generate a PDF showing the first 10 observations with all variables of the dataset */
ods pdf file = "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A2\A2_Q3_output.pdf";
option obs = 10;
proc print data = earthquake;
run;
ods pdf close;
