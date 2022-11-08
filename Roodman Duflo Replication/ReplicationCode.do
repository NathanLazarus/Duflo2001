use inpresdata, clear

// birthpl is district, the level of treatment assignment

rename (p608 p504thn p509pro nin recp) (classwk birthyr birthprov n_inpres_schools high_inpres)

replace birthyr = birthyr + 1900

gen int year = 1995
gen byte age74 = 1974 - birthyr
gen byte old = age74 <= 17 & age74 >= 12
gen byte young = !old if (age74>=2 & age74 <= 6) | old  // young dummy missing outside of ages 2-6, 12-17, so will restrict samples
gen byte reallyold = age74 <= 24 & age74 >= 18

/* This generates the means of education and wages in low and high
program regions in table 3*/

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
