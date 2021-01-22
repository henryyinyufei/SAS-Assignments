/* Assignment 2 Question 2 */

data sleep;
	infile "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A2\sleep.dat";
	input Species_of_animal $ 1-25
	  	  Body_weight 
	  	  Brain_weight 
	  	  Non_dreaming_sleep 
	  	  Dreaming_sleep 
	  	  Total_sleep 
	  	  Maximum_life_span 
	  	  Gestation_time
	  	  Predator_index 
	  	  Sleep_exposure_index
	  	  Overall_danger_index;
	format Body_weight Brain_weight 8.3;

/* Convert the values of -999.0 to a missing value for each variable */
	if Non_dreaming_sleep = -999 then Non_dreaming_sleep = "";
	if Dreaming_sleep = -999 then Dreaming_sleep = "";
	if Total_sleep = -999 then Total_sleep = "";
	if Maximum_life_span = -999 then Maximum_life_span = "";
	if Gestation_time = -999 then Gestation_time = "";

/* Create a new variable of ratio of brain weight to body weight */
	ratio = Brain_weight / Body_weight;
run;

/* Summarize the data displaying the following quantities for each variable in the dataset:
Number of observations, number of missing observations, minimum, median, maximum, mean, and standard deviation */
proc means data = sleep n nmiss min median max mean std;
run;

/* Generate a PDF showing the first 10 observations with all variables of the dataset and summary values */
ods pdf file = "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A2\A2_Q2_output.pdf";
proc print data = sleep (obs=10);
run;

proc means data = sleep n nmiss min median max mean std;
run;
ods pdf close;
