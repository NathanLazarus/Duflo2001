use inpresdata, clear

// birthpl is district, the level of treatment assignment

rename (p608 p504thn p509pro nin recp) (classwk birthyr birthprov n_inpres_schools high_inpres)

replace birthyr = birthyr + 1900

gen int year = 1995
gen byte age74 = 1974 - birthyr
gen byte old = age74 <= 17 & age74 >= 12
gen byte young = !old if (age74>=2 & age74 <= 6) | old  // young dummy missing outside of ages 2-6, 12-17, so will restrict samples
gen byte reallyold = age74 <= 24 & age74 >= 18

/* first, look at means of education and wages in low and high
program regions*/

/*Experiment of interest*/

/*education*/
sum yeduc if lhwage !=. & young == 1 & high_inpres == 1 [w=weight]
sum yeduc if lhwage !=. &  young == 1 & high_inpres==0 [w=weight]
sum yeduc if lhwage !=. & old == 1  & high_inpres == 1 [w=weight]
sum yeduc if lhwage !=. &  old == 1  & high_inpres==0 [w=weight]

/*wage*/
sum lhwage if lhwage !=. & young == 1 & high_inpres == 1 [w=weight]
sum lhwage if lhwage !=. &  young == 1 & high_inpres==0 [w=weight]
sum lhwage if lhwage !=. & old == 1  & high_inpres == 1 [w=weight]
sum lhwage if lhwage !=. &  old == 1  & high_inpres==0 [w=weight]

/*Placebo experiment*/

/*education*/
sum yeduc if lhwage !=. & reallyold == 1 & high_inpres == 1 [w=weight]
sum yeduc if lhwage !=. &  reallyold == 1 & high_inpres==0 [w=weight]
sum yeduc if lhwage !=. & old == 1  & high_inpres == 1 [w=weight]
sum yeduc if lhwage !=. &  old == 1  & high_inpres==0 [w=weight]

/*wage*/
sum lhwage if lhwage !=. & reallyold == 1 & high_inpres == 1 [w=weight]
sum lhwage if lhwage !=. &  reallyold == 1 & high_inpres==0 [w=weight]
sum lhwage if lhwage !=. & old == 1  & high_inpres == 1 [w=weight]
sum lhwage if lhwage !=. &  old == 1  & high_inpres==0 [w=weight]

cap gen high_inpres_x_young=high_inpres*young
cap gen high_inpres_x_old=high_inpres*old

/* 2x2 DiD */

/*Experiment of interest*/

reg yeduc young high_inpres high_inpres_x_young  [w=weight] if lhwage !=. & (young == 1 | old == 1)
reg lhwage young high_inpres high_inpres_x_young  [w=weight] if lhwage !=. & (young == 1 | old == 1)

/*Placebo experiment*/

reg yeduc old high_inpres high_inpres_x_old  [w=weight]  if (old == 1 | reallyold == 1) & lhwage !=.
reg lhwage old high_inpres high_inpres_x_old  [w=weight]  if (old == 1 | reallyold == 1) & lhwage !=.

cap drop *avg_ed*
bys birthpl: egen _avg_educ_old = mean(yeduc) if (old == 1 | reallyold == 1)
bys birthpl: egen avg_educ_old = min(_avg_educ_old)
gen avg_educ_bin = floor(avg_educ_old)
sum avg_educ_bin if high_inpres == 1
local highest_overlap = r(max)
sum avg_educ_bin if high_inpres == 0
local lowest_overlap = r(min)

keep if avg_educ_bin >= `lowest_overlap' & avg_educ_bin <= `highest_overlap' & (young == 1 | old == 1) & !missing(lhwage)

forvalues i=`=`lowest_overlap' + 1'/`highest_overlap' {
	gen avg_educ_bin_`i' = avg_educ_bin == `i'
	qui sum avg_educ_bin_`i'
	gen avg_educ_bin_recentered_`i' = avg_educ_bin_`i' - r(mean)
	gen avg_educ_bin_high_`i' = (avg_educ_bin == `i') * high_inpres
	qui sum avg_educ_bin_high_`i' if high_inpres == 1
	gen avg_educ_bin_recentered_high_`i' = (high_inpres == 1) * (avg_educ_bin_high_`i' - r(mean))
	gen avg_educ_bin_young_`i' = (avg_educ_bin == `i') * young
	qui sum avg_educ_bin_young_`i' if young == 1
	gen avg_educ_bin_recentered_young_`i' = (young == 1) * (avg_educ_bin_young_`i' - r(mean))
	gen avg_educ_bin_tr_`i' = (avg_educ_bin == `i') * high_inpres * young
	qui sum avg_educ_bin_tr_`i' if (high_inpres == 1 & young == 1)
	gen avg_educ_bin_recentered_tr_`i' = (high_inpres == 1 & young == 1) * (avg_educ_bin_tr_`i' - r(mean))
}

// reg yeduc young high_inpres high_inpres_x_young avg_educ_bin_high_* avg_educ_bin_young_* avg_educ_bin_recentered_tr* [w=weight] if avg_educ_bin>=`lowest_overlap' & avg_educ_bin <= `highest_overlap' & !missing(lhwage) & (young == 1 | old == 1)

reg yeduc young high_inpres high_inpres_x_young avg_educ_bin_recentered* [w=weight] if avg_educ_bin>=`lowest_overlap' & avg_educ_bin <= `highest_overlap' & !missing(lhwage) & (young == 1 | old == 1)


reg lhwage young high_inpres high_inpres_x_young avg_educ_bin_recentered* [w=weight] if avg_educ_bin>=`lowest_overlap' & avg_educ_bin <= `highest_overlap' & !missing(lhwage) & (young == 1 | old == 1)


// reg yeduc young high_inpres high_inpres_x_young avg_educ_bin_recentered* [w=weight] if avg_educ_bin==`lowest_overlap' & (young == 1 | old == 1)
// reg yeduc young high_inpres high_inpres_x_young avg_educ_bin_recentered* [w=weight] if avg_educ_bin==`highest_overlap'& (young == 1 | old == 1)
// reg yeduc young high_inpres high_inpres_x_young avg_educ_bin_recentered* [w=weight] if avg_educ_bin>=`lowest_overlap' & avg_educ_bin <= `highest_overlap'
// reg lhwage young high_inpres high_inpres_x_young avg_educ_bin_recentered* [w=weight] if avg_educ_bin>=`lowest_overlap' & avg_educ_bin <= `highest_overlap'
//
// reg yeduc (young high_inpres high_inpres_x_young)##i.avg_educ_bin


global n_obs = 10000

cap drop yeduc_hat
gen yeduc_hat = .
display "$S_TIME"
forvalues i = 1/$n_obs {
	qui reg yeduc young high_inpres high_inpres_x_young [w=weight] if _n != `i'
	qui predict _yeduc_hat
	qui replace yeduc_hat = _yeduc_hat in `i'
	drop _yeduc_hat
}
display "$S_TIME"


reg yeduc young high_inpres high_inpres_x_young [w=weight] if !missing(lhwage) & (young == 1 | old == 1)
predict yeduc_hat_no_loo

reg lhwage young high_inpres high_inpres_x_young [w=weight] if !missing(lhwage) & (young == 1 | old == 1)

reg lhwage yeduc_hat_no_loo [w=weight] if !missing(lhwage) & (young == 1 | old == 1)
