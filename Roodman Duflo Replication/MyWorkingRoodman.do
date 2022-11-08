use inpresdata, clear
replace birthpl = p509pro * 100 + p509kab
ren (p608 p504thn p509pro) (classwk birthyr birthprov)
gen occ = .
replace urban = .  // place of residence, not birth
gen byte relate = .

gen birthlat = .
gen birthlong = .
recode p607 (11 12 13 14 15 16 17 18 = 10) (21 22 23 24 25 26 = 20) ///  // recode to IPUMS INDGEN
			(31 32 33 34 35 36 37 38 39 = 30) (41=40) (42 43=40) (51 52=50) (61 62=60 ) (63 64 = 70) ///
			(71 72 73 74 75 = 80) (81 82 = 90) (83=111) (91=100) (92=40) (93=114) ///
			(94=114) (96=120) (98=999) (99=0), gen(indgen)

ren weight wt
replace birthyr = birthyr + 1900
gen int year = 1995

// keep  year relate urban yeduc birthyr wt indgen occ birthpl birthprov classwk lwage lhwage birthlat birthlong
order year relate urban yeduc birthyr wt indgen occ birthpl birthprov classwk lwage lhwage birthlat birthlong
compress
// append using SUPAS05 SAKERNAS10 SUSENAS1314

cap drop dum
gen int dum = cond(birthyr<1962, 1900+100, birthyr) 
gen byte age74 = 1974 - birthyr
gen byte old = age74 <= 17 & age74 >= 12
gen byte young = !old if (age74>=2 & age74 <= 6) | old  // young dummy missing outside of ages 2-6, 12-17, so will restrict samples
gen byte reallyold = age74 <= 24 & age74 >= 18
gen byte part = lhwage<. | (year==2005 & classwk==4)  // labor force participation
gen byte primary = yeduc>=6  // completed primary school
gen byte poor = inlist(birthprov, 33, 34, 35, 53, 72, 73, 74, 81, 82) & mod(birthpl, 100) < 70  // Poor dummy, Duflo (2001), table 6, note b

recode birthpl (1472=1403) (1804=1803) (3275=3219) (5171=5103) (5271=5201) (7173=7103) (7271=7203) (8271=8203) (8104=8103), gen(birthplnew) // group new child regencies with parents
replace birthpl = 7204 if birthpl==7271  // Duflo recoding

merge m:1 birthpl using "Public/Regency-level vars/Regency-level vars.dta", nogen update

bysort birthplnew: gen byte samp = _n==1
reg totinnew ch71new if samp
predict recpnew if totinnew<., resid
replace recpnew = recpnew > 0 if recpnew<.
drop samp

xtset birthplnew

//   regress lhwage c.age74##c.age74##c.age74##c.age74##(birthpl occ indgen urban) [aw=wt] if year==1995 // imputation regression
//   est save Public\Output\IS, replace
//   predict double IS if part  // Income Score

label var yeduc "Years of education"
label var primary "Finished primary school"
label var part "Formal employment"
label var lwage "Log monthly wages"
label var lhwage "Log hourly wage"
//   label var IS "Imputed log hourly wage"
// end data prep


***
*** cross-survey, regency-level correlations in key variables
***
// {
// preserve
// gen _year = cond(year<2013, year, 2014)
// collapse ninnew ch71new en71new pop71new year part yeduc primary lhwage lwage IS (rawsum) wt [aw=wt] if young<., by(young birthplnew _year)
// gen _lwage = cond(inlist(year,1995,2010), lhwage, cond(year==2005, IS, lwage))
// reshape wide ninnew ch71new en71new pop71new year part yeduc primary lhwage lwage IS _lwage wt, i(birthplnew young) j(_year)
//
// foreach depvar in primary yeduc part lhwage IS lwage _lwage {
//   graph matrix `depvar'*, scheme(plotplain) msym(Oh) msize(tiny) name(mat`depvar', replace)
//   graph matrix `depvar'*, scheme(plotplain) msym(Oh) msize(tiny) name(matby`depvar', replace) by(young)
//   pwcorr `depvar'*
//   bysort young: pwcorr `depvar'*
// }
// restore
// }

***
*** replicate most of original
***

// preserve
keep if age74>=2 & age74<=24 & year==1995
xtset birthpl

* Table 3: DID
reg yeduc  young##recp                    if lhwage<. [aw=wt]
reg lhwage young##recp                                [aw=wt]
ivregress 2sls lhwage young recp (yeduc = young#recp) [aw=wt], small  // correct Wald DID estimator

reg yeduc  old##recp                              if (reallyold | old) & lhwage<. [aw=wt]
reg lhwage old##recp                              if  reallyold | old             [aw=wt]
ivregress 2sls lhwage old recp (yeduc = old#recp) if  reallyold | old             [aw=wt], small
