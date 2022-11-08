# delimit ;

*PROGRAME FOR TABLE 4; set matsize 400; cap log close; log using
log/table5.log, replace;

*EDUCATION;

quietly anova yeduc birthpl p504th p504th*ch71 nin*dum, reg cont(nin ch71) ;
display "N.OBS  " e(N);
display "R. squared" e(r2);
test nin*dum;
for X in num 1/11:
display "coeff X= " _b[nin*dum[X]]\
display "se X= " _se[nin*dum[X]];


quietly anova yeduc birthpl p504th p504th*ch71 p504th*en71 nin*dum, reg cont(nin ch71 en71) ;
display "N.OBS  " e(N);
display "R. squared" e(r2);
test nin*dum;
for X in num 1/11:
display "coeff X= " _b[nin*dum[X]]\
display "se X= " _se[nin*dum[X]];


quietly anova yeduc birthpl p504th p504th*ch71 p504th*en71 p504thn*wsppc nin*dum, reg cont(nin ch71 en71 wsppc) ;
display "N.OBS  " e(N);
display "R. squared" e(r2);
test nin*dum;
for X in num 1/11:
display "coeff X= " _b[nin*dum[X]]\
display "se X= " _se[nin*dum[X]];

*EDUCATION, wage sample ;

quietly anova yeduc birthpl p504th p504th*ch71 nin*dum if lhwage!=.,
reg cont(nin ch71) ;
display "N.OBS  " e(N);
display "R. squared" e(r2);
test nin*dum;
for X in num 1/11:
display "coeff X= " _b[nin*dum[X]]\
display "se X= " _se[nin*dum[X]];


quietly anova yeduc birthpl p504th p504th*ch71 p504th*en71 nin*dum if lhwage!=.,
 reg cont(nin ch71 en71) ;
display "N.OBS  " e(N);
display "R. squared" e(r2);
test nin*dum;
for X in num 1/11:
display "coeff X= " _b[nin*dum[X]]\
display "se X= " _se[nin*dum[X]];


quietly anova yeduc birthpl p504th p504th*ch71 p504th*en71 p504thn*wsppc nin*dum if lhwage!=.,
 reg cont(nin ch71 en71 wsppc) ;
display "N.OBS  " e(N);
display "R. squared" e(r2);
test nin*dum;
for X in num 1/11:
display "coeff X= " _b[nin*dum[X]]\
display "se X= " _se[nin*dum[X]];

*WAGE;

quietly anova lhwage birthpl p504th p504th*ch71 nin*dum, reg cont(nin ch71) ;
display "N.OBS  " e(N);
display "R. squared" e(r2);
test nin*dum;
for X in num 1/11:
display "coeff X= " _b[nin*dum[X]]\
display "se X= " _se[nin*dum[X]];


quietly anova lhwage birthpl p504th p504th*ch71 p504th*en71 nin*dum, reg cont(nin ch71 en71) ;
display "N.OBS  " e(N);
display "R. squared" e(r2);
test nin*dum;
for X in num 1/11:
display "coeff X= " _b[nin*dum[X]]\
display "se X= " _se[nin*dum[X]];


quietly anova lhwage birthpl p504th p504th*ch71 p504th*en71 p504thn*wsppc nin*dum, reg cont(nin ch71 en71 wsppc) ;
display "N.OBS  " e(N);
display "R. squared" e(r2);
test nin*dum;
for X in num 1/11:
display "coeff X= " _b[nin*dum[X]]\
display "se X = " _se[nin*dum[X]];
