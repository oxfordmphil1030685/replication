
label define vlR0000100 0 "0"  1 "1 TO 999"  1000 "1000 TO 1999"  2000 "2000 TO 2999"  3000 "3000 TO 3999"  4000 "4000 TO 4999"  5000 "5000 TO 5999"  6000 "6000 TO 6999"  7000 "7000 TO 7999"  8000 "8000 TO 8999"  9000 "9000 TO 9999" 
label values R0000100 vlR0000100

label define vlR0357900 1 "Yes"  0 "No" 
label values R0357900 vlR0357900

label define vlR2189400 1 "Yes"  0 "No" 
label values R2189400 vlR2189400

label define vlR3508500 1 "Yes"  0 "No" 
label values R3508500 vlR3508500

label define vlR4906600 1 "Yes"  0 "No" 
label values R4906600 vlR4906600

label define vlR6534100 1 "YES"  0 "NO" 
label values R6534100 vlR6534100

label define vlS0921600 1 "YES"  0 "NO" 
label values S0921600 vlS0921600

label define vlS2988300 1 "YES"  0 "NO" 
label values S2988300 vlS2988300

label define vlS4682900 1 "YES"  0 "NO" 
label values S4682900 vlS4682900

label define vlS6318400 1 "YES"  0 "NO" 
label values S6318400 vlS6318400

label define vlS8333400 1 "YES"  0 "NO" 
label values S8333400 vlS8333400

label define vlT0740200 1 "YES"  0 "NO" 
label values T0740200 vlT0740200

label define vlT2783700 1 "YES"  0 "NO" 
label values T2783700 vlT2783700

label define vlT4495400 1 "YES"  0 "NO" 
label values T4495400 vlT4495400

label define vlT6144300 1 "YES"  0 "NO" 
label values T6144300 vlT6144300

label define vlT7638800 1 "YES"  0 "NO" 
label values T7638800 vlT7638800

label define vlT9040800 1 "YES"  0 "NO" 
label values T9040800 vlT9040800

label define vlU1031300 1 "YES"  0 "NO" 
label values U1031300 vlU1031300
/* Crosswalk for Reference number & Question name
 * Uncomment and edit this RENAME statement to rename variables for ease of use.
 * This command does not guarantee uniqueness
 */
  /* *start* */

  rename R0000100 PUBID_1997 
  rename R0357900 YSAQ_359_1997   // YSAQ-359
  rename R2189400 YSAQ_360C_1998   // YSAQ-360C
  rename R3508500 YSAQ_360C_1999   // YSAQ-360C
  rename R4906600 YSAQ_360C_2000   // YSAQ-360C
  rename R6534100 YSAQ_360C_2001   // YSAQ-360C
  rename S0921600 YSAQ_360C_2002   // YSAQ-360C
  rename S2988300 YSAQ_360C_2003   // YSAQ-360C
  rename S4682900 YSAQ_360C_2004   // YSAQ-360C
  rename S6318400 YSAQ_360C_2005   // YSAQ-360C
  rename S8333400 YSAQ_360C_2006   // YSAQ-360C
  rename T0740200 YSAQ_360C_2007   // YSAQ-360C
  rename T2783700 YSAQ_360C_2008   // YSAQ-360C
  rename T4495400 YSAQ_360C_2009   // YSAQ-360C
  rename T6144300 YSAQ_360C_2010   // YSAQ-360C
  rename T7638800 YSAQ_360C_2011   // YSAQ-360C
  rename T9040800 YSAQ_360C_2013   // YSAQ-360C
  rename U1031300 YSAQ_360C_2015   // YSAQ-360C


  /* *end* */  
/* To convert variable names to lower case use the TOLOWER command 
 *      (type findit tolower and follow the links to install).
 * TOLOWER VARLIST will change listed variables to lower case; 
 *  TOLOWER without a specified variable list will convert all variables in the dataset to lower case
 */
/* tolower */
