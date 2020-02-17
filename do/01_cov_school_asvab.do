*** ASVAB Scores 

* Load and rename data 
	clear 
	infile using "$raw/asvab/asvab", clear
	
	do "$raw/asvab/asvab-value-labels"
	
	rename PUBID_1997 ID
	tolower
	
	keep id asvab*
	rename asvab_*_ability_est_*_1999 *_*
		
* Replace missings 		
		
	foreach v of varlist *_pos *_neg {
	
		replace `v' = . if inrange(`v',-5,-1)
		
	
	
	}

* Generate missing indicator 

	ge miss_asvab = 0 

	foreach v in ar wk pc mk { 

		replace miss_asvab = 1 if `v'_pos == . & `v'_neg == . 

	}

* Now streamline missings - i.e. either u have data on all or missing 

	foreach v in ar wk pc mk { 

		replace `v'_pos = . if miss_asvab == 1 
		replace `v'_neg = . if miss_asvab == 1 

	}
		
* Generate asvab subsets - pick negative / postive scores correctly 
* (negative and positive estimates are reported in separate variables)


	foreach v in ar wk pc mk { 
	
		replace `v'_neg = `v'_neg * -1
		ge asvab_`v' = `v'_pos 
		replace asvab_`v' = `v'_neg if `v'_pos == . 
		
		// Divide by 1000 
		replace asvab_`v' = asvab_`v' / 1000
		
		// Set missings to zero 
		replace asvab_`v' = 0 if asvab_`v' == . 
	}
	
	keep id asvab* miss
	
* Merge age and agesq to get normed residuals from regression (see p. 90)	
	
	merge 1:1 id using "$temp/var_background", keepus(age_1 agesq_1) nogen 
	rename (age_1 agesq_1) (age agesq)
	
	merge 1:1 id using "$temp/var_sample_weights_panel", keepus(w_1) nogen 
	
	su asvab*
		
	foreach v in ar wk pc mk { 
	
		reg asvab_`v' age agesq /*[w=w_1] */
		predict res_`v', residual
		egen mean = mean(res_`v') 
		egen sd = sd(res_`v')
		ge nres_`v' = (res_`v' - mean ) / sd 
		drop mean sd 
	
	
	}
	

	foreach v of varlist asvab* nres* res* { 
	
		replace `v' = 0 if miss == 1 
	
	}
	
	drop age agesq  w_1 
	
* Rename vars 

	keep id res* miss 
	rename res* asvab* 

	save "$temp/var_asvab", replace 
	
