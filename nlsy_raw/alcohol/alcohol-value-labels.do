
label define vlR0000100 0 "0"  1 "1 TO 999"  1000 "1000 TO 1999"  2000 "2000 TO 2999"  3000 "3000 TO 3999"  4000 "4000 TO 4999"  5000 "5000 TO 5999"  6000 "6000 TO 6999"  7000 "7000 TO 7999"  8000 "8000 TO 8999"  9000 "9000 TO 9999" 
label values R0000100 vlR0000100

label define vlR0358300 1 "Yes"  0 "No" 
label values R0358300 vlR0358300

label define vlR2190200 1 "Yes"  0 "No" 
label values R2190200 vlR2190200

label define vlR3509300 1 "Yes"  0 "No" 
label values R3509300 vlR3509300

label define vlR4907400 1 "Yes"  0 "No" 
label values R4907400 vlR4907400

label define vlR6534700 1 "YES"  0 "NO" 
label values R6534700 vlR6534700

label define vlS0922200 1 "YES"  0 "NO" 
label values S0922200 vlS0922200

label define vlS2988900 1 "YES"  0 "NO" 
label values S2988900 vlS2988900

label define vlS4683700 1 "YES"  0 "NO" 
label values S4683700 vlS4683700

label define vlS6319300 1 "YES"  0 "NO" 
label values S6319300 vlS6319300

label define vlS8333800 1 "YES"  0 "NO" 
label values S8333800 vlS8333800

label define vlT0740600 1 "YES"  0 "NO" 
label values T0740600 vlT0740600

label define vlT2784100 1 "YES"  0 "NO" 
label values T2784100 vlT2784100

label define vlT4495800 1 "YES"  0 "NO" 
label values T4495800 vlT4495800

label define vlT6144700 1 "YES"  0 "NO" 
label values T6144700 vlT6144700

label define vlT7639200 1 "YES"  0 "NO" 
label values T7639200 vlT7639200

label define vlT9041200 1 "YES"  0 "NO" 
label values T9041200 vlT9041200

label define vlU1031700 1 "YES"  0 "NO" 
label values U1031700 vlU1031700
/* Crosswalk for Reference number & Question name
 * Uncomment and edit this RENAME statement to rename variables for ease of use.
 * This command does not guarantee uniqueness
 */
  /* *start* */

  rename R0000100 PUBID_1997 
  rename R0358300 YSAQ_363_1997   // YSAQ-363
  rename R2190200 YSAQ_364D_1998   // YSAQ-364D
  rename R3509300 YSAQ_364D_1999   // YSAQ-364D
  rename R4907400 YSAQ_364D_2000   // YSAQ-364D
  rename R6534700 YSAQ_364D_2001   // YSAQ-364D
  rename S0922200 YSAQ_364D_2002   // YSAQ-364D
  rename S2988900 YSAQ_364D_2003   // YSAQ-364D
  rename S4683700 YSAQ_364D_2004   // YSAQ-364D
  rename S6319300 YSAQ_364D_2005   // YSAQ-364D
  rename S8333800 YSAQ_364D_2006   // YSAQ-364D
  rename T0740600 YSAQ_364D_2007   // YSAQ-364D
  rename T2784100 YSAQ_364D_2008   // YSAQ-364D
  rename T4495800 YSAQ_364D_2009   // YSAQ-364D
  rename T6144700 YSAQ_364D_2010   // YSAQ-364D
  rename T7639200 YSAQ_364D_2011   // YSAQ-364D
  rename T9041200 YSAQ_364D_2013   // YSAQ-364D
  rename U1031700 YSAQ_364D_2015   // YSAQ-364D


  /* *end* */  
/* To convert variable names to lower case use the TOLOWER command 
 *      (type findit tolower and follow the links to install).
 * TOLOWER VARLIST will change listed variables to lower case; 
 *  TOLOWER without a specified variable list will convert all variables in the dataset to lower case
 */
/* tolower */
