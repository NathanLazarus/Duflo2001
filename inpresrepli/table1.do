# delimit ;

*use supa2,clear;
use inpresdata,clear;
cap log close;
log using log/table1, replace;

sum yeduc if nin!=. [w=weight] ;
sum yeduc if lhwage !=.  & nin!=. [w=weight] ;
sum nin [w=weight] ;
sum nin if lhwage !=. [w=weight];
sum nin if recp==1 [w=weight];
sum nin if recp==0 [w=weight];
sum lhwage if nin !=. [w=weight] ;

/*use kabdat2.dta;
sum totin;
sum nin;
sum en71;
*/
