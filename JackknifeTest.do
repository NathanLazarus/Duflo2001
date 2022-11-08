import delim "ivexample.csv", clear

cap drop x_hat
cap drop _yeduc_hat
gen x_hat = .
display "$S_TIME"
qui describe
global n_obs = `r(N)'
forvalues i = 1/$n_obs {
	qui reg x z if _n != `i'
	qui predict _x_hat
	qui replace x_hat = _x_hat in `i'
	drop _x_hat
}
display "$S_TIME"
qui reg x z
predict x_hat_no_loo

reg y x
reg y x_hat
reg y x_hat_no_loo
