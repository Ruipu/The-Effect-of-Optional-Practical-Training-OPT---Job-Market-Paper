*******************************************
**** This file provides the descriptive figures.
**** Descriptive figures CPS; Might not use
clear
global mypath "/Users/quentingao/Library/CloudStorage/Dropbox/OPT_起死回生局"
cd $mypath/dofile 


*********************************************
*** For outcome variable; Using the CPS||||||
*** Choice of STEM occupation; binary. 
// For U.S. citizen
preserve
use $mypath/Raw_data/CPS_regression_covariates.dta, clear
keep if asecwt!=.
keep if (educ==111|educ==092)&(age>=22&age<=25)
//sort year cpsidv
//by year cpsidv: drop if _n>1
gen myweight =.
replace myweight=asecwt if asecwt!=.
//replace myweight=wtfinl if wtfinl!=.
gen weight_stem =0
gen weight_nonstem=0
keep if citizen==1|citizen==2|citizen==3|citizen==4
replace weight_stem = myweight if occ_stem_indicator=="1"
replace weight_nonstem =myweight if occ_stem_indicator=="0"
collapse (sum) stem_num=weight_stem (sum) nonstem_num = weight_nonstem, by(year)
gen proportion_stem_us = stem_num/(nonstem_num+stem_num)
*drop if year>=2021
twoway ///
    (line proportion_stem_us year, lcolor(blue) lwidth(medium)), ///
    ytitle("Share in STEM Occupation") xtitle("Year") ///
    title("")  ylabel(0(0.1)0.4)   xlabel(2002(1)2023, angle(45))  ///
    graphregion(color(white)) yline(0.1, lcolor(navy))   
graph export $mypath/share_us_stem_job.png, as(png) replace 
save $mypath/dofile/Temp_data/usciti_stem_job, replace
restore
*************

// For Non-US Citizen
preserve
use $mypath/Raw_data/CPS_regression_covariates.dta, clear
keep if citizen==5
keep if asecwt!=.
keep if (educ==111|educ==092|educ==123)&(age>=22&age<=30)
//sort year cpsidv
//by year cpsidv: drop if _n>1
gen myweight =.
replace myweight=asecwt if asecwt!=.
//replace myweight=wtfinl if wtfinl!=.
gen weight_stem =0
gen weight_nonstem=0
replace weight_stem = myweight if occ_stem_indicator=="1"
replace weight_nonstem =myweight if occ_stem_indicator=="0"
collapse (sum) stem_num=weight_stem (sum) nonstem_num = weight_nonstem, by(year)
gen proportion_stem_nonus = stem_num/(nonstem_num+stem_num)
*drop if year>=2021
twoway ///
    (line proportion_stem_nonus year, lcolor(black%40) lwidth(medium)), ///
    ytitle("Share in STEM Occupation") xtitle("Year") ///
    title("")  ylabel(0(0.1)0.4) xlabel(2002(1)2023, angle(45))  ///
    graphregion(color(white))  yline(0.2, lcolor(navy))   
graph export $mypath/share_nonus_stem_job.png, as(png) replace 
save $mypath/dofile/Temp_data/nonusciti_stem_job, replace
restore

preserve
use $mypath/dofile/Temp_data/usciti_stem_job, clear
merge 1:1 year using $mypath/dofile/Temp_data/nonusciti_stem_job
twoway ///
	(function y=0.5, range(2008 2009) recast(area) color(gs14) lcolor() base(0))   ///
	(function y=0.5, range(2016 2017) recast(area) color(gs14) lcolor() base(0))   ///
    (line proportion_stem_us year, lcolor(black%40) lwidth(medium)) ///
    (line proportion_stem_nonus year, lcolor(blue%40) lwidth(medium)),  ///
    ytitle("Share in STEM Occupation") xtitle("Year") ///
    title("")  ylabel(0(0.05)0.5)    ///
    graphregion(color(white)) ///
	legend(order(3 4) label(3 "Domestic") label(4 "Foreign")           ///
	size(small) position(11))   ///
	xlabel(2000(2)2025, angle(45))
graph export $mypath/combinshare_stem_job.png, as(png) replace 
restore
*************

/*
preserve
use $mypath/Raw_data/CPS_regression_inflation.dta, clear
keep if (educ==111|educ==092)&(age>=22&age<=25)
sort year cpsidv
by year cpsidv: drop if _n>1
gen myweight =.
replace myweight=asecwt if asecwt!=.
replace myweight=wtfinl if wtfinl!=.
gen weight_stem =0
gen weight_nonstem=0
keep if citizen==1
replace weight_stem = myweight if occ_stem_indicator=="1"
replace weight_nonstem =myweight if occ_stem_indicator=="0"
egen mean = mean(weight_stem), by(year)
egen sd = sd(weight_stem), by(year)



gen upper = mean + sd 
gen lower = mean - sd 
set scheme s1color 
drop if year==2014
twoway   ///
(rarea upper lower year, color(red%20))  ///
(con mean year, lc(red%40))     
|| rcap upper lower year2 if tag & ind == 7, lc(blue) || scatter mean year2 if tag & ind == 7, mc(blue) ///
legend(order(2 "4" 4 "7")) xtitle("") xla(1976/1984) ytitle(Mean and SD of wage (units))
restore
*/





***********************************
***********************************
preserve 
use $mypath/dofile/Temp_data/usciti_stem_job,clear
replace stem_num=stem_num/1000000    // In 1k people.
replace nonstem_num=nonstem_num/1000000
//drop if year==2014
twoway      ///
(function y=1, range(2008 2011) recast(area) color(gs14) lcolor() base(0))   ///
(function y=1, range(2016 2019) recast(area) color(gs14) lcolor() base(0))   ///
(con stem_num year, lcolor(blue%50) mcolor(blue) yaxis(1))     ///
(con nonstem_num year, lcolor(red%50) mcolor(red) yaxis(2)),      ///
xlabel(2000(1)2020, angle(45))         ///
xtitle("")               /// 
ytitle("Number of domestic STEM jobs; 1 million", axis(1) size(vsmall))          ///
ytitle("Number of domestic non-STEM jobs; 1 million", axis(2) size(vsmall))    ///
ylabel(0 (0.2) 1, nogrid) graphregion(ifcolor(white)) plotregion(fcolor(white))    ///
legend(order(3 "STEM" 4 "non-STEM") ///
           size(small) ///
           position(6))
graph export $mypath/us_stem_job.png, as(png) replace 
restore





*** How about the wages?
*** For U.S. citizen
preserve
use $mypath/Raw_data/CPS_regression_covariates.dta, clear
keep if asecwt!=.
keep if citizen==1|citizen==2|citizen==3|citizen==4
keep if (educ==111|educ==092)&(age>=22&age<=25)
gen myweight =.
replace myweight=asecwt if asecwt!=.
//replace myweight=wtfinl if wtfinl!=.
gen weight_stem =0
gen weight_nonstem=0
replace weight_stem = myweight if occ_stem_indicator=="1"
replace weight_nonstem =myweight if occ_stem_indicator=="0"
gen wage_stem = incwage/1000 if occ_stem_indicator=="1"
gen wage_nonstem = incwage/1000 if occ_stem_indicator=="0"
collapse (mean) us_wage_stem=wage_stem (mean) us_wage_nonstem=wage_nonstem [pw=asecwt], by(year)
save $mypath/dofile/Temp_data/wageof_us, replace
twoway      ///
(function y=120, range(2008 2009) recast(area) color(gs14) lcolor() base(20))   ///
(function y=120, range(2016 2017) recast(area) color(gs14) lcolor() base(20))   ///
(line us_wage_stem year, lcolor(blue))   ///
(line us_wage_nonstem year, lcolor(black%40) ),    ///
xtitle("Year") ytitle("Average Wage Income")  ///
title("") legend(order(3 "STEM" 4 "Non-STEM") size(vsmall) position(6))    ///
ylabel(20(20)120) xlabel(2000(2)2025, angle(45))
graph export $mypath/us_wage.png, as(png) replace 
restore

*** For non U.S. citizen
preserve
use $mypath/Raw_data/CPS_regression_covariates.dta, clear
keep if asecwt!=.
keep if citizen==5
keep if (educ==111|educ==092|educ==123)&(age>=22&age<=30)
gen myweight =.
replace myweight=asecwt if asecwt!=.
//replace myweight=wtfinl if wtfinl!=.
gen weight_stem =0
gen weight_nonstem=0
replace weight_stem = myweight if occ_stem_indicator=="1"
replace weight_nonstem =myweight if occ_stem_indicator=="0"
gen wage_stem = incwage/1000 if occ_stem_indicator=="1"
gen wage_nonstem = incwage/1000 if occ_stem_indicator=="0"
collapse (mean) nonus_wage_stem=wage_stem (mean) nonus_wage_nonstem=wage_nonstem [pw=asecwt], by(year)
save $mypath/dofile/Temp_data/wageof_nonus, replace
twoway      ///
(function y=120, range(2008 2009) recast(area) color(gs14) lcolor() base(20))   ///
(function y=120, range(2016 2017) recast(area) color(gs14) lcolor() base(20))   ///
(line nonus_wage_stem year,lcolor(blue))   ///
(line nonus_wage_nonstem year, lcolor(black%40) ),    ///
xtitle("Year") ytitle("Average Wage Income")  ///
title("") legend(order(3 "STEM" 4 "Non-STEM") size(vsmall) position(6))    ///
ylabel(20(20)120) xlabel(2000(2)2025, angle(45))
graph export $mypath/nonus_wage.png, as(png) replace 

restore

*** Combine STEM/non-STEM; Foreign/Domestic
preserve
use $mypath/dofile/Temp_data/wageof_us, clear
merge 1:1 year using $mypath/dofile/Temp_data/wageof_nonus
label variable us_wage_stem "STEM wage for U.S. citizen"
label variable us_wage_nonstem "non-STEM wage for U.S. citizen"
label variable nonus_wage_stem "STEM wage for foreign"
label variable nonus_wage_nonstem "non-STEM wage for foreign"
twoway    ///
(function y=120, range(2008 2009) recast(area) color(gs14) lcolor() base(20))   ///
(function y=120, range(2016 2017) recast(area) color(gs14) lcolor() base(20))   ///
(line us_wage_stem year, lcolor(black%40) ) ///
(line us_wage_nonstem year, lcolor(black%40) lpattern(dash))    ///
(line nonus_wage_stem year, lcolor(blue) )      ///
(line nonus_wage_nonstem year, lcolor(blue) lpattern(dash)),     ///
legend(size(vsmall) position(6) rows(1))   ///
xlabel(2000(2)2023, angle(45))   ylabel(20(20)120)  ytitle("Wage in 1k")  xtitle("")  /// 
legend(order(3 4 5 6 ))
graph export $mypath/wage_allin.png, as(png) replace 
restore


/* CPS data, estimating the population of small special group of people is bad. 
*** For non-US citizen
preserve
use $mypath/Raw_data/CPS_regression_inflation.dta, clear
keep if (educ==111|educ==092)&(age>=22&age<=25)
sort year cpsidv
by year cpsidv: drop if _n>1
gen myweight =.
replace myweight=asecwt if asecwt!=.
replace myweight=wtfinl if wtfinl!=.
gen weight_stem =0
gen weight_nonstem=0
keep if citizen==5
replace weight_stem = myweight if occ_stem_indicator=="1"
replace weight_nonstem =myweight if occ_stem_indicator=="0"
collapse (sum) stem_num=weight_stem (sum) nonstem_num = weight_nonstem, by(year)
gen proportion_stem_nonus = stem_num/(nonstem_num+stem_num)
save nonciti_stem_job, replace
restore

preserve
use nonciti_stem_job, clear
replace stem_num=stem_num/1000
replace nonstem_num = nonstem_num/1000
drop if year==2014|year>=2021

gen stem_vsnonstem = stem_num/(stem_num+nonstem_num)*100

twoway   ///
(line stem_vsnonstem year)

twoway      ///
(function y=60, range(2008 2011) recast(area) color(gs14) lcolor() base(0))   ///
(function y=60, range(2016 2019) recast(area) color(gs14) lcolor() base(0))   ///
(con stem_num year,lcolor(green%50) mcolor(green) yaxis(1))    ///
(con nonstem_num year,lcolor(orange%50) mcolor(orange) yaxis(2)), ///
xlabel(2000(2)2020, angle(45))  xtitle("")               /// 
ytitle("Number of foreign STEM jobs; 1k", axis(1) size(vsmall))          ///
ytitle("Number of foreign non-STEM jobs; 1k", axis(2) size(vsmall))    ///
ylabel(0 (10) 60, axis(1)) ylabel(0(30)120, axis(2)) graphregion(ifcolor(white)) plotregion(fcolor(white))     ///
legend(order(3 "STEM" 4 "non-STEM") ///
           size(small) ///
           position(6))
graph export $mypath/foreign_stem_job.png, as(png) replace 
restore
/*
*/


*** Combining the choice of occupations of citizen and foreign.
preserve
use usciti_stem_job, clear
merge 1:1 year using nonciti_stem_job
label variable proportion_stem_us "U.S.citizens in STEM jobs"
label variable proportion_stem_nonus "non-U.S.citizens in STEM jobs"
twoway   ///
(function y=0.1, range(2008 2010) recast(area) color(gs14) lcolor() base(0))   ///
(function y=0.1, range(2011 2013) recast(area) color(gs14) lcolor() base(0))   ///
(function y=0.1, range(2016 2019) recast(area) color(gs14) lcolor() base(0))   ///
(line proportion_stem_us year if year>=2002, lcolor(blue) yaxis(1))   ///
(line proportion_stem_nonus year if year>=2002, lcolor(red) yaxis(2)),     ///
legend (order(4 5) size(vsmall) position(6) rows(1))  xtitle("") ytitle("Share of foreign STEM jobs", axis(2) size(vsmall))  ytitle("Share of domestic STEM jobs", axis(1) size(vsmall))   ///
xlabel(2002(2)2023, angle(45))
graph export $mypath/cps_stem_jobs.png, as(png) replace
restore
*/
