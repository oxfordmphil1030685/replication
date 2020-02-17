** Covariate: Alcohol

	clear
	infile using "$raw/alcohol/alcohol"
	
	do "$raw/alcohol/alcohol-value-labels"
	rename PUBID_1997 ID 
	tolower
	
	rename ysaq_364d_* temp_*
	rename ysaq_363_1997 temp_1997
	
	forval i = 1/15 { 
	
		local t = 1997 - 1 + `i' 
		
		ge alcohol_`i' = temp_`t' == 1 
		
	}
	
	drop temp*
	keep id alcohol_* 
	
	save "$temp/var_alcohol", replace 