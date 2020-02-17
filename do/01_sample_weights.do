** Sampling weights 
	clear 
	infile using "$raw/sampleweights/sampleweights"
	
	do "$raw/sampleweights/sampleweights-value-labels"
	
	rename PUBID_1997 ID
	tolower
	
	forval i = 1/15 { 
		
		local t = 1997 - 1 + `i' 
		ge w_`i' = sampling_panel_weight_`t'
		replace w_`i' = . if w_`i' < 0 
	
	}
	
	keep id w*
	
	save "$temp/var_sample_weights_panel", replace 
	