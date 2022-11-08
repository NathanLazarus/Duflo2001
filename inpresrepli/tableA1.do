# delimit ;

*PROGRAME FOR TABLE A1; set matsize 400; cap log close; log using
log/tableA1.log, replace;

*use supa2,clear;
use inpresdata, clear;

*EDUCATION;

anova yeduc birthpl p504th p504th*ch71 nin*p504th, reg cont(nin ch71) ;
display "N.OBS  " e(N);
display "R. squared" e(r2);
test nin*p504th;
for X in num 1/23:
display "coeff X= " _b[nin*p504th[X]]\
display "se X= " _se[nin*p504th[X]];


quietly anova yeduc birthpl p504th p504th*ch71 p504th*en71 nin*p504th, reg cont(nin ch71 en71) ;
display "N.OBS  " e(N);
display "R. squared" e(r2);
test nin*p504th;
for X in num 1/23:
display "coeff X= " _b[nin*p504th[X]]\
display "se X= " _se[nin*p504th[X]];


quietly anova yeduc birthpl p504th p504th*ch71 p504th*en71 p504thn*wsppc nin*p504th, reg cont(nin ch71 en71 wsppc) ;
display "N.OBS  " e(N);
display "R. squared" e(r2);
test nin*p504th;
for X in num 1/23:
display "coeff X= " _b[nin*p504th[X]]\
display "se X= " _se[nin*p504th[X]];

*EDUCATION, wage sample ;

quietly anova yeduc birthpl p504th p504th*ch71 nin*p504th if lhwage!=.,
reg cont(nin ch71) ;
display "N.OBS  " e(N);
display "R. squared" e(r2);
test nin*p504th;
for X in num 1/23:
display "coeff X= " _b[nin*p504th[X]]\
display "se X= " _se[nin*p504th[X]];


quietly anova yeduc birthpl p504th p504th*ch71 p504th*en71 nin*p504th if lhwage!=.,
 reg cont(nin ch71 en71) ;
display "N.OBS  " e(N);
display "R. squared" e(r2);
test nin*p504th;
for X in num 1/23:
display "coeff X= " _b[nin*p504th[X]]\
display "se X= " _se[nin*p504th[X]];


quietly anova yeduc birthpl p504th p504th*ch71 p504th*en71 p504thn*wsppc nin*p504th if lhwage!=.,
 reg cont(nin ch71 en71 wsppc) ;
display "N.OBS  " e(N);
display "R. squared" e(r2);
test nin*p504th;
for X in num 1/23:
display "coeff X= " _b[nin*p504th[X]]\
display "se X= " _se[nin*p504th[X]];

*WAGE;

quietly anova lhwage birthpl p504th p504th*ch71 nin*p504th, reg cont(nin ch71) ;
display "N.OBS  " e(N);
display "R. squared" e(r2);
test nin*p504th;
for X in num 1/23:
display "coeff X= " _b[nin*p504th[X]]\
display "se X= " _se[nin*p504th[X]];


quietly anova lhwage birthpl p504th p504th*ch71 p504th*en71 nin*p504th, reg cont(nin ch71 en71) ;
display "N.OBS  " e(N);
display "R. squared" e(r2);
test nin*p504th;
for X in num 1/23:
display "coeff X= " _b[nin*p504th[X]]\
display "se X= " _se[nin*p504th[X]];


quietly anova lhwage birthpl p504th p504th*ch71 p504th*en71 p504thn*wsppc nin*p504th, reg cont(nin ch71 en71 wsppc) ;
display "N.OBS  " e(N);
display "R. squared" e(r2);
test nin*p504th;
for X in num 1/23:
display "coeff X= " _b[nin*p504th[X]]\
display "se X = " _se[nin*p504th[X]];
