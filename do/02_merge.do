* Merge vars 
	use "$temp/data_delim", clear
	
	local files : dir "$temp" files "var_*"
	
	local j 1
	foreach file in `files' {
		
		merge 1:1 id using "$temp/`file'", keep(3) nogen 
	
	}
	
	save "$temp/data_merge", replace 