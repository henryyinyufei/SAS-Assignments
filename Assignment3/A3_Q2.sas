libname mylib "D:\Simon Fraser University\2020 fall\STAT 342\SAS_dataset";

data Air_Emps_Raises;
	set mylib.Air_Emps_Full;
	Year = intck('year', Hire_Date, '01JAN2019'd, 'continuous');
    if Year >= 35 then do;
		if substr(Job_Code, 6, 1) = "2" or substr(Job_Code, 6, 1) = "3" then New_Salary = Current_Salary *1.025 + 3500;
        else if substr(Job_Code, 6, 1) = "1" then New_Salary = Current_Salary * 1.015 + 3500;
		else New_Salary = Current_Salary * 1.02 + 3500;
	end;
	else if 25 <= Year < 35 then do;
		if substr(Job_Code, 6, 1) = "2" or substr(Job_Code, 6, 1) = "3" then New_Salary = Current_Salary *1.02 + 2000;
		else if substr(Job_Code, 6, 1) = "1" then New_Salary = Current_Salary * 1.01 + 2000; 
		else New_Salary = Current_Salary * 1.0175 + 2000;
	end;
	else if Year < 25 then do;
		if substr(Job_Code, 6, 1) = "2" or substr(Job_Code, 6, 1) = "3" then New_Salary = Current_Salary *1.025;
		else if substr(Job_Code, 6, 1) = "1" then New_Salary = Current_Salary * 1.0125; 
		else New_Salary = Current_Salary * 1.0075; 
	end;
	if missing(Year) then put empid "Needs to be investigated";
	if missing(empid) then delete;
	label Year = years of service
		  New_Salary = raised salary;
	format New_Salary dollar10.2;
run;

proc sort data = Air_Emps_Raises;
	by empid;
run;

data Air_Emps_Underpaid;
	set mylib.Air_Emps_Underpaid;
	New_Salary = .;
run;

data Air_Emps_Underpaid_Update;
	update Air_Emps_Raises Air_Emps_Underpaid;
	by empid;
	where New_Salary < 45000;
	if missing(empid) then delete;
    drop Year;	
run;

ods pdf file = "D:\Simon Fraser University\2020 fall\STAT 342\Assignment\A3\A3_Q2_output.pdf"; 
Title 'Employees with new salary';
Footnote 'Employees with new salary';
proc print data = Air_Emps_Raises(obs=10);
run;

Title 'Emplyees still underpaid after raised salary'; 
Footnote 'Emplyees still underpaid after raised salary';
proc print data = Air_Emps_Underpaid_Update(obs = 10);
run;
ods pdf close;
