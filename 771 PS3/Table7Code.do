use inpresdata, clear

// birthpl is district, the level of treatment assignment

rename (p608 p504thn p509pro nin recp ch71) (classwk birthyr birthprov n_inpres_schools high_inpres child_pop_71)

replace birthyr = birthyr + 1900

gen int year = 1995
gen byte age74 = 1974 - birthyr
gen byte old = age74 <= 17 & age74 >= 12
gen byte young = !old if (age74>=2 & age74 <= 6) | old
gen byte reallyold = age74 <= 24 & age74 >= 18


keep if !missing(lhwage)

ivregress 2sls lhwage i.birthyr i.birthpl c.child_pop_71#i.birthyr (yeduc = young#c.n_inpres_schools) if (young == 1 | old == 1)


gen pool_old_birthyr = birthyr
replace pool_old_birthyr = 0 if birthyr <= 1961
ivregress 2sls lhwage i.birthyr i.birthpl c.child_pop_71#i.birthyr (yeduc = i.pool_old_birthyr#c.n_inpres_schools)

