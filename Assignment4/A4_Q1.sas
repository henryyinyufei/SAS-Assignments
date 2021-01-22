data fish;
	infile "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A4\Q1\Fish.dat" dlm = "|" dsd firstobs = 3 truncover;
	length Name $ 32;
	input Name $ LAT1 LAT2 LAT3 LONG1 LONG2 LONG3 LT DAM ELv Z SA N Hg ST DA RF FR;
	drop LAT1 LAT2 LAT3 LONG1 LONG2 LONG3; /* drop latitude or longitude variables */
	array variable(11) LT DAM ELv Z SA N Hg ST DA RF FR;

	do i = 1 to dim(variable);
		if variable(i) = . then variable(i) = 0;
	end; 
	drop i;
run;

/* a) Sort the data by lake type and dam status (LT and DAM). */

proc sort data = fish;
	by LT DAM;
run;

/* Use PROC MEANS to calculate the mean and median for each of the remaining numeric variables (all nine of them) separately for each combination of LT and DAM. */

proc means data = fish noprint;
	var ELv Z SA N Hg ST DA RF FR;
	by LT DAM;
	output out = STATZ
		   mean = 
		   median = /autoname;
run;

/* c) Combine these summary statistics with the original dataset (FISH) using an appropriate join technique to create a data set named ALL. */


data ALL;
	merge fish STATZ;
	by LT DAM;

/* d) use arrays to do the calculation */

	array variable(9) ELv Z SA N Hg ST DA RF FR;
	array mean(9) ELv_Mean Z_Mean SA_Mean N_Mean Hg_Mean ST_Mean DA_Mean RF_Mean FR_Mean;
	array mean_diff(9);
	array median(9) ELv_Median Z_Median SA_Median N_Median Hg_Median ST_Median DA_Median RF_Median FR_Median;
	array median_diff(9) ;
	array mean_diff_per(9) ;
	array median_diff_per(9) ;
	do i = 1 to 9;
		mean_diff(i) = variable(i) - mean(i);
		mean_diff_per(i) = (variable(i) - mean(i))/mean(i);
		median_diff(i) = variable(i) - median(i);
		median_diff_per(i) = (variable(i) - median(i))/median(i);
	end;

/* Apply reasonable formats and labels to all the variables that weren't originally in the FISH data set. */

	format 
		   ELv_Mean Z_Mean SA_Mean N_Mean Hg_Mean ST_Mean DA_Mean RF_Mean FR_Mean
		   ELv_Median Z_Median SA_Median N_Median Hg_Median ST_Median DA_Median RF_Median FR_Median
		   mean_diff1 mean_diff2 mean_diff3 mean_diff4 mean_diff5 mean_diff6 mean_diff7 mean_diff8 mean_diff9
		   median_diff1 median_diff2 median_diff3 median_diff4 median_diff5 median_diff6 median_diff7 median_diff8 median_diff9 10.2
		   mean_diff_per1 mean_diff_per2 mean_diff_per3 mean_diff_per4 mean_diff_per5 mean_diff_per6 mean_diff_per7 mean_diff_per8 mean_diff_per9
		   median_diff_per1 median_diff_per2 median_diff_per3 median_diff_per4 median_diff_per5 median_diff_per6 median_diff_per7 median_diff_per8 median_diff_per9 percentN10.2;
	label 
		   mean_diff1 = 'ELv mean difference'
		   mean_diff2 = 'Z mean difference'
		   mean_diff3 = 'SA mean difference'
		   mean_diff4 = 'N mean difference'
		   mean_diff5 = 'Hg mean difference'
		   mean_diff6 = 'ST mean difference'
		   mean_diff7 = 'DA mean difference'
		   mean_diff8 = 'RF mean difference'
		   mean_diff9 = 'FR mean difference'
		   median_diff1 = 'ELv median difference'
		   median_diff2 = 'Z median difference'
		   median_diff3 = 'SA median difference'
		   median_diff4 = 'N median difference'
		   median_diff5 = 'Hg median difference'
		   median_diff6 = 'ST median difference'
		   median_diff7 = 'DA median difference'
		   median_diff8 = 'RF median difference'
		   median_diff9 = 'FR median difference'
		   mean_diff_per1 = 'Elv percentage difference from the mean'
		   mean_diff_per2 = 'Z percentage difference from the mean'
		   mean_diff_per3 = 'SA percentage difference from the mean'
		   mean_diff_per4 = 'N percentage difference from the mean'
		   mean_diff_per5 = 'Hg percentage difference from the mean'
		   mean_diff_per6 = 'ST percentage difference from the mean'
		   mean_diff_per7 = 'DA percentage difference from the mean'
		   mean_diff_per8 = 'RF percentage difference from the mean'
		   mean_diff_per9 = 'FR percentage difference from the mean'
		   median_diff_per1 = 'ELv percentage difference from the median'
		   median_diff_per2 = 'Z percentage difference from the median'
		   median_diff_per3 = 'SA percentage difference from the median'
		   median_diff_per4 = 'N percentage difference from the median'
		   median_diff_per5 = 'Hg percentage difference from the median'
		   median_diff_per6 = 'ST percentage difference from the median'
		   median_diff_per7 = 'DA percentage difference from the median'
		   median_diff_per8 = 'RF percentage difference from the median'
		   median_diff_per9 = 'FR percentage difference from the median';

/* Drop any irrelevant variables. */
	drop _TYPE_ _FREQ_ i;
run;

proc sort data = ALL;
	by Name;
run;

ods pdf file = "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A4\A4_Q1_output.pdf"; 
proc print data = ALL (obs=10); 
run;
ods pdf close;
