
label define vlR0000100 0 "0"  1 "1 TO 999"  1000 "1000 TO 1999"  2000 "2000 TO 2999"  3000 "3000 TO 3999"  4000 "4000 TO 4999"  5000 "5000 TO 5999"  6000 "6000 TO 6999"  7000 "7000 TO 7999"  8000 "8000 TO 8999"  9000 "9000 TO 9999" 
label values R0000100 vlR0000100

label define vlR1193000 0 "0"  1 "1 TO 999"  1000 "1000 TO 1999"  2000 "2000 TO 2999"  3000 "3000 TO 3999"  4000 "4000 TO 4999"  5000 "5000 TO 5999"  6000 "6000 TO 6999"  7000 "7000 TO 7999"  8000 "8000 TO 8999"  9000 "9000 TO 9999" 
label values R1193000 vlR1193000
/* Crosswalk for Reference number & Question name
 * Uncomment and edit this RENAME statement to rename variables for ease of use.
 * This command does not guarantee uniqueness
 */
  /* *start* */

  rename R0000100 PUBID_1997 
  rename R1193000 SIDCODE_1997 


  /* *end* */  
/* To convert variable names to lower case use the TOLOWER command 
 *      (type findit tolower and follow the links to install).
 * TOLOWER VARLIST will change listed variables to lower case; 
 *  TOLOWER without a specified variable list will convert all variables in the dataset to lower case
 */
/* tolower */
