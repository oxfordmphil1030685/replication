	* Table 1b: Proportions here ... my best guess is that they use "inhs" dummy 
	** because numbers match pretty well .
		
	use "$data/final_rep", clear 
	

	* Table 1: 	Sample Size and Proportion Enrolled in School 
	*			(Primary or Secondary) by Age and Wave 
	
	*** Matrix with numbers from org paper 
	
	mat org_1 = .996 \ .992 \ .993 \ .982 \ .952 \ .891 \ .929 \ . \ . \ . \ . \ . \ .976
	mat org_2 = . \ .964 \ .953 \ .954 \ .923 \ .860 \ .443 \ .205 \ . \ . \ . \ . \ .832
	mat org_3 = . \ . \ 1.000 \ .965 \ .944 \ .856 \ .369 \ .086 \ .039 \ . \ . \ .  \ .667 
	mat org_4 = . \ . \ . \ .962 \ .930 \ .883 \ .414 \ .072 \ .019 \ .007 \ . \ . \ .473
	mat org_5 = . \ . \ . \ . \ .926 \ .889 \ .390 \ .074 \ .020 \ .013 \ .015 \ . \ .283 
	mat org_6 = . \ . \ . \ . \ . \ . \ .370 \ .057 \ .020 \ .009 \ .006 \ .000 \ .093 

	*** Matrix with numbers from my data 	
	
	su age
	local min = r(min)
	local max = r(max) 
	
	
	
	forval t = 1/6 { 
	
		forval a = `min' / `max' { 
			
			qui su inhs if age == `a' & t == `t' 
			local c1 = r(mean) 
			if r(N) == 0  local c1 = . 
			qui su inhs if t == `t'
			local c2 = r(mean) 
			if r(N) == 0  local c2 = .
			if `a' == `min' mat w_`t' = `c1'
			else mat w_`t' = w_`t' \ `c1' 
			if `a' == `max' mat w_`t' = w_`t' \ `c2'
			
		}	
		
	}


	* Combine matrices 
	
	matrix table1 = w_1 , org_1 , w_2 , org_2 , w_3 , org_3 , w_4 , org_4 , w_5 , org_5 , w_6 , org_6 
	
	* Matrix rownames 
	local names ""
	forval a = `min' / `max' { 
		local names "`names' `a'"
	}
	matrix rownames table1 = `names' "Total"
	
	frmttable, clear

	frmttable using "$dir/tab/tab1_proportions.tex", statmat(table1) tex replace fragment		///
		sdec(3,3,3,3,3,3,3,3,3,3,3,3) 												///	
		statfont(bf,rm, bf,rm, bf,rm, bf,rm, bf,rm, bf,rm, bf,rm) 					///
		ctitle("", "Wave 1", "", "Wave 2", "", "Wave 3", "", 						///
				"Wave 4", "", "Wave 5", "", "Wave 6" 								///
				\ "Age", "Rep", "Org", "Rep", "Org", "Rep", "Org", 					///
				"Rep", "Org", "Rep", "Org", "Rep", "Org")							///
		multicol(1,2,2; 1,4,2; 1,6,2; 1,8,2; 1,10,2; 1,12,2) 
		