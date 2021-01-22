/* Assignment 3 Question 1 */

/* a) Create a single data set in SAS using the six Division files and name it as DIVISION. You may have to use FIRSTOBS option to read datasets. */

/* Import Data and sort by division */

/* AO Division */
data AO_Division;
	infile "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A3\Q1\AO Division.dat" firstobs = 2;
	input Division $ 1-18 Job_Type $ 22-27;
run;

proc sort data = AO_Division;
	by Division;
run;

/* CORP Division */
data CORP_Division;
	infile "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A3\Q1\CORP Division.dat" firstobs = 2 truncover;
	input Division $ 1-20 Job_Type $ 22-27;
	if missing(cats(of _all_)) then delete; /* dealing with the empty row */
run;

proc sort data = CORP_Division;
	by Division;
run;

/* Finance_IT Division */
data Finance_IT_Division;
	infile "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A3\Q1\FINANCE_IT Division.dat" firstobs = 2;
	input Division $ 1-12 Job_Type $ 22-27;
run;

proc sort data = Finance_IT_Division;
	by Division;
run;

/* FLIGHT OPS Division */
data FLIGHT_OPS_Division;
	infile "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A3\Q1\FLIGHT OPS Division.dat" firstobs = 2;
	input Division $ 1-17 Job_Type $ 22-27;
run;

proc sort data = FLIGHT_OPS_Division;
	by Division;
run;

/* HR Division */
data HR_Division;
	infile "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A3\Q1\HR Division.dat" firstobs = 3;
	input Division $ 1-15 Job_Type $ 22-27;
run;

proc sort data = HR_Division;
	by Division;
run;

/* SALES Division */
data SALES_Division;
	infile "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A3\Q1\SALES Division.dat" firstobs = 2;
	input Division $ 1-17 Job_Type $ 22-27;
run;

proc sort data = SALES_Division;
	by Division;
run;

/* MERGE */

data DIVISION;
	merge AO_Division 
	      CORP_Division
		  FINANCE_IT_Division
		  FLIGHT_OPS_Division
		  HR_Division
		  SALES_Division;
	by Division;
run;

/* b) Combine DIVISION data with EmpData to create EmpData_div_merged dataset.
Then merge EmpData_div_merged dataset with Personal dataset to create the complete dataset and name it as Air_Emps_Full. */

/* import EmpData */
data EmpData;
	infile "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A3\Q1\empdata.dat" firstobs = 2;
	input Hire_Date : date9. empid : $6. Job_Code : $6. Salary : dollar10.;
	format Hire_Date date9. Salary dollar10.;
run;

proc sort data = EmpData;
	by Job_Code;
run;

proc sort data = DIVISION;
	by Job_Type;
run;

/* MERGE */

data EmpData_div;
	merge DIVISION (rename = (Job_Type = Job_Code))
		  EmpData;
    by Job_Code;
run;

/* import personal */
data Personal;
	infile "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A3\Q1\personal.dat" firstobs = 2 truncover;
	input @1  Last_Name  $19.
          @20 First_Name $20. 
          @40 Phone 
          @46 empid  $;
run;

proc sort data = Personal;
	by empid;
run;

proc sort data = EmpData_div;
	by empid;
run;

/* 
I. Ensure that the Air_Emps_Full dataset does not include the PHONE variable and update the salary variable to be named CurrentSalary. 
Include an appropriate format for this variable. 

II. Assign descriptive labels to the variables using LABEL statement (Hint: Read the online document on LABEL statement available at 
https://documentation.sas.com, or any other related SAS online document). Comment on the advantage of labelling variables.
*/

/* create permanent dataset for Q2 */
libname mylib "D:\Simon Fraser University\2020 fall\STAT 342\SAS_dataset";
data mylib.Air_Emps_Full;
	merge Personal
	      EmpData_div(rename = (Salary = Current_Salary));
	by empid;
	drop Phone;
	label Last_Name = Last Name
		  First_Name = First Name
		  empid = Employer ID
		  Division = Division
		  Job_Code = Job Title Abbreviation
		  Hire_Date = Hire Date
		  Current_Salary = Current Salary;
run;

/* 
The advantage of labelling variables.
	Using LABEL statement can associate labels with variables and change a label that is associated with a variable.
	If we use LABEL in data step, label is permanently assigned in the output data set descriptor. 
    If we use LABEL in proc step, we can temporarily associate a label with a variable for use during the procedure. 
	It reminds you what are the variable names stands for. 
*/ 

/* c) Use the Air_Emps_Full data set to create a subset of data that only includes records for employees that were hired prior to January 1, 1990, 
and whose current salary is below $45,000. Name this dataset as Air_Emps_Underpaid. */

data mylib.Air_Emps_Underpaid;
	set mylib.Air_Emps_Full;
	if missing(Hire_Date) and missing(Current_Salary) then delete; /* dealing with missing value, i think it is more reasonable to delete these data */
	where Hire_Date < '1JAN1990'd and Current_Salary < 45000;
run;

/* d) Produce a PDF showing the first 10 observations with all variables in Air_Emps_Underpaid. */
ods pdf file = "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A3\A3_Q1_output.pdf"; 
proc print data = mylib.Air_Emps_Underpaid (obs=10); 
run;
ods pdf close;
