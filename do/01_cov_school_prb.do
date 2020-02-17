** Problematic school behavior

* 08_1: Retention 
	
	clear
	infile using "$raw/school_problems_retention/school_problems_retention"
	
	** relabel
	do "$raw/school_problems_retention/school_problems_retention-value-labels"
	
	rename PUBID_1997 ID
	tolower
	
	ge rtnt = 0 
	
	forval i = 1/11 {
		
		local t = 1997 - 1 + `i'
		replace rtnt = 1 if cv_grades_repeat_ever_`t' > 0 
		

	}
	
	drop cv_grades_rep* 
	save "$temp/Xvar_school_prb_rtnt", replace 
	
	*________________________________________________________
	
	* 08_2: Suspension 
	
	clear
	infile using "$raw/school_problems_suspension/school_problems_suspension"
	
	** relabel
	do "$raw/school_problems_suspension/school_problems_suspension-value-labels"
	
	rename PUBID_1997 ID 
	tolower
	
	ge susp = 0 
	
	forval i = 1/10 {
		
		local t = 1997 - 1 + `i'
		replace susp = 1 if ysch_5800_`t' == 1 

	}
	
	drop ysch_5800*
	save "$temp/Xvar_school_prb_susp", replace 

	*________________________________________________________
	
	* 08_3: Other = fight, truancy, victim1, victim2 
	
	clear
	infile using "$raw/school_problems_other/school_problems_other"
	
	** relabel
	do "$raw/school_problems_other/school_problems_other-value-labels"
	
	rename PUBID_1997 ID 
	tolower	
	
	* create vars
	ge fght 		= ysch_36100_1997 > 0 
	ge trnc 		= ysch_36200_1997 > 1 
	ge vctm_thrt = ysch_36000_1997 > 0 
	ge vctm_thft = ysch_35900_1997 > 0 

	drop ysch_* 
	save "$temp/Xvar_school_prb_other", replace 
	
	*________________________________________________________

	
	* merge vars "school problematic"
	
	use "$temp/Xvar_school_prb_rtnt", clear
	merge 1:1 id using "$temp/Xvar_school_prb_susp", nogen 
	merge 1:1 id using "$temp/Xvar_school_prb_other", nogen 

	save "$temp/var_school_prb", replace 