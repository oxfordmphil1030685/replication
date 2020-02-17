** Reshape variables 

	use "$temp/data_merge", clear 

	* List with all time-varying variables 
	ds *_1,  v(32)
	local vars `r(varlist)'
	
	local vars_tv ""
	foreach v in `vars' { 
	
		local V = substr("`v'",1,length("`v'")-1)
		local vars_tv "`vars_tv' `V'"
		
	}
	
	di "`vars_tv'"
	
	
	* Save time-constant vars in separate dataset to merge after reshape 
	* this is because we have too many to put into the id option in reshape 
		
	local not 
	forval i = 1/15 { 
		local not "`not' *_`i'"
	}
	
	ds `not'  id, not varwidth(32)
	local vars_tc "`r(varlist)'"
	di "`vars_tc'"	

	tempfile constants 
	preserve 
		
		keep id `vars_tc'
		save `constants', replace 
			
	restore 
	
	drop `vars_tc'
	
	
	* Reshape time-varying vars
	* and rename var to var_tv to indicate time-varying 
	
		reshape long `vars_tv', i(id) j(t)
		rename *_ *
		
	* Merge time constant vars 
		
		merge m:1 id using `constants', nogen 

	save "$temp/data_reshape", replace 