# delimit;

set matsize 400;
cap log close;
log using log/table7.log, replace;
*use supa2, clear;
use inpresdata, clear;
cap gen poor=0;
replace poor=1 if
(p509pro==33 |
p509pro==34 |
p509pro==35 |
p509pro==53 |
p509pro==72 |
p509pro==73 |
p509pro==74 |
p509pro==81 |
p509pro==82)
& p509kab<70;


* education;

quietly anova yeduc birthpl p504th p504th*ch71 p504th*en71 nin*treat2b if (treat1b==1|treat2b==1), cont(nin ch71 en71);
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat2b[1]];
display "S.E    " _se[nin*treat2b[1]];

quietly anova yeduc birthpl p504th p504th*ch71 p504th*en71 nin*treat2b if (treat1b==1|treat2b==1) & dens71<308,
 cont(nin ch71 en71);
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat2b[1]];
display "S.E    " _se[nin*treat2b[1]];

quietly anova yeduc birthpl p504th p504th*ch71 p504th*en71 nin*treat2b if (treat1b==1|treat2b==1) & dens71>308
& dens71 !=.,
 cont(nin ch71 en71);
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat2b[1]];
display "S.E    " _se[nin*treat2b[1]];


quietly anova yeduc birthpl p504th p504th*ch71 p504th*en71 nin*treat2b if (treat1b==1|treat2b==1) & poor==1,
 cont(nin ch71 en71);
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat2b[1]];
display "S.E    " _se[nin*treat2b[1]];

quietly anova yeduc birthpl p504th p504th*ch71 p504th*en71 nin*treat2b if (treat1b==1|treat2b==1) & poor==0,
 cont(nin ch71 en71);
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat2b[1]];
display "S.E    " _se[nin*treat2b[1]];


quietly anova yeduc birthpl p504th p504th*ch71 p504th*en71 nin*treat2b if (treat1b==1|treat2b==1) & moldyed<6.97,
 cont(nin ch71 en71);
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat2b[1]];
display "S.E    " _se[nin*treat2b[1]];

quietly anova yeduc birthpl p504th p504th*ch71 p504th*en71 nin*treat2b if (treat1b==1|treat2b==1) & moldyed>6.97
& moldyed !=.,
 cont(nin ch71 en71);
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat2b[1]];
display "S.E    " _se[nin*treat2b[1]];

* lhwage;

quietly anova lhwage birthpl p504th p504th*ch71 p504th*en71 nin*treat2b if (treat1b==1|treat2b==1), cont(nin ch71 en71);
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat2b[1]];
display "S.E    " _se[nin*treat2b[1]];

quietly anova lhwage birthpl p504th p504th*ch71 p504th*en71 nin*treat2b if (treat1b==1|treat2b==1) & dens71<308,
 cont(nin ch71 en71);
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat2b[1]];
display "S.E    " _se[nin*treat2b[1]];

quietly anova lhwage birthpl p504th p504th*ch71 p504th*en71 nin*treat2b if (treat1b==1|treat2b==1) & dens71>308
& dens71 !=.,
 cont(nin ch71 en71);
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat2b[1]];
display "S.E    " _se[nin*treat2b[1]];


quietly anova lhwage birthpl p504th p504th*ch71 p504th*en71 nin*treat2b if (treat1b==1|treat2b==1) & poor==1,
 cont(nin ch71 en71);
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat2b[1]];
display "S.E    " _se[nin*treat2b[1]];

quietly anova lhwage birthpl p504th p504th*ch71 p504th*en71 nin*treat2b if (treat1b==1|treat2b==1) & poor==0,
 cont(nin ch71 en71);
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat2b[1]];
display "S.E    " _se[nin*treat2b[1]];


quietly anova lhwage birthpl p504th p504th*ch71 p504th*en71 nin*treat2b if (treat1b==1|treat2b==1) & moldyed<6.97,
 cont(nin ch71 en71);
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat2b[1]];
display "S.E    " _se[nin*treat2b[1]];

quietly anova lhwage birthpl p504th p504th*ch71 p504th*en71 nin*treat2b if (treat1b==1|treat2b==1) & moldyed>6.97
& moldyed !=.,
 cont(nin ch71 en71);
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat2b[1]];
display "S.E    " _se[nin*treat2b[1]];



log off;


*use supa2, clear;
use inpresdata, clear;

cap gen poor=0;
replace poor=1 if
(p509pro==33 |
p509pro==34 |
p509pro==35 |
p509pro==53 |
p509pro==72 |
p509pro==73 |
p509pro==74 |
p509pro==81 |
p509pro==82)
& p509kab<70;
keep if lhwage !=.;
keep birthpl ch71 en71 nin wsppc lhwage yeduc dum p504thn dens moldyed poor;
quietly tab birthpl, gen(ROB);
quietly tab p504thn, gen(year);
quietly tab dum, gen(dum);
for X in var dum1-dum12 \ Y in any ndum1 ndum2 ndum3 ndum4 ndum5 ndum6 ndum7 ndum8 ndum9 ndum10 ndum11 ndum12:
gen Y=X*nin;
for X in var year1-year23 \ Y in any cYOB1 cYOB2 cYOB3 cYOB4 cYOB5 cYOB6 cYOB7
 cYOB8 cYOB9 cYOB10 cYOB11 cYOB12 cYOB13 cYOB14  cYOB15 cYOB16 cYOB17 cYOB18 cYOB19 cYOB20 cYOB21 cYOB22 cYOB23:
gen Y=X*ch71;
for Z in var year1-year23 \ Y in any eYOB1 eYOB2 eYOB3 eYOB4 eYOB5 eYOB6 eYOB7
 eYOB8 eYOB9 eYOB10 eYOB11 eYOB12 eYOB13 eYOB14  eYOB15 eYOB16 eYOB17 eYOB18 eYOB19 eYOB20 eYOB21 eYOB22 eYOB23:
gen Y = Z*en71;
for X in var year1-year23 \ Y in any wYOB1 wYOB2 wYOB3 wYOB4 wYOB5 wYOB6 wYOB7
 wYOB8 wYOB9 wYOB10 wYOB11 wYOB12 wYOB13 wYOB14  wYOB15 wYOB16 wYOB17 wYOB18 wYOB19 wYOB20 wYOB21 wYOB22 wYOB23:
gen Y=X*wsppc;


log on;


quietly reg lhwage yeduc year1-year23 ROB1-ROB290 cYOB1-cYOB23 eYOB1-eYOB23 (year1-year23 ROB1-ROB290 cYOB1-cYOB23
ndum1 ndum2 ndum3 ndum4 ndum5 ndum6 ndum7 ndum8 ndum9 ndum10 ndum11 ndum12 eYOB1-eYOB23) if dens<308;
display "coeff X= " _b[yeduc];
display "se X= " _se[yeduc];


quietly reg lhwage yeduc year1-year23 ROB1-ROB290 cYOB1-cYOB23 eYOB1-eYOB23 (year1-year23 ROB1-ROB290 cYOB1-cYOB23
ndum1 ndum2 ndum3 ndum4 ndum5 ndum6 ndum7 ndum8 ndum9 ndum10 ndum11 ndum12 eYOB1-eYOB23) if dens>308;
display "coeff X= " _b[yeduc];
display "se X= " _se[yeduc];

quietly reg lhwage yeduc year1-year23 ROB1-ROB290 cYOB1-cYOB23 eYOB1-eYOB23 (year1-year23 ROB1-ROB290 cYOB1-cYOB23
ndum1 ndum2 ndum3 ndum4 ndum5 ndum6 ndum7 ndum8 ndum9 ndum10 ndum11 ndum12 eYOB1-eYOB23) if poor==1;
display "coeff X= " _b[yeduc];
display "se X= " _se[yeduc];


quietly reg lhwage yeduc year1-year23 ROB1-ROB290 cYOB1-cYOB23 eYOB1-eYOB23 (year1-year23 ROB1-ROB290 cYOB1-cYOB23
ndum1 ndum2 ndum3 ndum4 ndum5 ndum6 ndum7 ndum8 ndum9 ndum10 ndum11 ndum12 eYOB1-eYOB23) if poor==0;
display "coeff X= " _b[yeduc];
display "se X= " _se[yeduc];



quietly reg lhwage yeduc year1-year23 ROB1-ROB290 cYOB1-cYOB23 eYOB1-eYOB23 (year1-year23 ROB1-ROB290 cYOB1-cYOB23
ndum1 ndum2 ndum3 ndum4 ndum5 ndum6 ndum7 ndum8 ndum9 ndum10 ndum11 ndum12 eYOB1-eYOB23) if moldyed<6.97;
display "coeff X= " _b[yeduc];
display "se X= " _se[yeduc];


quietly reg lhwage yeduc year1-year23 ROB1-ROB290 cYOB1-cYOB23 eYOB1-eYOB23 (year1-year23 ROB1-ROB290 cYOB1-cYOB23
ndum1 ndum2 ndum3 ndum4 ndum5 ndum6 ndum7 ndum8 ndum9 ndum10 ndum11 ndum12 eYOB1-eYOB23) if moldyed>6.97;
display "coeff X= " _b[yeduc];
display "se X= " _se[yeduc];
