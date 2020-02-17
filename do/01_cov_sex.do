* Prepare birth year 

	clear 
	infile using "$raw/background/background" 
	do "$raw/background/background-value-labels"
	rename PUBID_1997 ID 
	tolower 
	keep id r0536402
	rename r0536402 bdate_y
	
	tempfile birthyear 
	save `birthyear', replace 


* Years sexually active

	clear 
	infile using "$raw/sex/sex"
	
	do "$raw/sex/sex-value-labels"
	rename PUBID_1997 ID 
	tolower
	
	merge 1:1 id using `birthyear', nogen
	
	rename ysaq_300_* x_*
	rename ysaq2_300_* x_*
	
	ge X = .
	
	forval t = 1997/2015 { 
		
		if !inlist(`t',2012, 2014) {
			replace X = x_`t' if x_`t' >= 10
			
		}
	}
	
	drop x_* 
	
	ge age = 1997 - bdate_y

	forval i = 1/15 { 
	
		local j = `i' - 1 
		
		ge age_`i' = age + `j'
	
		ge yrs_sex_`i' = age_`i' - X + 1 if (X <= age_`i')
	
	}
	
	drop age* X

	forval i = 1/15 { 
	
		replace yrs_sex_`i' = 0 if yrs_sex_`i' == . 
	
	}
	
	keep id yrs_*
	
	save "$temp/var_sex", replace 
	