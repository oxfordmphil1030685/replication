* Bootstrap 

forval i = 1/800 {	
	
	di "`i' of 1000"
	
	qui { 
		use "$data/final_rep", clear
		tempname uniform 
		gen `uniform' = uniform() 
		bysort id: replace `uniform' = `uniform'[1] 
		drop if `uniform' < .1 
		
		
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
		
			mat rep_bet = 	(_b[M_drpt], _se[M_drpt] , _b[M_yrs_last], _se[M_yrs_last]) 
			mat rep_wit = 	(_b[D_drpt], _se[D_drpt] , _b[D_yrs_last], _se[D_yrs_last])
			
		
		* Collect matrices 

			
			if `i' == 1 mat data = rep_bet , rep_wit , `i'
			else mat data = data \ rep_bet , rep_wit , `i'
		
		}
		
		
}	


* Save matrix 
clear
svmat data
rename data* d*
rename (d1 d2 d3 d4 d5 d6 d7 d8 d9) (bB_drpt seB_drpt bB_yrs seB_yrs bW_drpt seW_drpt bW_yrs seW_yrs i)
drop i 

** Between-Effects: Dropout Variable 

rename (bB_drpt seB_drpt) (b se)
sort b
ge i = _n

ge ll = b - 1.96 * se
ge ul = b+ 1.96 * se

ge b_org = .661 
ge se_org = .199 
ge ll_org = b_org - 1.96 * se_org 
ge ul_org = b_org + 1.96 * se_org
ge i_org = 785 

ge x = 0
ge z = . 

format x z b ll ul b_org ll_org ul_org  %9.2fc 

gr tw rspike ll ul i, lcol(black*.2)								///
	||	sc b i, msize(tiny) msym(Oh) mcol(black) 					///
	||	sc b_org i_org,  msym(O) mcol(red) 							///
	|| 	line x i, lpat(dash) lcol(red)								///
	||	sc z i, msym(O) mcol(black)									///
	|| 	rspike ll_org ul_org i_org, lcol(red)						///
	ylab(-0.5(.5)1.5, angle(h)) 									///
	xtit("Trial number") 											///
	legend(order(5 3) lab(5 "Simulation estimates")					///
		lab(3 "Original estimate") pos(11) ring(0) c(1)				///
		region(lwidth(none)))
graph export "$dir/fig/simulation_between_drpt.eps", replace 
		
		
rename (b se) (bB_drpt seB_drpt)
drop i ul ll *_org x z

* Within-Effects: Dropout variable

rename (bW_drpt seW_drpt) (b se)
sort b
ge i = _n

ge ll = b - 1.96 * se
ge ul = b+ 1.96 * se

ge b_org = .132 
ge se_org = .095 
ge ll_org = b_org - 1.96 * se_org 
ge ul_org = b_org + 1.96 * se_org
ge i_org = 80 

ge x = 0
ge z = . 

format x z b ll ul b_org ll_org ul_org  %9.2fc 

gr tw rspike ll ul i, lcol(black*.2)								///
	||	sc b i, msize(tiny) msym(Oh) mcol(black) 					///
	||	sc b_org i_org,  msym(O) mcol(red) 							///
	|| 	line x i, lpat(dash) lcol(red)								///
	||	sc z i, msym(O) mcol(black)									///
	|| 	rspike ll_org ul_org i_org, lcol(red)						///
	ylab(-0.5(.5)1.5, angle(h)) 									///
	xtit("Trial number") 											///
	legend(off)
graph export "$dir/fig/simulation_within_drpt.eps", replace 