
label define vlR0000100 0 "0"  1 "1 TO 999"  1000 "1000 TO 1999"  2000 "2000 TO 2999"  3000 "3000 TO 3999"  4000 "4000 TO 4999"  5000 "5000 TO 5999"  6000 "6000 TO 6999"  7000 "7000 TO 7999"  8000 "8000 TO 8999"  9000 "9000 TO 9999" 
label values R0000100 vlR0000100

label define vlR0068900 0 "0"  1 "1 TO 4"  5 "5 TO 9"  10 "10 TO 14"  15 "15 TO 19"  20 "20 TO 24"  25 "25 TO 29"  30 "30 TO 34"  35 "35 TO 39"  40 "40 TO 44"  45 "45 TO 49"  50 "50 TO 99999999: 50+" 
label values R0068900 vlR0068900

label define vlR0069000 0 "0"  1 "1 TO 4"  5 "5 TO 9"  10 "10 TO 14"  15 "15 TO 19"  20 "20 TO 24"  25 "25 TO 29"  30 "30 TO 34"  35 "35 TO 39"  40 "40 TO 44"  45 "45 TO 49"  50 "50 TO 99999999: 50+" 
label values R0069000 vlR0069000

label define vlR0069100 0 "0"  1 "1 TO 4"  5 "5 TO 9"  10 "10 TO 14"  15 "15 TO 19"  20 "20 TO 24"  25 "25 TO 29"  30 "30 TO 34"  35 "35 TO 39"  40 "40 TO 44"  45 "45 TO 49"  50 "50 TO 99999999: 50+" 
label values R0069100 vlR0069100

label define vlR0069200 0 "0"  1 "1 TO 4"  5 "5 TO 9"  10 "10 TO 14"  15 "15 TO 19"  20 "20 TO 24"  25 "25 TO 29"  30 "30 TO 34"  35 "35 TO 39"  40 "40 TO 44"  45 "45 TO 49"  50 "50 TO 99999999: 50+" 
label values R0069200 vlR0069200
/* Crosswalk for Reference number & Question name
 * Uncomment and edit this RENAME statement to rename variables for ease of use.
 * This command does not guarantee uniqueness
 */
  /* *start* */
  rename R0000100 PUBID_1997 
  rename R0068900 YSCH_35900_1997   // YSCH-35900
  rename R0069000 YSCH_36000_1997   // YSCH-36000
  rename R0069100 YSCH_36100_1997   // YSCH-36100
  rename R0069200 YSCH_36200_1997   // YSCH-36200


  /* *end* */  
/* To convert variable names to lower case use the TOLOWER command 
 *      (type findit tolower and follow the links to install).
 * TOLOWER VARLIST will change listed variables to lower case; 
 *  TOLOWER without a specified variable list will convert all variables in the dataset to lower case
 */
/* tolower */
