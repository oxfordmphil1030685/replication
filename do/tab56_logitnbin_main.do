** Table 5 and 6 "Full sample"-part from org. paper 
	
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

	glo y "crim_vrty"
	
	
	
	* Estimate model 

	menbreg $y D_* M_* $tc t || id:, pw(W)
	
	* Matrix with estimates, standard errors, z-values 
	
		mat rep_bet = 	(_b[M_drpt], _se[M_drpt]) 	///
					\	( _b[M_yrs_last], _se[M_yrs_last]) 
		mat rep_wit = 	(_b[D_drpt], _se[D_drpt])		///
					\	(_b[D_yrs_last], _se[D_yrs_last])
		
	* Matrix with significance stars 
	
		local pv1 = 2*(1-normal(abs(_b[M_drpt] / _se[M_drpt])))
		local star1 = 0 
		if `pv1' < .05 local star1 = 1
		if `pv1' < .01 local star1 = 2 
		if `pv1' < .001 local star1 = 3 
		
		local pv2 = 2*(1-normal(abs(_b[M_yrs_last] / _se[M_yrs_last])))
		local star2 = 0 
		if `pv2' < .05 local star2 = 1
		if `pv2' < .01 local star2 = 2 
		if `pv2' < .001 local star2 = 3 	
			
		mat rep_bet_stars = (0,`star1') \ (0,`star2')
		
		local pv1 = 2*(1-normal(abs(_b[D_drpt] / _se[D_drpt])))
		local star1 = 0 
		if `pv1' < .05 local star1 = 1
		if `pv1' < .01 local star1 = 2 
		if `pv1' < .001 local star1 = 3 
		
		local pv2 = 2*(1-normal(abs(_b[D_yrs_last] / _se[D_yrs_last])))
		local star2 = 0 
		if `pv2' < .05 local star2 = 1
		if `pv2' < .01 local star2 = 2 
		if `pv2' < .001 local star2 = 3 		
		
		mat rep_wit_stars = (0,`star1') \ (0,`star2')
	
	* Matrix with N 
		
		mat rep_n = (e(N), .) \ (e(N_clust), .)
		
	* Matrices with original estimates, SEs, z-values, stars 	
		
		mat org_bet = (.569, .137 ) ///
					\ (-.231, .057)
					
		mat org_bet_stars = (0,2) \ (0,2) 			
		
		mat org_wit = (.044, .057) ///
					\ (-.037, .026) 

		mat org_wit_stars = (0,0) \ (0,0) 
		
		mat org_n = (45546,  .) \ (8112, .)	
	
	* Collect matrices 
	
					
		mat nbin_full = (rep_bet , org_bet , rep_wit , org_wit)  
		mat nbin_stars = (rep_bet_stars, org_bet_stars, rep_wit_stars, org_wit_stars)

		
***** Logit 
	
	
	* Table 5: Main logit regression table 
	
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
	
	
	
	* Estimate model 

	melogit $y D_* M_* $tc t || id:, pw(W)
	
	* Matrix with estimates, standard errors, z-values 
	
		mat rep_bet = 	(_b[M_drpt], _se[M_drpt]) 	///
					\	( _b[M_yrs_last], _se[M_yrs_last]) 
		mat rep_wit = 	(_b[D_drpt], _se[D_drpt])		///
					\	(_b[D_yrs_last], _se[D_yrs_last])
		
	* Matrix with significance stars 
	
		local pv1 = 2*(1-normal(abs(_b[M_drpt] / _se[M_drpt])))
		local star1 = 0 
		if `pv1' < .05 local star1 = 1
		if `pv1' < .01 local star1 = 2 
		if `pv1' < .001 local star1 = 3 
		
		local pv2 = 2*(1-normal(abs(_b[M_yrs_last] / _se[M_yrs_last])))
		local star2 = 0 
		if `pv2' < .05 local star2 = 1
		if `pv2' < .01 local star2 = 2 
		if `pv2' < .001 local star2 = 3 	
			
		mat rep_bet_stars = (0,`star1') \ (0,`star2')
		
		local pv1 = 2*(1-normal(abs(_b[D_drpt] / _se[D_drpt])))
		local star1 = 0 
		if `pv1' < .05 local star1 = 1
		if `pv1' < .01 local star1 = 2 
		if `pv1' < .001 local star1 = 3 
		
		local pv2 = 2*(1-normal(abs(_b[D_yrs_last] / _se[D_yrs_last])))
		local star2 = 0 
		if `pv2' < .05 local star2 = 1
		if `pv2' < .01 local star2 = 2 
		if `pv2' < .001 local star2 = 3 		
		
		mat rep_wit_stars = (0,`star1') \ (0,`star2')
	
	* Matrix with N 
		
		mat rep_n = (e(N), .) \ (e(N_clust), .)
		
	* Matrices with original estimates, SEs, z-values, stars 	
		
		mat org_bet = (.661, .199 ) ///
					\ (-.296, .080)
					
		mat org_bet_stars = (0,2) \ (0,2) 			
		
		mat org_wit = (.132, .095) ///
					\ (-.108, .042) 

		mat org_wit_stars = (0,0) \ (0,1) 
		
		mat org_n = (45546,  .) \ (8112, .)	
	
	* Collect matrices 
	
					
		mat logit_full = (rep_bet , org_bet , rep_wit , org_wit) 
		mat logit_stars = (rep_bet_stars, org_bet_stars, rep_wit_stars, org_wit_stars)
		mat N = (rep_n , org_n , rep_n , org_n) 
		
*** COLLECT ALL 

		mat miss = (. , . , . , . , . , . , . , . )
		mat full = miss \ nbin_full \ miss \ logit_full \ N
		mat nulls = (0, 0, 0, 0, 0, 0, 0, 0)
		mat stars = nulls \ nbin_stars \ nulls \ logit_stars 
		
	frmttable, clear 
	frmttable using "$dir/tab/tab56_logitnbin_main.tex", 								///
		statmat(full) replace fragment tex 												///
		annotate(stars) asymbol(*,**,***)												///
		ctitle("","Between-Effects","","","","Within-Effects","","","" 					///
			\ "","Replication","","Original","","Replication","","Original",""			///
			\ "","Coef.","SE","Coef.","SE", "Coef.","SE", "Coef.","SE")					///
		rtitle(	"\textit{Negative Binomial RE Model}" \ 								///
				"\hspace{1em} Dropout" \ "\hspace{1em} Years since dropout" \ 			///
				"\textit{Logistic RE Model}" \ 											///
				"\hspace{1em} Dropout" \ "\hspace{1em} Years since dropout" \			///
				"\textit{N} (person-waves)" \ 	"\textit{N} (individuals)")				///	
		multicol(1,2,4; 1,6,4; 2,2,2; 2,4,2; 2,6,2; 2,8,2; 								///
			10,2,2; 10,4,2; 10,6,2; 10,8,2; 11,2,2; 11,4,2; 11,6,2; 11,8,2) 			///
		sdec(3\3\3\3\3\3\0) statfont(bf,bf,rm,rm,bf,bf,rm) hlines(100100000101)
		
			
		
		
		
		
