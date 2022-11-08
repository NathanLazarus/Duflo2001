#delimit ;

version 10; 
*WALD TABLE;

cap log close;

// log using log/wald.log, replace;

cd C:/Users/Nathan/Downloads/inpresrepli;

*use supa2, clear;

use inpresdata, clear;

/* first, look at means education and wages in low and high
program regions*/

/*experiment of interest*/

/*education*/

ci yeduc if lhwage !=. & p504thn>67 & recp>0 [w=weight];

ci yeduc if lhwage !=. &  p504thn>67 & recp==0 [w=weight];

ci yeduc if lhwage !=. &p504thn<=62 &  p504thn>=57  & recp>0
[w=weight];

ci yeduc if lhwage !=. & p504thn<=62 &  p504thn>=57  & recp==0
[w=weight];

/*wage*/

ci lhwage if lhwage !=. & p504thn>67 & recp>0 [w=weight];

ci lhwage if lhwage !=. &  p504thn>67 & recp==0 [w=weight];

ci lhwage if lhwage !=. &p504thn<=62 &  p504thn>=57  & recp>0
[w=weight];

ci lhwage if lhwage !=. & p504thn<=62 &  p504thn>=57  & recp==0
[w=weight];

/*control experiment*/

/*education*/

ci yeduc if lhwage !=. & p504thn<62 & recp>0 [w=weight];

ci yeduc if lhwage !=. &  p504thn<62 & recp==0 [w=weight];

ci yeduc if lhwage !=. &p504thn<=62 &  p504thn>=57  & recp>0
[w=weight];

ci yeduc if lhwage !=. & p504thn<=62 &  p504thn>=57  & recp==0
[w=weight];

/*wage*/

ci lhwage if lhwage !=. & p504thn<62 & recp>0 [w=weight];

ci lhwage if lhwage !=. &  p504thn<62 & recp==0 [w=weight];

ci lhwage if lhwage !=. &p504thn<=62 &  p504thn>=57  & recp>0
[w=weight];

ci lhwage if lhwage !=. & p504thn<=62 &  p504thn>=57  & recp==0
[w=weight];

cap gen recptr2b=recp*treat2b;
cap gen recptr1b=recp*treat1b;

reg yeduc recp [w=weight] if treat2b==1  & lhwage !=.;
reg yeduc recp [w=weight] if treat1b==1  & lhwage !=.;
reg yeduc treat2b  [w=weight] if recp==1 & (treat2b==1 |treat1b==1) & lhwage !=. ;
reg yeduc treat2b  [w=weight] if recp==0 & (treat2b==1 |treat1b==1) &  lhwage !=.;
reg yeduc treat2b recp recptr2b  [w=weight] if lhwage !=. & (treat2b==1 |treat1b==1);

reg yeduc recp [w=weight] if p504thn<57 & lhwage !=.;
reg yeduc treat1b [w=weight] if recp==1 & p504thn<=62 & lhwage !=.;
reg yeduc treat1b recp recptr1b  [w=weight]  if p504thn<=62 & lhwage !=.;

reg lhwage recp [w=weight] if treat2b==1  & lhwage !=.;
reg lhwage recp [w=weight] if treat1b==1  & lhwage !=.;
reg lhwage treat2b  [w=weight] if recp==1 & (treat2b==1 |treat1b==1) & lhwage !=. ;
reg lhwage treat2b  [w=weight] if recp==0 & (treat2b==1 |treat1b==1) &  lhwage !=.;
reg lhwage treat2b recp recptr2b  [w=weight] if lhwage !=. & (treat2b==1 |treat1b==1);

reg lhwage recp [w=weight] if p504thn<57 & lhwage !=.;
reg lhwage treat1b [w=weight] if recp==1 & p504thn<=62 & lhwage !=.;
reg lhwage treat1b recp recptr1b  [w=weight]  if p504thn<=62 & lhwage !=.;
