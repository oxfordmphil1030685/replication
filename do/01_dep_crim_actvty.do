** Dependent variables 

	clear
	infile using "$raw/crim_activity/crim_activity"
	
	** relabel
	do "$raw/crim_activity/crim_activity-value-labels"
	
	rename PUBID_1997 ID
	tolower
	
	** only property has "d" suffix instead of "b" 
	** change to ease loop 
	
	rename ysaq_389d* ysaq_389b*
	
	local lab_389 "prpty" 
	local lab_392 "prpty_oth"
	local lab_390 "thft_l50"
	local lab_391 "thft_m50"
	local lab_393 "viol"
	local lab_394 "drugs"

	foreach ctype in 389 392 390 391 393 394 { 
	
		forval i = 1/15 {
		
			local t = 1997 - 1 + `i'
				
			if `i' == 1	{
		
				// main specification: crime variable = 1 if answered yes 
				 ge `lab_`ctype''_`i' = ysaq_`ctype'_`t' == 1 			 
				 replace `lab_`ctype''_`i' = . if inlist(ysaq_`ctype'_`t',-1,-2,-3,-5)
			
			} 
			
			else {
			 
				 ge `lab_`ctype''_`i' = ysaq_`ctype'b_`t' == 1 			 
				 replace `lab_`ctype''_`i' = . if  inlist(ysaq_`ctype'b_`t',-1,-2,-3,-5)
			
			}
		}	
	}
	
	* Generate dep. vars 
	
	forval i = 1/15 { 
		
		 ge crim_prvl_`i' = 0 
		 ge crim_vrty_`i' = 0 
		
		foreach v in prpty prpty_oth thft_l50 thft_m50 viol drugs {
			
			 replace crim_prvl_`i' = 1 if `v'_`i' == 1 
			 replace crim_vrty_`i' = crim_vrty_`i' + 1 if `v'_`i' == 1 
		
		} 
		
	
	}
	
	* Set missings to missing 
	
	forval i = 1/15 { 
	
		foreach v in prpty prpty_oth thft_l50 thft_m50 viol drugs {
			
			 replace crim_prvl_`i' = . if `v'_`i' == . 
			 replace crim_vrty_`i' = . if `v'_`i' == . 
		
		}
	
	}
	
		
	* Keep generated variables and save 
	keep id crim*
	save "$temp/var_crim_actvty", replace 
	