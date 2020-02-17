
label define vlR0000100 0 "0"  1 "1 TO 999"  1000 "1000 TO 1999"  2000 "2000 TO 2999"  3000 "3000 TO 3999"  4000 "4000 TO 4999"  5000 "5000 TO 5999"  6000 "6000 TO 6999"  7000 "7000 TO 7999"  8000 "8000 TO 8999"  9000 "9000 TO 9999" 
label values R0000100 vlR0000100

label define vlR0070400 1 "1.  Almost none (less than 10%)"  2 "2.  About 25%"  3 "3.  About half (50%)"  4 "4.  About 75%"  5 "5.  Almost all (more than 90%)" 
label values R0070400 vlR0070400

label define vlR0070500 1 "1.  Almost none (less than 10%)"  2 "2.  About 25%"  3 "3.  About half (50%)"  4 "4.  About 75%"  5 "5.  Almost all (more than 90%)" 
label values R0070500 vlR0070500

label define vlR0070700 1 "1.  Almost none (less than 10%)"  2 "2.  About 25%"  3 "3.  About half (50%)"  4 "4.  About 75%"  5 "5.  Almost all (more than 90%)" 
label values R0070700 vlR0070700

label define vlR0071000 1 "1.  Almost none (less than 10%)"  2 "2.  About 25%"  3 "3.  About half (50%)"  4 "4.  About 75%"  5 "5.  Almost all (more than 90%)" 
label values R0071000 vlR0071000

label define vlR0071100 1 "1.  Almost none (less than 10%)"  2 "2.  About 25%"  3 "3.  About half (50%)"  4 "4.  About 75%"  5 "5.  Almost all (more than 90%)" 
label values R0071100 vlR0071100
/* Crosswalk for Reference number & Question name
 * Uncomment and edit this RENAME statement to rename variables for ease of use.
 * This command does not guarantee uniqueness
 */
  /* *start* */

  rename R0000100 PUBID_1997 
  rename R0070400 YPRS_700_1997   // YPRS-700
  rename R0070500 YPRS_800_1997   // YPRS-800
  rename R0070700 YPRS_1000_1997   // YPRS-1000
  rename R0071000 YPRS_1300_1997   // YPRS-1300
  rename R0071100 YPRS_1400_1997   // YPRS-1400


  /* *end* */  
/* To convert variable names to lower case use the TOLOWER command 
 *      (type findit tolower and follow the links to install).
 * TOLOWER VARLIST will change listed variables to lower case; 
 *  TOLOWER without a specified variable list will convert all variables in the dataset to lower case
 */
/* tolower */
