** Estimates all subsamples appendix 

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
	
	* Dependent var 

	glo y "crim_prvl"
	
	* Labels 
	
		label var D_drpt "Dropout (within-effect)"
		label var M_drpt "Dropout (between-effect)"
		label var D_yrs_last "Years since last dropout (within-effect)"
		label var M_yrs_last "Year since last dropout (between-effect)"
		
	* Estimate logit models 
	
		eststo m1, title("Total Sample"): melogit $y D_* M_* $tc t || id:, pw(W) 	
			su crim_vrty
			estadd scalar N_uw = r(N)
			su crim_vrty [w=w] 
			estadd scalar N_w = r(N) 
			unique id 
			estadd scalar n = r(unique)
			
		eststo m2, title("Males"): melogit $y D_* M_* $tc t if male == 1 || id:, pw(W) 	
			su crim_vrty if male == 1 
			estadd scalar N_uw = r(N)
			su crim_vrty [w=w] if male == 1 
			estadd scalar N_w = r(N) 
			unique id if male == 1 
			estadd scalar n = r(unique)		
		
		eststo m3, title("Females"): melogit $y D_* M_* $tc t if male == 0 || id:, pw(W) 	
			su crim_vrty if male == 0
			estadd scalar N_uw = r(N)
			su crim_vrty [w=w] if male == 0
			estadd scalar N_w = r(N) 
			unique id if male == 0
			estadd scalar n = r(unique)
	
	* Estimate negbin models 
	
	glo y "crim_vrty"
	
		eststo m4, title("Total Sample"): menbreg $y D_* M_* $tc t || id:, pw(W) 	
			su crim_vrty
			estadd scalar N_uw = r(N)
			su crim_vrty [w=w] 
			estadd scalar N_w = r(N) 
			unique id 
			estadd scalar n = r(unique)
			
		eststo m5, title("Males"): menbreg $y D_* M_* $tc t if male == 1 || id:, pw(W) 	
			su crim_vrty if male == 1 
			estadd scalar N_uw = r(N)
			su crim_vrty [w=w] if male == 1 
			estadd scalar N_w = r(N) 
			unique id if male == 1 
			estadd scalar n = r(unique)		
		
		eststo m6, title("Females"): menbreg $y D_* M_* $tc t if male == 0 || id:, pw(W) 	
			su crim_vrty if male == 0
			estadd scalar N_uw = r(N)
			su crim_vrty [w=w] if male == 0
			estadd scalar N_w = r(N) 
			unique id if male == 0
			estadd scalar n = r(unique)
					
	* Export negbin models 

	esttab m4 m5 m6 using "$dir/tab/tab5_nbin_allcols_app.tex", replace  booktabs 	///
		keep(D_drpt M_drpt D_yrs_last M_yrs_last) 									///
		order(D_drpt M_drpt D_yrs_last M_yrs_last) b(3) se(3) label					///
		nodep nonum mtitle 															///
		stats(N_uw N_w n, fmt(%9.0fc) label("\textit{N} (person waves unweighted)"	///
			"\textit{N} (person waves weighted)" "\textit{N} (individuals)") )	
		
	
	* Export logit models 
	esttab m1 m2 m3 using "$dir/tab/tab6_logit_allcols_app.tex", replace booktabs ///
		keep(D_drpt M_drpt D_yrs_last M_yrs_last) 									///
		order(D_drpt M_drpt D_yrs_last M_yrs_last) b(3) se(3) label					///
		nodep nonum mtitle 															///
		stats(N_uw N_w n, fmt(%9.0fc) label("\textit{N} (person waves unweighted)"	///
			"\textit{N} (person waves weighted)" "\textit{N} (individuals)") )	
		
