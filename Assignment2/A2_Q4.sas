/* Assignment Question 4 */

filename File "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A2\President.txt";
data president;
	infile  File dlm = '09'x truncover;
	length FullName $ 28 City $ 28 State $ 28;

/* Assign an appropriate format to DOB, votes, and PercVote */
	input FullName : $
		  City : $
          State : $
          ASP : 
          DOB : mmddyy10.
          Term : 
          Votes : comma10.
          PercVote : percent8.2;
	format DOB mmddyy10. Votes comma10. PercVote percent8.2;

/* Create a character variable (DOBC) that contains DOB in the form 01JAN1960 */
	DOBC = put(DOB,date9.);

/* Use the SUBSTR() function to create a new character variables to hold the day, month, and year from DOBC */
	day_substr = substr(DOBC,1,2);
	month_substr = substr(DOBC,3,3);
	year_substr = substr(DOBC,6,4);
	
/* Create another character version of DOB and name it DOBC2, these dates should be in the form 31/01/1960 */
	DOBC2 = put(DOB,ddmmyy10.);

/* Using the SCAN() function to create three numeric variables that hold the day, month, and year from DOBC2 */
	day_scan = scan(DOBC2,1);
	month_scan = scan(DOBC2,2);
	year_scan = scan(DOBC2,3);

/* What is the difference between SUBSTR() and SCAN(). Include a brief comment in your code */
	/* We can get substring by using SUBSTR() function, SUBSTR(string,position,length). 
	For each DOBC string we can get day start from first position and length is 2, and we can use the same method to get month and year.
	The different between DOBC and DOBC2 is DOBC contains the whole date string and DOBC2 presents the date with delimiter "/".
	We can use SCAN() function in this case. SCAN(expression, n). Delimiter"/" devides the date into 3 parts.
    For each DOBC2 we can get day from the first part, month from second part, and year from third part. */

run;

/* Produce a PDF showing the first 10 observations with all variables and the descriptor portion of the data set with an appropriate title */
ods pdf file = "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A2\A2_Q4_output.pdf";
option obs = 10;
title 'President Data';
proc print data = president;
run;
ods pdf close;
