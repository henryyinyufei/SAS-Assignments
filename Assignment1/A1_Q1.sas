/* Assignment 1 Question 1*/

data Student_data;
length subject_ID name $ 11;/* Using length statement to change variable length in order to show the whole name of "Benedictine"*/ 
input subject_ID name $ eye_color $ height weight; /* height in inches, weight in pounds*/
datalines;
1024 Alice Brown 65 125
1167 Maryann Black 68 140
1168 Thomas Black 68 190
1201 Benedictine Amber 68 190
1302 Felicia Gray 63 115
;
run;

proc print data = Student_data;
run;
