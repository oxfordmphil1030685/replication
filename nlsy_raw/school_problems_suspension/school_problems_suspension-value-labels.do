
label define vlR0000100 0 "0"  1 "1 TO 999"  1000 "1000 TO 1999"  2000 "2000 TO 2999"  3000 "3000 TO 3999"  4000 "4000 TO 4999"  5000 "5000 TO 5999"  6000 "6000 TO 6999"  7000 "7000 TO 7999"  8000 "8000 TO 8999"  9000 "9000 TO 9999" 
label values R0000100 vlR0000100

label define vlR0034900 1 "YES"  0 "NO" 
label values R0034900 vlR0034900

label define vlR1694300 1 "YES"  0 "NO" 
label values R1694300 vlR1694300

label define vlR2982400 1 "YES"  0 "NO" 
label values R2982400 vlR2982400

label define vlR4248300 1 "Yes"  0 "No" 
label values R4248300 vlR4248300

label define vlR5905500 1 "YES"  0 "NO" 
label values R5905500 vlR5905500

label define vlS0279800 1 "YES"  0 "NO" 
label values S0279800 vlS0279800

label define vlS2319700 1 "YES"  0 "NO" 
label values S2319700 vlS2319700

label define vlS4096300 1 "YES"  0 "NO" 
label values S4096300 vlS4096300

label define vlS5659300 1 "YES"  0 "NO" 
label values S5659300 vlS5659300

label define vlS7735000 1 "YES"  0 "NO" 
label values S7735000 vlS7735000
/* Crosswalk for Reference number & Question name
 * Uncomment and edit this RENAME statement to rename variables for ease of use.
 * This command does not guarantee uniqueness
 */
  /* *start* */

  rename R0000100 PUBID_1997 
  rename R0034900 YSCH_5800_1997   // YSCH-5800
  rename R1694300 YSCH_5800_1998   // YSCH-5800
  rename R2982400 YSCH_5800_1999   // YSCH-5800
  rename R4248300 YSCH_5800_2000   // YSCH-5800
  rename R5905500 YSCH_5800_2001   // YSCH-5800
  rename S0279800 YSCH_5800_2002   // YSCH-5800
  rename S2319700 YSCH_5800_2003   // YSCH-5800
  rename S4096300 YSCH_5800_2004   // YSCH-5800
  rename S5659300 YSCH_5800_2005   // YSCH-5800
  rename S7735000 YSCH_5800_2006   // YSCH-5800


  /* *end* */  
/* To convert variable names to lower case use the TOLOWER command 
 *      (type findit tolower and follow the links to install).
 * TOLOWER VARLIST will change listed variables to lower case; 
 *  TOLOWER without a specified variable list will convert all variables in the dataset to lower case
 */
/* tolower */
