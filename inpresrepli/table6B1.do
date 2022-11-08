# delimit ;

*2SLS;

*use supa2, clear;
use inpresdata, clear;

gen part=(lhwage!=.);
keep birthpl ch71 en71 nin wsppc lwage yeduc dum p504thn lhwage part;
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

cap log close;


log using log/table6B1, replace;

quietly anova part yeduc p504thn birthpl ch71, cont(ch71 yeduc);
display "coeff X= " _b[yeduc];
display "se X= " _se[yeduc];

quietly anova part yeduc p504thn birthpl ch71 en71, cont(ch71 yeduc en71);
display "coeff X= " _b[yeduc];
display "se X= " _se[yeduc];

quietly anova part yeduc p504thn birthpl ch71 en71 wsppc, cont(ch71 yeduc en71 wsppc);
display "coeff X= " _b[yeduc];
display "se X= " _se[yeduc];

quietly reg part yeduc year1-year23 ROB1-ROB290 cYOB1-cYOB23 (year1-year23 ROB1-ROB290 cYOB1-cYOB23
ndum1 ndum2 ndum3 ndum4 ndum5 ndum6 ndum7 ndum8 ndum9 ndum10 ndum11 ndum12);
display "coeff X= " _b[yeduc];
display "se X= " _se[yeduc];

quietly reg part yeduc year1-year23 ROB1-ROB290 cYOB1-cYOB23 eYOB1-eYOB23 (year1-year23 ROB1-ROB290 cYOB1-cYOB23
ndum1 ndum2 ndum3 ndum4 ndum5 ndum6 ndum7 ndum8 ndum9 ndum10 ndum11 ndum12 eYOB1-eYOB23);
display "coeff X= " _b[yeduc];
display "se X= " _se[yeduc];

quietly reg part yeduc year1-year23 ROB1-ROB290 cYOB1-cYOB23 eYOB1-eYOB23 wYOB1-wYOB23 (year1-year23 ROB1-ROB290 cYOB1-cYOB23
ndum1 ndum2 ndum3 ndum4 ndum5 ndum6 ndum7 ndum8 ndum9 ndum10 ndum11 ndum12 eYOB1-eYOB23 wYOB1-wYOB23);
display "coeff X= " _b[yeduc];
display "se X= " _se[yeduc];


cap drop partp;
cap drop partp2;

quietly anova part p504thn birthpl p504thn*en71 p504thn*ch71 dum*nin, cont(ch71 en71 nin);
test dum*nin;
predict partp;
gen partp2=partp^2;

quietly anova yeduc p504thn birthpl p504thn*en71 p504thn*ch71 dum*nin partp partp2, cont(ch71 en71 nin partp partp2) ;
test dum*nin;



quietly reg lhwage yeduc year1-year23 ROB1-ROB290 cYOB1-cYOB23 eYOB1-eYOB23 partp partp2 (year1-year23 ROB1-ROB290 cYOB1-cYOB23
ndum1 ndum2 ndum3 ndum4 ndum5 ndum6 ndum7 ndum8 ndum9 ndum10 ndum11 ndum12 eYOB1-eYOB23 partp partp2);
display "coeff X= " _b[yeduc];
display "se X= " _se[yeduc];

quietly reg lwage yeduc year1-year23 ROB1-ROB290 cYOB1-cYOB23 eYOB1-eYOB23 partp partp2 (year1-year23 ROB1-ROB290 cYOB1-cYOB23
ndum1 ndum2 ndum3 ndum4 ndum5 ndum6 ndum7 ndum8 ndum9 ndum10 ndum11 ndum12 eYOB1-eYOB23 partp partp2);
display "coeff X= " _b[yeduc];
display "se X= " _se[yeduc];
