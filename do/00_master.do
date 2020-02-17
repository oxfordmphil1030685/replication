********************************************************************************
********************************************************************************

*	Title: 			Research Integrity and Transparency in Criminology:
*					A Replication Case Study of Sweeten et al. (2009). 
*				
*					Replication Project for the MPhil in Sociology and Demography
*					at the University of Oxford 
*			
*	Candidate no.:  1030685
*
*			
*	Github: 		https://github.com/oxfordmphil1030685
*
*			
*	Last edited: 	February 16, 2020 
*
*
*
********************************************************************************
********************************************************************************

********************************************************************************
********************************************************************************

* 	General notes:
* 
* 	This master .do-file runs all scripts used to construct the datasets as well
*	as analyses, tables, and figures used in the paper. The original datasets 
* 	are downloaded from the NLSY97 webpage after creating a free account. 
* 	
* 	The NLSY97 webpage: https://www.nlsinfo.org/content/getting-started/accessing-data
*	If you download the datasets manually from the webpage, you need to edit 
* 	the attached NLSY "value-label" .do files because some parts or normally 
* 	commented out.  
*
* 	I have uploaded all original datasets to the Github page provided above. 
*
*	You also need to install the following Stata packages to run all do files:
*	"tolower", "frmttable" 
*
*	This .do-file is organised in 4 sections: 
* 	Step 1 	unpacks datasets and clean variables 
*	Step 2 	merges all variables, reshapes the data, delimits the working sample
*			and saves two final versions of the data. 
*				a) "data_rep.dta" the replication dataset (i.e. waves 1 - 7)
*				b) "data_ext.dta" the extension dataset (i.e. waves 1-15)
*	Step 3: Contains verification analyses 
*	Step 4: Contains extension analyses 
*

********************************************************************************
********************************************************************************

	
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ * 
			
* PREAMBLE 

* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ * 
	

cls
clear all
set more off, perm 
set seed 10
set scheme s1color

glo dir 	"your directory here"										
glo raw 	"nlsy_raw folder path here"
glo data 	"$dir/data"
glo temp 	"$data/temp"
glo tab 	"$dir/tab"
glo fig		"$dir/fig"

shell rmdir "$temp" /s /q
shell rmdir "$data" /s /q
shell rmdir "$tab" 	/s /q
shell rmdir "$fig"	/s /q

mkdir "$temp"
mkdir "$data"
mkdir "$tab"
mkdir "$fig"	

* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ * 
			
* Step 01: CLEAN VARIABLES 

* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ * 
	
*** SAMPLE WEIGHTS (USING THE SAMPLING PANEL WEIGHTS)

		do "$dir/do/01_sample_weights"	
		
*** BACKGROUND COVARIATES
	
	* Age, sex, region, etc. 
	
		do "$dir/do/01_cov_background"
	
	
*** MAIN INDEPENDENT VARIABLES (DROPOUT, REASON DROPOUT, TIME SINCE ...)
		
	* Prepares the following vars: dropout, in high school 

		do "$dir/do/01_main_enroll"	
		
	* Years since dropout 
	
		do "$dir/do/01_main_yrslast"
	
*** DEPENDENT VARIABLES (VARIETY AND PREVALENCE MEASURES OF CRIME)
	
	* Criminal activity 

		do "$dir/do/01_dep_crim_actvty"
		
*** CRIME COVARIATES (ARRESTS)

	** Step 06: Add number of arrests 

		do "$dir/do/01_cov_arrests"
							
*** SCHOOL COVARIATES 
		
	* GPA  
	
		do "$dir/do/01_cov_school_gpa"
		
	* Problematic school behav

		do "$dir/do/01_cov_school_prb"

	* ASVAB
		
		do "$dir/do/01_cov_school_asvab"
		
	* Smoke 

		do "$dir/do/01_cov_smoke" 
		
	* Alcohol 

		do "$dir/do/01_cov_alcohol"
		
	* Years sexually active

		do "$dir/do/01_cov_sex"
		
	* 	Antisocial peer scale 

		do "$dir/do/01_cov_antisocial"

	
* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ * 
			
* Step 02: MERGE VARIABLES, DELIMIT ANALYTICAL SAMPLE, SAVE FINAL DATA 

* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ * 	

*** 2_1: Delimit: at least three adjacent cohorts 	// save: temp/data_delim

	do "$dir/do/02_delim_rni"							
	
*** 2_2: Merge vars 								// save: temp/data_merge
	
	do "$dir/do/02_merge"			
	
*** 2_3: Reshape wide to long						// save: temp/data_reshape
	
	do "$dir/do/02_reshape"
	
*** 2_4: Lag vars, drop missings, save final data 	// save: data/final_rep 
	
	do "$dir/do/02_final_rep"
	do "$dir/do/02_final_ext"


* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ * 
			
* Step 03: VERIFICATION DOFILES: REPRODUCE TABLES 

* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ * 	
	
	* Table 1: 	Sample Size and Proportion Enrolled in School 
	*			(Primary or Secondary) by Age and Wave 
		
		do "$dir/do/tab1_numbers"
		do "$dir/do/tab1_proportions"
		
	* Table 2: Compare samples 

		do "$dir/do/tab2_fullsample_compare"
		do "$dir/do/tab2_rep_allcolumns"
		
	* Table 5-6: Main estimation results from RE negative binomial and logit models
		* I think the me models might be sensitive to seed numbers etc ... 
		* therefore good idea to specify seed? 
		
		do "$dir/do/tab5_negbin_main"
		do "$dir/do/tab6_logit_main"
		do "$dir/do/tab56_logitnbin_main"
		
	** Tables 5-6 appendix: Logit and Neg. Bin. for all Subsamples
			
		do "$dir/do/tab56_logitnbin_appendix_subsamples.do"
			

* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ * 
* Step 04: EXTENSION DOFILES
'			

* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ * 	
	
	* Table: examining different weights/clusters/commands 
		
		do "$dir/do/tab_mext_w_cl"
				
	* Figures: Sensitivity - adding waves 

		do "$dir/do/fig_sensitivity_adding_waves_logit"
		do "$dir/do/fig_sensitivity_adding_waves_nbin"

	* Figures: Bootstrap 

		do "$dir/do/fig_bootstrap"
			
			
			
		
		