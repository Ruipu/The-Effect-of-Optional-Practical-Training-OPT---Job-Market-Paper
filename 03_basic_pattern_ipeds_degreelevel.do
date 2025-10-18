*******************************************
**** This file the proportion of STEM degrees of Foreign students
**** Foreign Students
clear
global mypath "/Users/quentingao/Library/CloudStorage/Dropbox/OPT_起死回生局"
cd $mypath/dofile

******************************************
**** Foreign Students. 

**** Bachelor and Associates' Degree.
preserve
use $mypath/Raw_data/GraduationIPEDS_STEMforfigure.dta, clear
//use $mypath/Raw_data/GraduationIPEDS_STEM_fips.dta, clear
keep if awlevel==5|awlevel==3 // Bachelor; Associates
gen alien = crace17 if year>=2002 & year<=2007
replace alien = cnralt   ///
if year>2007    // alien: number of confered degree to non-residence.
gen grand_total = crace24 if year>=2002 & year<=2007
replace grand_total = ctotalt     ///
if year>=2008 // grand_total: number of confered degree to all.
drop if stem_indicator!=1
collapse (sum) num_fore_stem=alien (sum) total_stem = grand_total, by(year)
tsset year
gen foreign_stem_ratio = num_fore_stem/total_stem
save $mypath/dofile/Temp_data/fore_stem, replace
restore
*** For non-STEM
preserve
use $mypath/Raw_data/GraduationIPEDS_STEMforfigure.dta, clear
keep if awlevel==5|awlevel==3    // Only for bachelor+associate degree
gen alien = crace17 if year>=2002 & year<=2007
replace alien = cnralt if year>2007    // alien: number of confered degree to non-residence.
gen grand_total = crace24 if year>=2002 & year<=2007
replace grand_total = ctotalt if year>=2008 // grand_total: number of confered degree to all.
keep if stem_indicator==0
collapse (sum) num_fore_nonstem=alien (sum) total_nonstem = grand_total, by(year)
gen non_stem_foreign_ratio = num_fore_nonstem/total_nonstem
save $mypath/dofile/Temp_data/foreign_nonstem, replace
restore
*** Merge!
preserve
use $mypath/dofile/Temp_data/fore_stem, clear
merge 1:1 year using $mypath/dofile/Temp_data/foreign_nonstem
label variable foreign_stem_ratio "STEM degrees to foreign students"
label variable non_stem_foreign_ratio "Non-STEM degrees to foreign students"
save $mypath/dofile/Temp_data/fore_stem_nonstem, replace
restore

*****Plot
preserve 
use $mypath/dofile/Temp_data/fore_stem_nonstem, clear
gen fore_stem_ratio_wrtfore=num_fore_stem/(num_fore_nonstem+num_fore_stem)
drop if year<2002
twoway ///
	(function y=0.3, range(2008 2009) recast(area)  ///
	color(gs15) lcolor(gs15) base(0.08))   ///
	(function y=0.3, range(2016 2017) recast(area)   ///
	color(gs15) lcolor(gs15) base(0.08))   ///
	(function y=0.1, range(2002 2023) ///
	lcolor(navy) lpattern(dash))      ///
    (line fore_stem_ratio_wrtfore year, lcolor(blue) yaxis(1)), ///
    ylabel(0.08(0.02)0.30) ///
    legend (off)   xtitle("year")  ///
	ytitle("Share of STEM Degrees; Foreign Students")    ///
	xlabel(2002(1)2023, angle(45))
graph export $mypath/BA_fore_stem_all_fore.png, as(png) replace
restore
//
//
//
//
//
//
//
//

*****************************************************************
**** Foreign for master degree
**** Bachelor and Associates' Degree.
preserve
use $mypath/Raw_data/GraduationIPEDS_STEMforfigure.dta, clear
//use $mypath/Raw_data/GraduationIPEDS_STEM_fips.dta, clear
keep if awlevel==7     // Master
gen alien = crace17 if year>=2002 & year<=2007
replace alien = cnralt   ///
if year>2007    // alien: number of confered degree to non-residence.
gen grand_total = crace24 if year>=2002 & year<=2007
replace grand_total = ctotalt     ///
if year>=2008 // grand_total: number of confered degree to all.
drop if stem_indicator!=1
collapse (sum) num_fore_stem=alien (sum) total_stem = grand_total, by(year)
tsset year
gen foreign_stem_ratio = num_fore_stem/total_stem
save $mypath/dofile/Temp_data/fore_stem, replace
restore
*** For non-STEM
preserve
use $mypath/Raw_data/GraduationIPEDS_STEMforfigure.dta, clear
keep if awlevel==7         // Master
gen alien = crace17 if year>=2002 & year<=2007
replace alien = cnralt if year>2007    // alien: number of confered degree to non-residence.
gen grand_total = crace24 if year>=2002 & year<=2007
replace grand_total = ctotalt if year>=2008 // grand_total: number of confered degree to all.
keep if stem_indicator==0
collapse (sum) num_fore_nonstem=alien (sum) total_nonstem = grand_total, by(year)
gen non_stem_foreign_ratio = num_fore_nonstem/total_nonstem
save $mypath/dofile/Temp_data/foreign_nonstem, replace
restore
*** Merge!
preserve
use $mypath/dofile/Temp_data/fore_stem, clear
merge 1:1 year using $mypath/dofile/Temp_data/foreign_nonstem
label variable foreign_stem_ratio "STEM degrees to foreign students"
label variable non_stem_foreign_ratio "Non-STEM degrees to foreign students"
save $mypath/dofile/Temp_data/fore_stem_nonstem, replace
restore

*****Plot
preserve 
use $mypath/dofile/Temp_data/fore_stem_nonstem, clear
gen fore_stem_ratio_wrtfore=num_fore_stem/(num_fore_nonstem+num_fore_stem)
drop if year<2002
twoway ///
	(function y=0.4, range(2008 2009) recast(area) color(gs14) lcolor() base(0.1))   ///
	(function y=0.4, range(2016 2017) recast(area) color(gs14) lcolor() base(0.1))   ///
    (line fore_stem_ratio_wrtfore year, lcolor(black%40) yaxis(1)) ///
	(function y=0.15, lcolor(navy) range(2002 2023) lpattern(dash)),   ///
    ylabel(0.1(0.02)0.4) ///
    legend (off)   xtitle("year")   ///
	ytitle("Share of STEM Degrees; Foreign Students")    ///
	xlabel(2002(1)2023, angle(45))
graph export $mypath/MA_fore_stem_all_fore.png, as(png) replace
restore

