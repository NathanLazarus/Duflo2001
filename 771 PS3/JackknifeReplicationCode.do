use inpresdata, clear

// birthpl is district, the level of treatment assignment

rename (p608 p504thn p509pro nin recp ch71) (classwk birthyr birthprov n_inpres_schools high_inpres child_pop_71)

replace birthyr = birthyr + 1900

gen int year = 1995
gen byte age74 = 1974 - birthyr
gen byte old = age74 <= 17 & age74 >= 12
gen byte young = !old if (age74>=2 & age74 <= 6) | old  // young dummy missing outside of ages 2-6, 12-17, so will restrict samples
gen byte reallyold = age74 <= 24 & age74 >= 18


keep if !missing(lhwage)

// ivregress 2sls lhwage i.birthyr i.birthpl c.child_pop_71#i.birthyr (yeduc = young#c.n_inpres_schools) if (young == 1 | old == 1)
//
//
gen pool_old_birthyr = birthyr
replace pool_old_birthyr = 0 if birthyr <= 1961
// ivregress 2sls lhwage i.birthyr i.birthpl c.child_pop_71#i.birthyr (yeduc = i.pool_old_birthyr#c.n_inpres_schools)
//
//
//
// reghdfe yeduc young#c.n_inpres_schools if (young == 1 | old == 1), absorb(c.child_pop_71#i.birthyr birthyr birthpl)
// predict yeduc_hat_no_loo
//
// reghdfe lhwage yeduc_hat_no_loo if (young == 1 | old == 1), absorb(c.child_pop_71#i.birthyr birthyr birthpl)
//
//
//
// reghdfe yeduc i.pool_old_birthyr#c.n_inpres_schools, absorb(c.child_pop_71#i.birthyr birthyr birthpl)
// predict yeduc_hat_no_loo2
//
// reghdfe lhwage yeduc_hat_no_loo2, absorb(c.child_pop_71#i.birthyr birthyr birthpl)




//
//
// global n_obs = 100
//
levelsof pool_old_birthyr
foreach yr in `r(levels)' {
	cap drop n_inpres_schools_x_`yr'
	gen n_inpres_schools_x_`yr' = n_inpres_schools * (pool_old_birthyr == `yr')
}
//
// cap drop yeduc_hat
// gen yeduc_hat = .
// display "$S_TIME"
// forvalues i = 1/$n_obs {
// // 	if !missing(lhwage[i]) {
// 	// 	qui reghdfe yeduc i.pool_old_birthyr#c.n_inpres_schools if !missing(lhwage) & _n != `i', absorb(c.child_pop_71#i.birthyr birthyr birthpl)
// 		qui reghdfe yeduc n_inpres_schools_x_* if _n != `i', absorb(pool_old_birthyr birthpl)
// 		qui predict _yeduc_hat
// 		qui replace yeduc_hat = _yeduc_hat in `i'
// 		drop _yeduc_hat
// // 	}
// }
// display "$S_TIME"
//
// // reghdfe lhwage yeduc_hat, absorb(c.child_pop_71#i.birthyr birthyr birthpl)
//
// reg yeduc i.pool_old_birthyr i.birthpl n_inpres_schools_x_* // if _n != 1


// keep if _n <= 3000

keep if birthprov < 15 // 20

cap drop yeduc_hat
gen yeduc_hat = .
display "$S_TIME"
qui describe
forvalues i = 1/`r(N)' {
// 		qui reghdfe yeduc i.pool_old_birthyr#c.n_inpres_schools if !missing(lhwage) & _n != `i', absorb(c.child_pop_71#i.birthyr birthyr birthpl)
		qui reghdfe yeduc n_inpres_schools_x_* if _n != `i', absorb(pool_old_birthyr birthpl)
// 		qui reg yeduc n_inpres_schools_x_* if _n != `i'
		qui predict _yeduc_hat
		qui replace yeduc_hat = _yeduc_hat in `i'
		drop _yeduc_hat
}
display "$S_TIME"


reghdfe lhwage yeduc_hat, absorb(pool_old_birthyr birthpl)

qui reghdfe yeduc n_inpres_schools_x_*, absorb(pool_old_birthyr birthpl)
qui predict yeduc_hat_no_loo

reghdfe lhwage yeduc_hat_no_loo, absorb(pool_old_birthyr birthpl)


cap drop yeduc_hat2
gen yeduc_hat2 = .
display "$S_TIME"
qui describe
forvalues i = 1/300 {
// 		qui reghdfe yeduc i.pool_old_birthyr#c.n_inpres_schools if !missing(lhwage) & _n != `i', absorb(c.child_pop_71#i.birthyr birthyr birthpl)
		qui reg yeduc n_inpres_schools_x_* i.pool_old_birthyr i.birthpl if _n != `i'
// 		qui reg yeduc n_inpres_schools_x_* if _n != `i'
		qui predict _yeduc_hat
		qui replace yeduc_hat2 = _yeduc_hat in `i'
		drop _yeduc_hat
}
display "$S_TIME"

// reg yeduc i.pool_old_birthyr i.birthpl n_inpres_schools_x_* // if _n != 1




use inpresdata, clear

// birthpl is district, the level of treatment assignment

rename (p608 p504thn p509pro nin recp ch71) (classwk birthyr birthprov n_inpres_schools high_inpres child_pop_71)

replace birthyr = birthyr + 1900

gen int year = 1995
gen byte age74 = 1974 - birthyr
gen byte old = age74 <= 17 & age74 >= 12
gen byte young = !old if (age74>=2 & age74 <= 6) | old  // young dummy missing outside of ages 2-6, 12-17, so will restrict samples
gen byte reallyold = age74 <= 24 & age74 >= 18


keep if !missing(lhwage)

gen pool_old_birthyr = birthyr
replace pool_old_birthyr = 0 if birthyr <= 1961

levelsof pool_old_birthyr
foreach yr in `r(levels)' {
	cap drop n_inpres_schools_x_`yr'
	gen n_inpres_schools_x_`yr' = n_inpres_schools * (pool_old_birthyr == `yr')
}

cap drop yeduc_hat
gen yeduc_hat = .
display "$S_TIME"
forvalues i = 1/$n_obs {
		qui reghdfe yeduc i.pool_old_birthyr#c.n_inpres_schools if !missing(lhwage) & _n != `i', absorb(c.child_pop_71#i.birthyr birthyr birthpl)
// 		qui reg yeduc n_inpres_schools_x_* if _n != `i'
		qui predict _yeduc_hat
		qui replace yeduc_hat = _yeduc_hat in `i'
		drop _yeduc_hat
}
display "$S_TIME"



reghdfe lhwage yeduc_hat, absorb(c.child_pop_71#i.birthyr birthyr birthpl)

