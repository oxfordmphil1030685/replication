** Save extension data set 

	use "$temp/data_reshape", clear
	
	* Time-varying indep. vars lag 1 year behind y ==> same as pushing y on year ahead 
		
	tempfile crim 
	keep id t crim*	
	drop if t==1
	replace t = t-1	
	save `crim', replace 
		
	* merge on data and drop t=7 
	
	use "$temp/data_reshape", clear		
	
	* Sometimes we will need the wave 1 weight -- in regressions, therefore 
	* ensure that this is always kept 
	
	ge temp = w if t == 1 
	bysort id: egen W = max(w)
	drop temp 
	
	drop crim*
	merge 1:1 id t using `crim', keep(3) nogen 
	
	* Drop missings 
		
	drop if insample == 0 								// 10,905
	drop insample									
	drop if crim_prvl == . 								// 43,566
	
	
	* Make sure no missings in data now (excelt for the raw variable for mom's 
	* age at first child birth) 
	
	ds, varwidth(32) 
	local vars `r(varlist)' 
	foreach v in `vars' { 
		assert `v' != . 	
	}
	
	svyset id, weight(w)
	xtset id t
	save "$data/final_ext", replace 
	