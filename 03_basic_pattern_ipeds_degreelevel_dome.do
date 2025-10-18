*******************************************
**** This file provides the descriptive figures.
**** Proportion of STEM degrees
**** Domestic Students
clear
global mypath "/Users/quentingao/Library/CloudStorage/Dropbox/OPT_起死回生局"
cd $mypath/dofile 





************** Domestic students
**** For Bechalor's and Associates' degree.
**** Run it if awlevel==3 or 5
preserve
use "/Users/quentingao/Library/CloudStorage/Dropbox/OPT_起死回生局/Raw_data/GraduationIPEDS.dta", clear
drop if year==2000|year==2001      // No data of foreign students
keep if majornum==1
gen alien = crace17 if year>=2002 & year<=2007
replace alien = cnralt if year>2007    // alien: number of confered degree to non-residence.
gen grand_total = crace24 if year>=2002 & year<=2007
replace grand_total = ctotalt      ///
if year>=2008              // grand_total: number of confered degree to all.
*** Generate Domestic students
gen domestic=grand_total-alien
keep if awlevel==3|awlevel==5     // Bachelor's or Associates.
collapse (sum) foreign=alien (sum) Total=grand_total (sum) domestic=domestic,  by(unitid year cipcode)
label variable foreign "Total foreign college graduates obtained degree "
label variable Total "Total college graduates obtained degree"
label variable domestic "Total domestic college gradautes obtaining degree"
gen share_foreign = foreign / Total
label variable share_foreign "The share of foreign college graduates obtained degree."
*** The proportion of foreign students; varies by cipcode. 
gen share_domestic=domestic/Total
save "/Users/quentingao/Library/CloudStorage/Dropbox/OPT_起死回生局/Raw_data/GraduationIPEDS_collapsed_dome_fore.dta", replace
restore



*** Merge with new STEM list.
preserve
use $mypath/Raw_data/GraduationIPEDS_collapsed_dome_fore.dta, clear
//drop _merge
merge m:1 cipcode using $mypath/Raw_data/STEM_CIP_merge_new.dta
gen stem_indicator=.
replace stem_indicator=1 if _merge==3
replace stem_indicator=0 if _merge!=3
drop if _merge==2   // Those in the STEM list but not in the main degree list.
save $mypath/Raw_data/GraduationIPEDS_STEMforfigure_new.dta, replace
restore

preserve
use $mypath/Raw_data/GraduationIPEDS_STEMforfigure_new.dta, clear
keep if stem_indicator==1
collapse (sum) domestic_stem=domestic, by(year)
save $mypath/dofile/Temp_data/new_fig_stem, replace 
restore

preserve
use $mypath/Raw_data/GraduationIPEDS_STEMforfigure_new.dta, clear
collapse (sum) domestic_all=domestic, by(year)
save $mypath/dofile/Temp_data/new_fig_all, replace 
restore

preserve
use $mypath/dofile/Temp_data/new_fig_stem, clear
merge 1:1 year using $mypath/dofile/Temp_data/new_fig_all
gen share_dome_stem = domestic_stem/domestic_all
drop if year<2002
twoway    ///
(function y=0.11, range(2008 2009) recast(area)  ///
	color(gs15) lcolor(gs15) base(0.0701))   ///
	(function y=0.11, range(2016 2017) recast(area)   ///
	color(gs15) lcolor(gs15) base(0.0701))   ///
(line share_dome_stem year, lcolor(blue)),  ///
xlabel(2002(1)2023, angle(45)) ytitle("Share of domestic STEM degrees") yline(0.07, lcolor(navy)) legend(off) 
graph export $mypath/BA_dome_stem_dome.png, as(png) replace 
restore
//
//
//
//
//
//
//
//
**** For Master's degree
preserve
use "/Users/quentingao/Library/CloudStorage/Dropbox/OPT_起死回生局/Raw_data/GraduationIPEDS.dta", clear
drop if year==2000|year==2001      // No data of foreign students
keep if majornum==1
gen alien = crace17 if year>=2002 & year<=2007
replace alien = cnralt if year>2007    // alien: number of confered degree to non-residence.
gen grand_total = crace24 if year>=2002 & year<=2007
replace grand_total = ctotalt      ///
if year>=2008              // grand_total: number of confered degree to all.
*** Generate Domestic students
gen domestic=grand_total-alien
keep if awlevel==7    // Master
collapse (sum) foreign=alien (sum) Total=grand_total (sum) domestic=domestic,  by(unitid year cipcode)
label variable foreign "Total foreign college graduates obtained degree "
label variable Total "Total college graduates obtained degree"
label variable domestic "Total domestic college gradautes obtaining degree"
gen share_foreign = foreign / Total
label variable share_foreign "The share of foreign college graduates obtained degree."
*** The proportion of foreign students; varies by cipcode. 
gen share_domestic=domestic/Total
save "/Users/quentingao/Library/CloudStorage/Dropbox/OPT_起死回生局/Raw_data/GraduationIPEDS_collapsed_dome_fore.dta", replace
restore



*** Merge with new STEM list.
preserve
use $mypath/Raw_data/GraduationIPEDS_collapsed_dome_fore.dta, clear
//drop _merge
merge m:1 cipcode using $mypath/Raw_data/STEM_CIP_merge_new.dta
gen stem_indicator=.
replace stem_indicator=1 if _merge==3
replace stem_indicator=0 if _merge!=3
drop if _merge==2   // Those in the STEM list but not in the main degree list.
save $mypath/Raw_data/GraduationIPEDS_STEMforfigure_new.dta, replace
restore

preserve
use $mypath/Raw_data/GraduationIPEDS_STEMforfigure_new.dta, clear
keep if stem_indicator==1
collapse (sum) domestic_stem=domestic, by(year)
save $mypath/dofile/Temp_data/new_fig_stem, replace 
restore

preserve
use $mypath/Raw_data/GraduationIPEDS_STEMforfigure_new.dta, clear
collapse (sum) domestic_all=domestic, by(year)
save $mypath/dofile/Temp_data/new_fig_all, replace 
restore
**** Run it if awlevel==7
preserve
use $mypath/dofile/Temp_data/new_fig_stem, clear
merge 1:1 year using $mypath/dofile/Temp_data/new_fig_all
gen share_dome_stem = domestic_stem/domestic_all
drop if year<2002
twoway    ///
(function y=0.11, range(2008 2009) recast(area)  ///
	color(gs15) lcolor(gs15) base(0.0401))   ///
(function y=0.11, range(2016 2017) recast(area)   ///
	color(gs15) lcolor(gs15) base(0.0401))   ///
(line share_dome_stem year, lcolor(black%40)), xlabel(2002(1)2023, angle(45)) ytitle("Share of domestic STEM degrees") yline(0.04, lcolor(navy)) legend(off)
graph export $mypath/MA_dome_stem_dome.png, as(png) replace 
restore
