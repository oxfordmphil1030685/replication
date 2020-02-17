
label define vlR0000100 0 "0"  1 "1 TO 999"  1000 "1000 TO 1999"  2000 "2000 TO 2999"  3000 "3000 TO 3999"  4000 "4000 TO 4999"  5000 "5000 TO 5999"  6000 "6000 TO 6999"  7000 "7000 TO 7999"  8000 "8000 TO 8999"  9000 "9000 TO 9999" 
label values R0000100 vlR0000100

label define vlR9871900 -9 "-9: No courses with valid credits and grades"  -8 "-8: Pre-High school only"  -7 "-7: No credits earned"  -6 "-6: No courses taken"  0 "0 TO 99: 0 to .99"  100 "100 TO 199: 1.00 to 1.99"  200 "200 TO 299: 2.00 to 2.99"  300 "300 TO 399: 3.00 to 3.99"  400 "400 TO 500: 4.00 to 5.00" 
label values R9871900 vlR9871900
/* Crosswalk for Reference number & Question name
 * Uncomment and edit this RENAME statement to rename variables for ease of use.
 * This command does not guarantee uniqueness
 */
  /* *start* */

  rename R0000100 PUBID_1997 
  rename R9871900 TRANS_CRD_GPA_OVERALL_HSTR 


  /* *end* */  
/* To convert variable names to lower case use the TOLOWER command 
 *      (type findit tolower and follow the links to install).
 * TOLOWER VARLIST will change listed variables to lower case; 
 *  TOLOWER without a specified variable list will convert all variables in the dataset to lower case
 */
/* tolower */
