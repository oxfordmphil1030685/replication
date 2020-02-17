*** Sensitivity Analysis: Adding Waves 
*** Neg. binomial model

* Define Macros 

	* Time-varying variables to be transformed (according to paper's appendix)

	glo tv "drpt yrs_last arrests smoke alcohol"	
	
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


	
	
local j 1 
forval S = 6/14 { 	
	preserve
	
		* Estimate model 
		 
		use "$data/final_ext", clear			
		keep if t <= `S'
		
		* Transform time-varying variables 
		
		foreach v of varlist $tv { 
		
			bysort id: egen M_`v' = mean(`v')
			ge D_`v' = `v' - M_`v'
			
		}
		
		* Rename essential time-varying vars to make it easier 
		rename D_drpt D1 
		rename M_drpt M1 	
		rename D_yrs D2
		rename M_yrs M2 	
		
		* Estimate model
		menbreg $y D1 M1 D2 M2 D_* M_* $tc t  || id:, pw(W) 
		mat a = r(table)' 
		if `j' == 1 mat d = (a[1..4, 1..6]) , (`S' \ `S' \ `S' \ `S') , (1 \ 2 \ 3 \ 4) 
		else mat d = d \ (a[1..4, 1..6]) , (`S' \ `S' \ `S' \ `S') , (1 \ 2 \ 3 \ 4)
		local ++j

		
	restore 
}


	* matrix with estimates from org paper 
		
	
	clear 
	svmat d
	rename (d1 d2 d3 d4 d5 d6 d7 d8) (b se z pv ll ul wave var)
	
	* append estimates from org paper 
	preserve 
		clear
		mat org =	(.661 , .199) 	///
				\	(.132 ,	.095)	///
				\ 	(-.296, .080)	///
				\	(-.108, .026)						 
		svmat org
		rename (org1 org2) (b se)
		ge z = b/se 
		ge pv = 2*(1-normal(abs(b / se))) 
		ge ll = b - 1.96 * se 
		ge ul = b + 1.96 * se 
		ge var = _n 
		ge Wave = -0.1
		tempfile org
		ge org = 1 
		save `org', replace 
	restore 
	ge org = 0 
	append using `org'
	
	ge varname = "" 
	replace varname = "Dropout between" if var == 1 
	replace varname = "Dropout within" if var == 2
	replace varname = "Yrs between" if var == 3
	replace varname = "Yrs within" if var == 4
	
	replace wave = wave-6
	
	format b se z pv ll ul %9.2fc

	lab define vals 0 "Original Waves (1-7)", replace
	forval j = 1/8 {
		local J = 7+`j'
		lab define vals `j' "Waves 1-`J'", modify
	}	
	lab val wave vals
	
	splitvallabels wave, length(8)
	gr tw 	rcap ll ul Wave if var == 1 & org == 1, lcol(blue)		///
		||	rcap ll ul wave if var == 1 & org == 0, lcol(black)		///
		||	sc b Wave if var == 1 & org == 1, mcol(blue) msym(T)	///
		||	sc b wave if var == 1 & org == 0, mcol(black)			///
		xlab(`r(relabel)') 											///	
		xtitle("")													///
		ytitle("")													///
		ylab(-.8(.4)2, angle(h)) yline(0, lpat(dash)) 				///
		legend(order(3 4) lab(3 "Original") lab(4 "Replication")	///
			pos(1) ring(0) col(1) region(lwidth(none)))  
	graph export "$dir/fig/snsvty_addwaves_drpt_bet_nbin.eps", replace 
	
	

	splitvallabels wave, length(8)
	gr tw 	rcap ll ul Wave if var == 2 & org == 1, lcol(blue)		///
		||	rcap ll ul wave if var == 2 & org == 0, lcol(black)		///
		||	sc b Wave if var == 2 & org == 1, mcol(blue) msym(T)	///
		||	sc b wave if var == 2 & org == 0, mcol(black)			///
		xlab(`r(relabel)') 											///	
		xtitle("")													///
		ytitle("")													///
		ylab(-.8(.4)2, angle(h)) yline(0, lpat(dash)) 				///
		legend(off)
	graph export "$dir/fig/snsvty_addwaves_drpt_wit_nbin.eps", replace 
		
	splitvallabels wave, length(8)
	gr tw 	rcap ll ul Wave if var == 3 & org == 1, lcol(blue)		///
		||	rcap ll ul wave if var == 3 & org == 0, lcol(black)		///
		||	sc b Wave if var == 3 & org == 1, mcol(blue) msym(T)	///
		||	sc b wave if var == 3 & org == 0, mcol(black)			///
		xlab(`r(relabel)') 											///	
		xtitle("")													///
		ytitle("")													///
		ylab(-.6(.2).4, angle(h)) yline(0, lpat(dash)) 				///
		legend(off)
	graph export "$dir/fig/snsvty_addwaves_yrs_bet_nbin.eps", replace 
	
	
	splitvallabels wave, length(8)
	gr tw 	rcap ll ul Wave if var == 4 & org == 1, lcol(blue)		///
		||	rcap ll ul wave if var == 4 & org == 0, lcol(black)		///
		||	sc b Wave if var == 4 & org == 1, mcol(blue) msym(T)    ///
		||	sc b wave if var == 4 & org == 0, mcol(black)			///
		xlab(`r(relabel)') 											///	
		xtitle("")													///
		ytitle("")													///
		ylab(-.6(.2).4, angle(h)) yline(0, lpat(dash)) 				///
		legend(off)
	graph export "$dir/fig/snsvty_addwaves_yrs_wit_nbin.eps", replace 	

	