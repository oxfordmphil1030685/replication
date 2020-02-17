	* Table 1: 	Sample Size and Proportion Enrolled in School 
	*			(Primary or Secondary) by Age and Wave 
	
	use "$data/final_rep", clear 
	


	
	*** Matrix with numbers from org paper 
	
	mat org_1 = 1021 \ 1592 \ 1651 \ 1631 \ 1458 \ 534 \ 14 \ . \ . \ . \ . \ . \ 7901 
	mat org_2 = . \ 55 \ 1506 \ 1603 \ 1601 \ 1553 \ 1287 \ 112 \ . \ . \ . \ . \ 7717
	mat org_3 = . \ . \ 65 \ 1576 \ 1582 \ 1626 \ 1484 \ 1285 \ 76 \ . \ . \ .  \ 7694
	mat org_4 = . \ . \ . \ 26 \ 1455 \ 1599 \ 1519 \ 1474 \ 1281 \ 152 \ . \ . \ 7506
	mat org_5 = . \ . \ . \ . \ 27 \ 1474 \ 1546 \ 1495 \ 1481 \ 1259 \ 130 \ . \ 7412
	mat org_6 = . \ . \ . \ . \ . \ . \ 1459 \ 1515 \ 1504 \ 1476 \ 1236 \ 126  \ 7316 

	*** Matrix with numbers from my data 	
	
	su age
	local min = r(min)
	local max = r(max) 
	
	forval t = 1/6 { 
	
		forval a = `min' / `max' { 
			
			qui count if age == `a' & t == `t' 
			local c1 = r(N) 
			if r(N) == 0  local c1 = . 
			qui count if t == `t' 
			local c2 = r(N) 
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
	
	frmttable using "$dir/tab/tab1_numbers.tex", statmat(table1) tex replace fragment		///
		sdec(0,0,0,0,0,0,0,0,0,0,0,0) 												///	
		statfont(bf,rm, bf,rm, bf,rm, bf,rm, bf,rm, bf,rm, bf,rm) 					///
		ctitle("", "Wave 1", "", "Wave 2", "", "Wave 3", "", 						///
				"Wave 4", "", "Wave 5", "", "Wave 6" 								///
				\ "Age", "Rep", "Org", "Rep", "Org", "Rep", "Org", 					///
				"Rep", "Org", "Rep", "Org", "Rep", "Org")							///
		multicol(1,2,2; 1,4,2; 1,6,2; 1,8,2; 1,10,2; 1,12,2) 
		
