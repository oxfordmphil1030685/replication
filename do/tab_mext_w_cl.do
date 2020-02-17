***** Table with different specifications of models, weights, clusters
***** Logit 

	use "$data/final_rep", clear
	
	
	* Transform time-varying variables 
	glo tv "drpt yrs_last arrests smoke alcohol"	
	
	foreach v of varlist $tv { 
	
		bysort id: egen M_`v' = mean(`v')
		ge D_`v' = `v' - M_`v'
		
	}
	
	* Constant vars 
	
	glo tc "miss_enroll inhs male age agesq yrs_sex"
	glo tc "$tc race_blak race_othr race_hisp reg_nc reg_ne reg_w"
	glo tc "$tc susp rtnt gpa miss_gpa"
	glo tc "$tc vctm_thrt fght trnc"
	glo tc "$tc vctm_thft asvab_ar asvab_wk asvab_pc asvab_mk"
	glo tc "$tc miss_asvab mom_teen live_both mom_drpt dad_drpt"
	glo tc "$tc gov_aid antisocial dwel_apart dwel_other"
	glo tc "$tc upkeep_fair upkeep_poor"	
	
	* Labels 
		label var D_drpt "Dropout \\ (within-effect)"
		label var M_drpt "Dropout \\ (between-effect)"
		label var D_yrs_last "Years since \\ last dropout \\ (within-effect)"
		label var M_yrs_last "Year since \\ last dropout \\ (between-effect)"
	
	* Dependent var 

	glo y "crim_prvl"
	
	* Merge househould id variable (HHid)
	
		preserve
			clear
			infile using "$raw/HHid/HHid"
			do "$raw/HHid/HHid-value-labels"
			
			rename (PUBID SIDCODE) (id HHid)
			
			tempfile hh 
			save `hh', replace 
		restore
		
	merge m:1 id using `hh', keep(1 3) nogen
	
	* Estiamte models 
	
	* main 
	eststo main: melogit $y D_* M_* $tc t || id:, pw(W) 
		estadd local command "me"
		estadd local weights "Probabilty"
		estadd local se "Individual"
	
	eststo me_pw_hh: melogit $y D_* M_* $tc t || id:, pw(W) vce(cl HHid) 	
		estadd local command "me"
		estadd local weights "Probabilty"
		estadd local se "Household"
	
	eststo me_iw_id: melogit $y D_* M_* $tc t || id:, iw(W) 	
		estadd local command "me"
		estadd local weights "Importance"
		estadd local se "Individual"	
	
	eststo me_iw_hh: melogit $y D_* M_* $tc t || id:, iw(W) vce(cl HHid) 
		estadd local command "me"
		estadd local weights "Importance"
		estadd local se "Household"	
	
	eststo me_nw_id: melogit $y D_* M_* $tc t || id: 	
		estadd local command "me"
		estadd local weights "None"
		estadd local se "Individual"
	
	eststo me_nw_hh: melogit $y D_* M_* $tc t || id:, vce(cl HHid) 	
		estadd local command "me"
		estadd local weights "None"
		estadd local se "Household"
	
	eststo xt_nw: xtlogit $y D_* M_* $tc t, re 
		estadd local command "xt"
		estadd local weights "None"
		estadd local se "None"
		
	eststo xt_nw_id: xtlogit $y D_* M_* $tc t, re vce(cl id)
		estadd local command "xt"
		estadd local weights "None"
		estadd local se "Individual"
		
	eststo xt_nw_hh: xtlogit $y D_* M_* $tc t, re vce(cl HHid)
		estadd local command "xt"
		estadd local weights "None"
		estadd local se "Household"	

	eststo xt_iw: xtlogit $y D_* M_* $tc t [iw=W], re 
		estadd local command "xt"
		estadd local weights "Importance"
		estadd local se "None"	
	
	esttab main me* xt* using "$dir/tab/tab_mext_w_cl.tex", replace booktabs		///
		keep(D_drpt M_drpt D_yrs_last M_yrs_last) 									///
		order(D_drpt M_drpt D_yrs_last M_yrs_last) 									///
		b(3) se(3) nodep nomtit noobs label	compress								///
		stats(command weights se, label("Stata command" "Weights" "SE Cluster"))
	