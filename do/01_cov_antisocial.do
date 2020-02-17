* 	Antisocial peer scale 

	* Missings just in the zero category ... if they are not in wave 
	* they will eventually dropout for missings in other variables

	clear 
	infile using "$raw/antisocial/antisocial"
	
	do "$raw/antisocial/antisocial-value-labels"
	rename PUBID_1997 ID
	tolower
	
	local i 1 
	foreach v in 700 800 1000 1300 1400 { 
	
		ge x_`i' = inrange(yprs_`v', 3, 5) 
		local ++i
	}
	
	ge antisocial = x_1 + x_2 + x_3 + x_4 + x_5
	
	keep id antisocial 
	save "$temp/var_antisocial", replace 
	