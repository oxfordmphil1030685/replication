* This dofile cleans the enrollment variables
* Importantly it creates the dropout and in-high-school dummies 

clear
infile using "$raw/enroll/enroll"

** relabel
do "$raw/enroll/enroll-value-labels"
rename PUBID_1997 ID 

tolower

rename cv_enrollstat_edt_* enroll*	
rename cv_enrollstat_* enroll*


** According to Table "Appendix A." (p. 89) we need the following vars: 
** 		1. dropout dummy - missing replaced with last year 
**		2. in high school dummy - i assume mssings handled in same way as 1.
** 		3. missing education status dummy 

forval i = 1/15 {

	local t = 1997 - 1 + `i'
	
	* missing indicator 
	 ge miss_enroll_`i' = inlist(enroll`t', -3, -5)
	
	* dropout dummy 
	 ge drpt_`i'  	= inlist(enroll`t',-2, 1,2) 
	 replace drpt_`i' = . if inlist(enroll`t', -3, -5)
	
	* in high school dummy 
	 ge inhs_`i' = enroll`t' == 8
	 replace inhs_`i' = . if inlist(enroll`t', -3, -5)

}

* Now replace missings with last year 

forval i = 2/15 { 

	local j = `i' - 1 
	 replace drpt_`i' = drpt_`j' if drpt_`i' == .
	 replace inhs_`i' = inhs_`j' if inhs_`i' == .

}

* Make sure inhs = 0 if drpt = 1 

forval i = 1/15 { 
	di `i'
	assert inhs_`i' == 0 if drpt_`i' == 1 

}

order id drpt* inhs*
keep id drpt* inhs* miss*

save "$temp/Xvar_enroll", replace 