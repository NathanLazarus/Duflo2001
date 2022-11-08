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

ivregress 2sls lhwage i.birthyr i.birthpl c.child_pop_71#i.birthyr (yeduc = young#c.n_inpres_schools) if (young == 1 | old == 1)


gen pool_old_birthyr = birthyr
replace pool_old_birthyr = 0 if birthyr <= 1961
ivregress 2sls lhwage i.birthyr i.birthpl c.child_pop_71#i.birthyr (yeduc = i.pool_old_birthyr#c.n_inpres_schools)



keep if birthprov < 15


ivregress 2sls lhwage i.birthyr i.birthpl c.child_pop_71#i.birthyr (yeduc = young#c.n_inpres_schools) if (young == 1 | old == 1)


ivregress 2sls lhwage i.birthyr i.birthpl c.child_pop_71#i.birthyr (yeduc = i.pool_old_birthyr#c.n_inpres_schools)


cap drop yeduc_hat
gen yeduc_hat = .
cap drop yeduc_hat_single_IV
gen yeduc_hat_single_IV = .
display "$S_TIME"
qui describe
global n_obs = `r(N)'
forvalues i = 1/$n_obs {
		qui reghdfe yeduc i.pool_old_birthyr#c.n_inpres_schools if _n != `i', absorb(c.child_pop_71#i.birthyr birthyr birthpl)
		qui predict _yeduc_hat
		if (young[`i'] == 1 | old[`i'] == 1) {
			qui reghdfe yeduc young#c.n_inpres_schools if _n != `i' & (young == 1 | old == 1), absorb(c.child_pop_71#i.birthyr birthyr birthpl)
			qui predict _yeduc_hat_single_IV
			qui replace yeduc_hat_single_IV = _yeduc_hat_single_IV in `i'
			drop _yeduc_hat_single_IV
		}
		qui replace yeduc_hat = _yeduc_hat in `i'
		drop _yeduc_hat
}
display "$S_TIME"

reghdfe lhwage yeduc_hat, absorb(c.child_pop_71#i.birthyr birthyr birthpl)
reghdfe lhwage yeduc_hat_single_IV, absorb(c.child_pop_71#i.birthyr birthyr birthpl)









qui reg lhwage c.child_pop_71#i.birthyr i.birthyr i.birthpl if (young == 1 | old == 1)
qui predict lhwage_resid, resid

qui reg yeduc c.child_pop_71#i.birthyr i.birthyr i.birthpl if (young == 1 | old == 1)
qui predict yeduc_resid, resid

cap drop young_x_n_inpres
gen young_x_n_inpres = young * n_inpres_schools
qui reg young_x_n_inpres c.child_pop_71#i.birthyr i.birthyr i.birthpl if (young == 1 | old == 1)
qui predict schools_resid, resid


cap drop yeduc_resid_po schools_resid_po lhwage_resid_po
gen yeduc_resid_po = .
gen schools_resid_po = .
gen lhwage_resid_po = .
display "$S_TIME"
forvalues i = 1/$n_obs {
	if (young[`i'] == 1 | old[`i'] == 1) {
			cap drop _yeduc_resid_po
			cap drop _schools_resid_po
			cap drop _lhwage_resid_po
			qui reg yeduc c.child_pop_71#i.birthyr i.birthyr i.birthpl if (young == 1 | old == 1) & _n != `i'
			qui predict _yeduc_resid_po, resid
			qui replace yeduc_resid_po = _yeduc_resid_po in `i'
			qui reg young_x_n_inpres c.child_pop_71#i.birthyr i.birthyr i.birthpl if (young == 1 | old == 1) & _n != `i'
			qui predict _schools_resid_po, resid
			qui replace schools_resid_po = _schools_resid_po in `i'
			qui reg lhwage c.child_pop_71#i.birthyr i.birthyr i.birthpl if (young == 1 | old == 1) & _n != `i'
			qui predict _lhwage_resid_po, resid
			qui replace lhwage_resid_po = _lhwage_resid_po in `i'
	}
}
display "$S_TIME"


cap drop yeduc_hat_single_IV_po
gen yeduc_hat_single_IV_po = .
forvalues i = 1/$n_obs {
		if (young[`i'] == 1 | old[`i'] == 1) {
			qui reg yeduc_resid_po schools_resid_po if _n != `i' & (young == 1 | old == 1)
			qui predict _yeduc_hat_single_IV_po
			qui replace yeduc_hat_single_IV_po = _yeduc_hat_single_IV_po in `i'
			drop _yeduc_hat_single_IV_po
		}
}

// reg lhwage_resid yeduc_resid if (young == 1 | old == 1)
reg lhwage_resid yeduc_hat_single_IV_po if (young == 1 | old == 1)
reghdfe lhwage yeduc_hat_single_IV, absorb(c.child_pop_71#i.birthyr birthyr birthpl)

// Replicate non-jackknife results with partialling out
qui reg yeduc_resid schools_resid if (young == 1 | old == 1)
qui predict yeduc_hat_single_IV_po_no_loo
reg lhwage_resid yeduc_hat_single_IV_po_no_loo