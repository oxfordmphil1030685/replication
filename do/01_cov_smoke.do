** Smoking dummy 
	clear 
	infile using "$raw/smoke/smoke"
	
	do "$raw/smoke/smoke-value-labels"
	
	rename PUBID_1997 ID 
	tolower

	rename ysaq_360c_* temp_*
	rename ysaq_359_1997 temp_1997
	
	forval i = 1/15 { 
	
		local t = 1997 - 1 + `i' 
		
		ge smoke_`i' = temp_`t' == 1 
		
	}
	
	drop temp*

	keep id smoke*
	
	save "$temp/var_smoke", replace 
	