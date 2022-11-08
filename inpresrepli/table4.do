# delimit ;

*PROGRAME FOR TABLE 4;
set matsize 400;
cap log close;
log using log/table4.log, replace;


quietly anova yeduc birthpl p504th p504th*ch71 nin*treat2b if (treat1b==1|treat2b==1),  cont(nin ch71) ;
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat2b[1]];
display "S.E    " _se[nin*treat2b[1]];

quietly anova yeduc birthpl p504th p504th*ch71 p504th*en71 nin*treat2b if (treat1b==1|treat2b==1), cont(nin ch71 en71);
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat2b[1]];
display "S.E    " _se[nin*treat2b[1]];


quietly anova yeduc birthpl p504th p504th*ch71 p504th*en71 p504th*wsppc nin*treat2b if (treat1b==1|treat2b==1), cont(nin ch71 en71 wsppc);
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat2b[1]];
display "S.E    " _se[nin*treat2b[1]];

*WAGE SAMPLE;


quietly anova yeduc birthpl p504th p504th*ch71 nin*treat2b if (treat1b==1|treat2b==1) & lhwage !=.,
cont(nin ch71) ;
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat2b[1]];
display "S.E    " _se[nin*treat2b[1]];

quietly anova yeduc birthpl p504th p504th*ch71 p504th*en71 nin*treat2b if (treat1b==1|treat2b==1) & lhwage !=.,
cont(nin ch71 en71 );
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat2b[1]];
display "S.E    " _se[nin*treat2b[1]];


quietly anova yeduc birthpl p504th p504th*ch71 p504th*en71 p504th*wsppc nin*treat2b if (treat1b==1|treat2b==1) & lhwage !=.,
cont(nin ch71 en71 wsppc);
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat2b[1]];
display "S.E    " _se[nin*treat2b[1]];


*WAGE regressions;


quietly anova lhwage birthpl p504th p504th*ch71 nin*treat2b if (treat1b==1|treat2b==1),  cont(nin ch71) ;
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat2b[1]];
display "S.E    " _se[nin*treat2b[1]];

quietly anova lhwage birthpl p504th p504th*ch71 p504th*en71 nin*treat2b if (treat1b==1|treat2b==1), cont(nin ch71 en71);
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat2b[1]];
display "S.E    " _se[nin*treat2b[1]];


quietly anova lhwage birthpl p504th p504th*ch71 p504th*en71 p504th*wsppc nin*treat2b if (treat1b==1|treat2b==1), cont(nin ch71 en71 wsppc);
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat2b[1]];
display "S.E    " _se[nin*treat2b[1]];


*CONTROL EXPERIMENT;



quietly anova yeduc birthpl p504th p504th*ch71 nin*treat1b if p504thn<=62,
cont(nin ch71) ;
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat1b[1]];
display "S.E    " _se[nin*treat1b[1]];

quietly anova yeduc birthpl p504th p504th*ch71 p504th*en71 nin*treat1b if p504thn<=62,
cont(nin ch71 en71);
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat1b[1]];
display "S.E    " _se[nin*treat1b[1]];


quietly anova yeduc birthpl p504th p504th*ch71 p504th*en71 p504th*wsppc nin*treat1b if p504thn<=62,
 cont(nin ch71 en71 wsppc);
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat1b[1]];
display "S.E    " _se[nin*treat1b[1]];

*CONTROL EXPERIMENT, WAGE SAMPLE;

quietly anova yeduc birthpl p504th p504th*ch71 nin*treat1b if p504thn<=62 & lhwage !=.,
cont(nin ch71) ;
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat1b[1]];
display "S.E    " _se[nin*treat1b[1]];

quietly anova yeduc birthpl p504th p504th*ch71 p504th*en71 nin*treat1b if p504thn<=62  & lhwage !=.,
cont(nin ch71 en71);
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat1b[1]];
display "S.E    " _se[nin*treat1b[1]];


quietly anova yeduc birthpl p504th p504th*ch71 p504th*en71 p504th*wsppc nin*treat1b if p504thn<=62  & lhwage !=.,
 cont(nin ch71 en71 wsppc);
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat1b[1]];
display "S.E    " _se[nin*treat1b[1]];


*CONTROL EXPERIMENT, WAGE REGRESSIONS;


quietly anova lhwage birthpl p504th p504th*ch71 nin*treat1b if p504thn<=62,
cont(nin ch71) ;
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat1b[1]];
display "S.E    " _se[nin*treat1b[1]];

quietly anova lhwage birthpl p504th p504th*ch71 p504th*en71 nin*treat1b if p504thn<=62,
cont(nin ch71 en71);
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat1b[1]];
display "S.E    " _se[nin*treat1b[1]];


quietly anova lhwage birthpl p504th p504th*ch71 p504th*en71 p504th*wsppc nin*treat1b if p504thn<=62,
 cont(nin ch71 en71 wsppc);
display "N.OBS  " e(N);
display "coeff  " _b[nin*treat1b[1]];
display "S.E    " _se[nin*treat1b[1]];
