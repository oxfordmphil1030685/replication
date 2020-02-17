** Covariate: Add number of arrests 

	clear
	infile using "$raw/crim_arrests/crim_arrests"
	
	** relabel
	do "$raw/crim_arrests/crim_arrests-value-labels"
	
	rename PUBID_1997 ID
	tolower

	** rename 1997 to correspond with subsequent variables (DLI)
	rename ysaq_440_1997 ysaq_443_1997 
	
	
	** Generate variables 
	
	forval i = 1/15 { 
		
		
		* DEFINE YEAR MACRO 
		local t = 1997 - 1 + `i'
		
	
		* GENERAL RECODINGS - APPLIES TO ALL VARS: 
		* - Non-interviews set to missing (-5)
		* - Valid skips set to 0 (-4)
		* - Always cap arrests at 9 
		
			replace ysaq_443_`t' = 0 if ysaq_443_`t' == -4 
			replace ysaq_443_`t' = . if ysaq_443_`t' == -5 
			replace ysaq_443_`t' = 9 if ysaq_443_`t' > 9 & ysaq_443_`t' != .
			
		* MAIN SPECIFICATIONS 
		* - Refusals (-1) and Non-answers (-2) set to 0
		
			// Number of arrests in wave t  
				
				ge arrests_`i' = ysaq_443_`t' 
				replace arrests_`i' = 0 if inlist(ysaq_443_`t',-1,-2)		
				
				
	}
	
	
	* Keep relevant variables and save 
	
		keep id arrests*
		save "$temp/var_arrests", replace 
		
		