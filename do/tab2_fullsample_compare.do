** Table: Comparison of summary stats 
	
	use "$data/final_rep", clear	
	

	local vars "crim_vrty crim_prvl drpt yrs_last"
	local vars "`vars' male age race_whit race_blak race_othr race_hisp"
	local vars "`vars' live_both arrests smoke yrs_sex antisocial"
	local vars "`vars' gpa susp rtnt"
	local vars "`vars' asvab_ar asvab_wk asvab_pc asvab_mk"
	local vars "`vars' mom_drpt dad_drpt gov_aid upkeep_well upkeep_fair upkeep_poor"
	
	*Set yrs since dropout to missing for everdrpt=0, see p. 65 footnote a 
	bysort id: egen everdrpt = max(drpt)
	replace yrs_last = . if everdrpt == 0
	
	* Get means and SDs from my data 
	local j 1 
	foreach v in `vars' {
	
		qui su `v' [w=w] 
		
		* Round because only have 2 decimals for org numbers 
		local m = round(r(mean), .01)
		local sd = round(r(sd), .01)
		if r(min) == 0 & r(max) == 1 local sd = .
		
		if `j' == 1 { 
			mat rep_m = `m' 
			mat rep_sd = `sd'
		}
		else { 
			mat rep_m = rep_m \ `m'
			mat rep_sd = rep_sd \ `sd'
		}
		
		local ++j
	
	}
	
	* Get Number of obs. 
	su crim_vrty
	local N_uw = r(N)
	su crim_vrty [w=w] 
	local N_w = r(N) 
	unique id 
	local n = r(unique)	
	mat rep_N = (`N_uw', . \ `N_w' , . \ `n' , .)
	
	* Collect replication matrix 
	mat rep = (rep_m , rep_sd) \ rep_N
	
	
	* Means, SDs, and Ns from original paper 
	
	mat org_m = (	.35, .20, .11, 1.72, .51, 17.77, .72, .16, .12, .13, .54, ///
					.11, .42, 2.42, 1.76, 2.87, .32, .17, .03, .02, .03, .03, ///
					.16, .15, .35, .65, .27, .07)					
	mat org_sd = (	.85, ., ., 1.55, ., 2.38, ., ., ., ., ., .56, ., 2.75,	///
					1.66, .86, ., ., .90, .91, .91, .90, ., ., ., ., ., .)
	
	mat N_org = (45546 , . \ . , . \ 8112 , . )
	
	
	* Collect original paper matrix 
	mat org = (org_m' , org_sd') \ N_org
	
	* Differences in means 
	mat diff = (rep_m - org_m') \ (. \ . \ . )
	
	* Full table amtrix 
	
	mat full = rep, org , diff
	
	frmttable using "$dir/tab/tab2_fullsample_compare.tex", statmat(full)	replace fragment tex  	///
		rtitle("Crime variety" \ "Crime prevalence" \ "Dropout" \ 				///
				"Years since dropout" \ "Male" \ "Age" \ "White" \ "Black" \	///
				"Other race" \ "Hispanic" \ "Live with biological parents" \ 	///
				"Arrests" \	"Smoking prevalence" \ "Years sexually active" \	///
				"Antisocial peer scale" \ "Middle-school GPA" \					///
				"Ever suspended" \ "Ever retained" \ 							///
				"ASVAB: arithmetic reasoning" \ "ASVAB: word knowledge" \ 		///
				"ASVAB: paragraph comprehension" \ "ASVAB: math knowledge" \ 	///
				"Mother dropout" \ "Father dropout" \ "Received federal aid" \ 	///
				"Outside: nice" \ "Outside: fair" \ "Outside: poor" \			///
				"\textit{N} (Person waves unweighted)" \ 						///
				"\textit{N} (Person waves weighted)" \ 							///
				"\textit{N} (Individuals)")										///
		ctitle(	"", "Replication", "", "Original", "", "Differences in means" \ ///
				"", "Mean", "SD", "Mean", "SD")									///
		multicol(1,2,2;1,4,2;31,2,2;31,4,2;32,2,2;32,4,2;33,2,2;33,4,2)  		///
		sdec(2\2\2\2\2\2\2\2\2\2\2\2\2\2\2\2\2\2\2\2\2\2\2\2\2\2\2\2\0\0\0)		///
		hlines(1010000000000000000000000000001001)			
	
	