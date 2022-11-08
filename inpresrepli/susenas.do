# delimit ;

version 10;

use esther2,clear;
keep inccat avinc;
sort inccat;
save esther2, replace;

*use supa2;
use inpresdata, clear;
cap drop _merge;
gen codag=99;
replace codag=11 if p607==11;
replace codag=13 if p607==13;
replace codag=99 if p607==14;
replace codag=15 if p607==15;
replace codag=16 if p607==16;
replace codag=16 if (p607==17 |p607==18);

gen indcode=int(p607/10);
replace indcode=10 if indcode==0;
replace indcode=6 if p607==14;
gen status=1 if p608==4;
replace status=2 if p608!=.4;

gen ysrccode=status+indcode*10;
gen inccat=p105+codag*10+ysrccode*1000;
sort inccat;

merge inccat using esther2;
sum avinc [w=weight] if lwage!=.;
sum avinc  [w=weight] if lwage ==.;
scalar define savinc=r(mean);
sum wage  [w=weight];
scalar define swage=r(mean);
scalar define infla=swage/savinc;
gen winp=avinc*infla;
gen lwinp=log(winp);
replace lwinp=lwage if lwage !=.;



keep if lwinp !=.;
keep birthpl ch71 en71 nin wsppc lwinp yeduc dum p504thn;
tab birthpl, gen(ROB);
tab p504thn, gen(year);
tab dum, gen(dum);
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


quietly anova lwinp yeduc p504thn birthpl ch71, cont(ch71 yeduc) ;
display "coeff X= " _b[yeduc];
display "se X= " _se[yeduc];

quietly anova lwinp yeduc p504thn birthpl ch71 en71, cont(ch71 en71 yeduc) ;
display "coeff X= " _b[yeduc];
display "se X= " _se[yeduc];

quietly anova lwinp yeduc p504thn birthpl ch71 en71 wsppc, cont(ch71 en71 wsppc yeduc);
display "coeff X= " _b[yeduc];
display "se X= " _se[yeduc];


quietly reg lwinp yeduc year1-year23 ROB1-ROB290 cYOB1-cYOB23 (year1-year23 ROB1-ROB290 cYOB1-cYOB23
ndum1 ndum2 ndum3 ndum4 ndum5 ndum6 ndum7 ndum8 ndum9 ndum10 ndum11 ndum12);
display "coeff X= " _b[yeduc];
display "se X= " _se[yeduc];

quietly reg lwinp yeduc year1-year23 ROB1-ROB290 cYOB1-cYOB23 eYOB1-eYOB23 (year1-year23 ROB1-ROB290 cYOB1-cYOB23
ndum1 ndum2 ndum3 ndum4 ndum5 ndum6 ndum7 ndum8 ndum9 ndum10 ndum11 ndum12 eYOB1-eYOB23);
display "coeff X= " _b[yeduc];
display "se X= " _se[yeduc];

quietly reg lwinp yeduc year1-year23 ROB1-ROB290 cYOB1-cYOB23 eYOB1-eYOB23 wYOB1-wYOB23 (year1-year23 ROB1-ROB290 cYOB1-cYOB23
ndum1 ndum2 ndum3 ndum4 ndum5 ndum6 ndum7 ndum8 ndum9 ndum10 ndum11 ndum12 eYOB1-eYOB23 wYOB1-wYOB23);
display "coeff X= " _b[yeduc];
display "se X= " _se[yeduc];
