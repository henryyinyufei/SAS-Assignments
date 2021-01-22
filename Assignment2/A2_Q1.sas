/* Assignment 2 Question 1 */

data Stocks;
	infile "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A2\stocks.txt" dlm='09'x;
	input Stock_symbol $ Price Shares;

/* Create a new variable (Value) equal to the stock price times the number of shares. */
	Value = Price * Shares;
run;

/* Write the appropriate statement to compute the average price and the average number of shares of your stock. */
proc means data = Stocks mean;
	var Price Shares;
run;

/* Produce a PDF document to present the dataset without any observation numbers. */
ods pdf file = "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A2\A2_Q1_output.pdf";
proc print data = Stocks noobs;
run;
ods pdf close;
