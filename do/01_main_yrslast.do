

*  YEARS SINCE DROPOUT 


use "$temp/Xvar_enroll", clear 
		
*** PREPARE: YRS SINCE LAST DROPOUT AND INTERVIEW DATE VARS 

	tempfile yrslast intv

		preserve 
		
			clear
			infile using "$raw/school_lastenroll/school_lastenroll"
			
			** relabel
			do "$raw/school_lastenroll/school_lastenroll-value-labels"
			
			rename PUBID_1997 ID
			tolower		
				
			replace ysch_1400_m = . if !inrange(ysch_1400_m, 1, 12) 
			replace ysch_1400_y = . if inlist(ysch_1400_y,-2,-4)
			
			ge lastenrol_ym = ym(ysch_1400_y, ysch_1400_m)
		
			drop ysch_1400_m ysch_1400_y
			
			save `yrslast', replace 
		restore 

		preserve 
		
			clear
			infile using "$raw/interview_dates/interview_dates"
			
			** relabel
			do "$raw/interview_dates/interview_dates-value-labels"
			
			rename PUBID_1997 ID 
			tolower		
			
			replace cv_interview_date_y_1997 = . if !inrange(cv_interview_date_y_1997, 1997, 1998) 
			replace cv_interview_date_m_1997 = . if !inrange(cv_interview_date_m_1997, 1, 12)
			
			ge interview_ym = ym(cv_interview_date_y_1997, cv_interview_date_m_1997)
			
			save `intv', replace 
		
		restore 	
	
		merge 1:1 id using `yrslast', keepus(lastenrol*) nogen 
		merge 1:1 id using `intv', keepus(interview_ym) nogen 
	
** WE ONLY NEED TO KNOW YRS SINCE LAST ENROLL AT FIRST WAVE 

	ge x = floor((interview_ym - lastenrol_ym) / 12)
	replace x = 0 if x == . 
	
***	NOW YRS SINCE LAST ENROLL 

	ge yrs_last_1 = x 

	forval i = 2/15 { 
		
		local j = `i' - 1 
		ge yrs_last_`i' = 0
		replace yrs_last_`i' = yrs_last_`j' + 1 if drpt_`i' == 1 
	
	}

	
	drop x lastenrol interview
	
	save "$temp/var_drpt_yrslast", replace 
	

	
