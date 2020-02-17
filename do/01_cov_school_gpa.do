* GPA 

	clear
	infile using "$raw/school_gpa/school_gpa"
	
	** relabel
	do "$raw/school_gpa/school_gpa-value-labels"
	
	rename PUBID_1997 ID
	tolower
	
	* Missing GPAs are imputed with sample average, see p. 69

	rename trans_crd_gpa_overall_hstr gpa
	
	ge miss_gpa = gpa < 0
	replace gpa = gpa / 100 
	su gpa if miss_gpa == 0 
	replace gpa = r(mean) if miss_gpa == 1 

	
	keep id gpa miss_gpa 
	save "$temp/var_school_gpa", replace 
