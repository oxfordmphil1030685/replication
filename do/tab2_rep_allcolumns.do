* Descriptive stats table similar to table2
	use "$data/final_rep", clear
	
	label var crim_vrty "Crime variety"
	label var crim_prvl "Crime prevalence" 
	label var drpt "Dropout"
	label var yrs_last "Years since dropout"
	label var male "Male"
	label var age "Age"
	label var race_whit "White"
	label var race_blak "Black"
	label var race_othr "Other race"
	label var race_hisp "Hispanic" 
	label var live_both "Live with biological parents" 
	label var arrests "Arrests" 
	label var smoke "Smoking prevalence" 
	label var yrs_sex "Years sexually active" 
	label var antisocial "Antisocial peer scale" 
	label var gpa "Middle-school GPA"
	label var susp "Ever suspended"
	label var rtnt "Ever retained" 
	label var asvab_ar "ASVAB: arithmetic reasoning" 
	label var asvab_wk "ASVAB: word knowledge" 
	label var asvab_pc "ASVAB: paragraph comprehension"
	label var asvab_mk "ASVAB: math knowledge"	
	label var mom_drpt "Mother dropout"
	label var dad_drpt "Father dropout"
	label var gov_aid "Received federal aid"
	label var upkeep_well "Outside: nice"
	label var upkeep_fair "Outside: fair"
	label var upkeep_poor "Outside: poor"
		
	local vars "crim_vrty crim_prvl drpt yrs_last"
	local vars "`vars' male age race_whit race_blak race_othr race_hisp"
	local vars "`vars' live_both arrests smoke yrs_sex antisocial"
	local vars "`vars' gpa susp rtnt"
	local vars "`vars' asvab_ar asvab_wk asvab_pc asvab_mk"
	local vars "`vars' mom_drpt dad_drpt gov_aid upkeep_well upkeep_fair upkeep_poor"
	
	bysort id: egen everdrpt = max(drpt) 
	
	
	*Set yrs since dropout to missing for everdrpt=0, see p. 65 footnote a 
	replace yrs_last = . if everdrpt == 0
	
	eststo m1: estpost sum `vars' [w=w]
		su crim_vrty
		estadd scalar N_uw = r(N)
		su crim_vrty [w=w] 
		estadd scalar N_w = r(N) 
		unique id 
		estadd scalar n = r(unique)

	eststo m2: estpost sum `vars' [w=w] if male==1
		su crim_vrty if male == 1 
		estadd scalar N_uw = r(N)
		su crim_vrty [w=w] if male == 1 
		estadd scalar N_w = r(N) 
		unique id if male == 1 
		estadd scalar n = r(unique)
	
	
	eststo m3: estpost sum `vars' [w=w] if male==0
		su crim_vrty if male == 0
		estadd scalar N_uw = r(N)
		su crim_vrty [w=w] if male == 0
		estadd scalar N_w = r(N) 
		unique id if male == 0
		estadd scalar n = r(unique)
		
	eststo m4: estpost sum `vars' [w=w] if everdrpt==1
		su crim_vrty if everdrpt == 1
		estadd scalar N_uw = r(N)
		su crim_vrty [w=w] if everdrpt == 1 
		estadd scalar N_w = r(N) 
		unique id if everdrpt == 1 
		estadd scalar n = r(unique)
	
	eststo m5: estpost sum `vars' [w=w] if everdrpt==0
		su crim_vrty if everdrpt == 0
		estadd scalar N_uw = r(N)
		su crim_vrty [w=w] if everdrpt == 0
		estadd scalar N_w = r(N) 
		unique id if everdrpt == 0
		estadd scalar n = r(unique)
	
	esttab m1 m2 m3 m4 m5 using "$dir/tab/tab2_allcolumns_rep.tex", replace 	///
		cell((mean(fmt(%9.2f) label(" ")) sd(par fmt(%9.2f) label(" ")))) 		///
		noobs l nonumber scalars("N_uw \textit{N} (Person waves unweighted)" 	///
		"N_w \textit{N} (Person waves weighted)" "n \textit{N} (Individuals)")	///
		sfmt(%9.0fc %9.0fc %9.0fc) compress booktabs							///
		mtit("Total Sample" "Males" "Females" "Ever Dropout" "Never Dropout")
	
