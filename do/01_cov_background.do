*** Background covariates

** Prepare interview dates  

	clear
	infile using "$raw/interview_dates/interview_dates"
	
	do "$raw/interview_dates/interview_dates-value-labels"
	
	rename PUBID_1997 ID  
	tolower
		
	rename (cv_interview_date_y_* cv_interview_date_m_*) (y_* m_*)
	
	forval i = 1/15 { 
	
		local t = 1997 - 1 + `i' 
		
		replace y_`t' = . if y_`t' == -5 
		replace m_`t' = . if m_`t' == -5 
		
		ge ym_`i' = ym(y_`t', m_`t') 
	
	}
	
	keep id ym_*
	
	tempfile ym 
	save `ym', replace 
	
** Unpack background variables
	
	clear 
	infile using "$raw/background/background" 
	
	do "$raw/background/background-value-labels" 

	rename PUBID_1997 ID 
	tolower 
	rename r1482600 race
	rename r0538200 dwelling
	rename r0536401 bdate_m 
	rename r0536402 bdate_y 
	rename r0536300 sex 

** Merge interview dates 

	merge 1:1 id using `ym', nogen 
	
	
** Age 
	ge b_ym = ym(bdate_y, bdate_m)
	
	forval i = 1/15 { 
			
		ge age_`i' = floor((ym_`i' - b_ym) / 12)
		ge agesq_`i' = age_`i' * age_`i'
		
		
	}
	
	drop ym* b_ym bdate* 

	
** Race dummies  
	
	ge race_whit = race == 4 
	ge race_blak = race == 1 
	ge race_hisp = race == 2
	ge race_othr = race == 3

	drop race

** Male dummy 
	
	ge male = sex == 1 
	drop sex
	
** Region dummies 
 
	ge reg_nc = cv_census_region_1997 == 2 
	ge reg_ne = cv_census_region_1997 == 1 
	ge reg_w  = cv_census_region_1997 == 4 
	ge reg_s  = cv_census_region_1997 == 3 
	
	drop cv_census_region_1997
	
** Mom/Dad High-school dropout (two variables)
	
	ge mom_drpt = inrange(cv_hgc_bio_mom,1,11) | inrange(cv_hgc_res_mom,1, 11)
	ge dad_drpt = inrange(cv_hgc_bio_dad,1,11) | inrange(cv_hgc_res_dad,1,11)
	
	drop cv_hgc*
	
** Mom was teen at first child birth dummy 

	* teen mom 12-19 years old 
	* some report even younger than that at first age 
	* and some invalid skips (-3) 
	
	ge mom_teen= inrange(cv_bio_mom_age_child1_1997, 12, 18) 
	drop cv_bio_mom
	
** Received gov assistance dummy

	ge gov_aid = p3_137_1997 == 1 
	drop p3_137_1997

** Dwelling type dummies 

	* 1 = HOUSE: "1 house", "2 condominium/townhouse/rowhouse" 
	* 2 = APARTMENT : "3 Apartment", "4 Flat" 
	* 3 = OTHER 
	// Note 2 obs. under "don't know" - have put these under other.
	ge dwelling_type = 3 
	replace dwelling_type = 1 if inrange(dwelling, 1,2)
	replace dwelling_type = 2 if inrange(dwelling, 3,4)
	
	ge dwel_house = dwelling_type == 1 
	ge dwel_apart = dwelling_type == 2 
	ge dwel_other = dwelling_type == 3 
	
	drop dwelling dwelling_type 
	
** Dwelling upkeep dummies
	
		ge upkeep_well = yir == 1
		ge upkeep_fair = yir == 2
		ge upkeep_poor = yir == 3
		ge upkeep_unknown = upkeep_well + upkeep_fair + upkeep_poor == 0 
		
		drop yir 

** Youth lives with both biological parents 

	ge live_both_bio = youth_bothbio_01_1997 == 1  
	drop youth_bothbio_01_1997 
	
** Save data 
	save "$temp/var_background", replace 
	
	