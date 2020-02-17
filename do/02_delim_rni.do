
** Delimit sample using "reason non-interview"
	
	clear
	infile using "$raw/rni/rni"
	
* Add labels and rename from NLSY dofile 
	
	do "$raw/rni/rni-value-labels"
	
	rename PUBID_1997 ID
	tolower
	
	ge insample_1 = 1 
	forval W = 2/15 {
	
		local w = 1997 - 1 + `W'

		* Interview date in date format. Only have month and year
		* set to day = 1 
		
		assert rni_`w' != . 
		ge insample_`W' = inrange(rni_`w', 60, 67) | rni_`w' == -4

	}
	

* Keep if at least in three adjacent interviews between waves 1-7 
	
	local v "insample"
	
	ge adj = 	(`v'_1 == 1 & `v'_2 == 1 & `v'_3 == 1)		///
		|		(`v'_2 == 1 & `v'_3 == 1 & `v'_4 == 1)		///
		|	 	(`v'_3 == 1 & `v'_4 == 1 & `v'_5 == 1)		///
		|		(`v'_4 == 1 & `v'_5 == 1 & `v'_6 == 1) 		///
		|		(`v'_5 == 1 & `v'_6 == 1 & `v'_7 == 1)		
		
	

	ge drop_not_3adj = adj == 0 
	ta drop_not_3adj									// N = 8,376
	
	drop if drop_not_3adj == 1 
	
* Keep relevant vars
	
	keep id insample_*
	
	
* Save data 
	
	save "$temp/data_delim", replace 
	
	