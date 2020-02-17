
label define vlR0000100 0 "0"  1 "1 TO 999"  1000 "1000 TO 1999"  2000 "2000 TO 2999"  3000 "3000 TO 3999"  4000 "4000 TO 4999"  5000 "5000 TO 5999"  6000 "6000 TO 6999"  7000 "7000 TO 7999"  8000 "8000 TO 8999"  9000 "9000 TO 9999" 
label values R0000100 vlR0000100

label define vlR0032000 1 "1: January"  2 "2: February"  3 "3: March"  4 "4: April"  5 "5: May"  6 "6: June"  7 "7: July"  8 "8: August"  9 "9: September"  10 "10: October"  11 "11: November"  12 "12: December" 
label values R0032000 vlR0032000

label define vlR0032001 1980 "1980"  1981 "1981"  1982 "1982"  1983 "1983"  1984 "1984"  1985 "1985"  1986 "1986"  1987 "1987"  1988 "1988"  1989 "1989"  1990 "1990"  1991 "1991"  1992 "1992"  1993 "1993"  1994 "1994"  1995 "1995"  1996 "1996"  1997 "1997"  1998 "1998" 
label values R0032001 vlR0032001
/* Crosswalk for Reference number & Question name
 * Uncomment and edit this RENAME statement to rename variables for ease of use.
 * This command does not guarantee uniqueness
 */
  /* *start* */

  rename R0000100 PUBID_1997 
  rename R0032000 YSCH_1400_M_1997   // YSCH-1400_M
  rename R0032001 YSCH_1400_Y_1997   // YSCH-1400_Y


  /* *end* */  
/* To convert variable names to lower case use the TOLOWER command 
 *      (type findit tolower and follow the links to install).
 * TOLOWER VARLIST will change listed variables to lower case; 
 *  TOLOWER without a specified variable list will convert all variables in the dataset to lower case
 */
/* tolower */
