clear
*use "C:\Users\ahmad\Desktop\Econ 435\term paper\2011Census\nhs2011_pumf.dta"

*STAT is dropping values with scientific notations such as exponential to solve that we are going to merge delimited file of data with our data file. 
import delimited "C:\Users\ahmad\Desktop\Econ 435\term paper\2011Census\nhs2011_pumf.tab", case(upper)
keep WAGES
rename WAGES WAGE
merge 1:1 _n using "C:\Users\ahmad\Desktop\Econ 435\term paper\2011Census\nhs2011_pumf.dta"

*Dropping people who are self-employed 
drop if(COW>1)

*defining depended variable log function of wage
drop if (WAGE== 8888888|WAGE== 9999999)
label variable WAGE "Wages of Individuals"

*My sample is people who worked full time full year only.
drop if(WRKACT!=12) 
summ WAGE

*We still have minimum value of wage as 1 which is resulting in 323 values of lwage as 0, this is very unlikely considering if a person work full time full year given minimum wage he can't earn 1$, the dataset has inaccuracies, also illegal income wouldn't show work hours on tax forms. 

gen LWAGE=log(WAGE)
label variable LWAGE "log function of wages of individuals"
tab LWAGE

summ VISMIN
label list VISMIN

*dropping data which is not available for minority
drop if VISMIN==14

*defining South Asian (SA)  minority group variable
gen S_A=0
replace S_A=1 if (VISMIN==1)
label variable S_A "dummy variable if person is South Asian or not"
label define s_a 0 "Not South Asian" 1 "South Asian"
label values S_A  s_a
tab S_A


*defining Chinese (CHI) minority group variable

gen CHI=0
replace CHI=1 if (VISMIN==2)
label variable CHI "dummy variable if person is Chinese or not"
label define c_a 0 "Not chinese" 1 " Chinese"
label values CHI  c_a
tab CHI

*defining Black (BL) minority group variable
gen BL=0
replace BL=1 if(VISMIN==3)
label variable BL "dummy variable if person is Black or not"
label define bl 0 "Not Black" 1 " Black"
label values BL  bl
tab BL

*defining Flipino (FLP) minority group variable
gen FLP=0
replace FLP=1 if (VISMIN==4)
label variable S_A "dummy variable if person is Flipino or not"
label define flp 0 "Not Filipino" 1 "Filipino"
label values  FLP flp
tab FLP
*defining Latin American (LA) minority group variable
gen LA=0
replace LA=1 if (VISMIN==5)
label variable LA "dummy variable if person is Latin American or not"
label define la 0 "Not Latin American" 1 " South Asian"
label values LA  la
tab LA

*defining Arab(Arb) minority group variable
gen ARB=0
replace ARB=1 if(VISMIN==6)
label variable ARB "dummy variable if person is Arab or not"
label define arb 0 "Not Arab" 1 "Arab"
label values ARB  arb
tab ARB
*defining Southeast Asian (SE_A) minority group variable


gen SE_A=0
replace SE_A=1 if (VISMIN==7)
label variable SE_A "dummy variable if person is Southeast Asian or not"
label define se_a 0 "Not Southeast Asian" 1 " Southeast Asian"
label values SE_A  se_a
tab SE_A
*defining West Asian (W_A) minority group variable

gen W_A=0
replace W_A=1 if (VISMIN==8)
label variable W_A "dummy variable if person is West Asian or not"
label define w_a 0 "Not West Asian" 1 "West Asian"
label values W_A  w_a
tab W_A


*defining Korean(KO) minority group variable

gen KO=0
replace KO=1 if (VISMIN==9)
label variable KO "dummy variable if person is Korean or not"
label define ko 0 "Not Korean" 1 "Korean"
label values KO  ko
tab KO

*defining Japanese(JP) minority group variable

gen JP=0
replace JP=1 if (VISMIN==10)
label variable JP "dummy variable if person is Japanese or not"
label define jp 0 "Not Japanese" 1 "Japanese"
label values JP  jp

tab JP

*defining Variable for Visible minorities not included elsewhere 

gen VMN=0
replace VMN=1 if (VISMIN==11)
label variable VMN "dummy variable if person is Visible minorities not included elsewhere"
label define vmn 1 "VM Not included elsewhere " 0 "Not VM or included elsewhere"
label values VMN vmn
tab VMN

*defining Variable for  Aboriginal minority

 gen AB=0
replace AB=1 if (ETHDER==1)
label variable AB "dummy variable if person is Aboriginal or not"
label define ab 0 "Not Aborginal" 1 " Aboriginal"
label values AB ab
tab AB


*defining variable for multiple visible minorities
gen MVM=0
replace MVM=1 if (VISMIN==12)
label variable MVM "dummy variable if person is multiple visible minorities or not"
label define mvm 0 "Not Multiple VM" 1 "Multiple VM"
label values MVM mvm
tab MVM



*defining a variable for Apprenticeship certificate and diploma level education
 gen A_DEDUC=0
replace A_DEDUC=1 if(HDGREE==3|HDGREE==3)
label variable A_DEDUC "dummy variable if person has diploma, apprenticeship or not"
label define dued 0 "No diploma nor Apprenticeship" 1 "Apprenticeship"
label values A_DEDUC dued
tab A_DEDUC

*defining variable for college and university level education
gen UEDUC=0
replace UEDUC=1 if(inrange(HDGREE,5,10))
label variable UEDUC "dummy variable if person has higher education than highschool or not"
label define ued 0 "Educ < or = Highschool" 1 "Educ > Highschool"
label values UEDUC hed
tab UEDUC

*defining variable for which education achieved is Highschool diploma or equivalent

gen HEDUC=0
replace HEDUC=1 if(HDGREE==2)
label variable HEDUC "dummy variable if person has higher education than highschool or not"
label define hed 0 "Educ is Highschool" 1 "Educ not Highschool"
label values HEDUC hed
tab HEDUC

 *defining a variable for Masters and Doctrate level Education
 gen DEDUC=0
 replace DEDUC=1 if(inrange(HDGREE,11,13))
 label variable DEDUC "dummy variable if person has masters or doctrate"
 label define deduc 0 "No doctrate or masters"  1 "Doctrate or Masters"
 label values DEDUC deduc
 tab DEDUC
 
 *I have grouped Education level into 4 groups, I have kept people with masters and doctrates in one, college and university level education in one, highschool education in one, diploma and Apprenticeship certificate in one.
 
 *Dropping data for when data is not avalaible
 drop if HDGREE==14
 
 
 
 
 *defining variable which indicates if Highest Education outside Canada

gen LOCED=0
replace LOCED=1 if(LOC_ST_RES==3)
label variable LOCED "dummy variable if person's Highest eductation outside Canada or not"
label define loced 0 "Educ achieved in Canada" 1 "Educ achieved outside CA"
label values LOCED loced
tab LOCED

 *defining a variable for Years since Immigration to Canada
gen YIM=0
 
label variable YIM "Number of years since Immigration"  

replace YIM=(2011-1955) if (YRIMM==1)
replace YIM=(2011-1957) if (YRIMM==2)
replace YIM=(2011-1962) if (YRIMM==3)
replace YIM=(2011-1967) if (YRIMM==4)
replace YIM=(2011-1972) if (YRIMM==5)
replace YIM=(2011-1977) if (YRIMM==6)
replace YIM=(2011-1982) if (YRIMM==7)
replace YIM=(2011-1987) if (YRIMM==8)
replace YIM=(2011-1990) if (YRIMM==9)
replace YIM=(2011-1991) if (YRIMM==10)
replace YIM=(2011-1992) if (YRIMM==11)
replace YIM=(2011-1993) if (YRIMM==12)
replace YIM=(2011-1994) if (YRIMM==13)
replace YIM=(2011-1995) if (YRIMM==14)
replace YIM=(2011-1996) if (YRIMM==15)
replace YIM=(2011-1997) if (YRIMM==16)
replace YIM=(2011-1998) if (YRIMM==17)
replace YIM=(2011-1999) if (YRIMM==18)
replace YIM=(2011-2000) if (YRIMM==19)
replace YIM=(2011-2001) if (YRIMM==20)
replace YIM=(2011-2002) if (YRIMM==21)
replace YIM=(2011-2003) if (YRIMM==22)
replace YIM=(2011-2004) if (YRIMM==23)
replace YIM=(2011-2005) if (YRIMM==24)
replace YIM=(2011-2006) if (YRIMM==25)
replace YIM=(2011-2007) if (YRIMM==26)
replace YIM=(2011-2008) if (YRIMM==27)
replace YIM=(2011-2009) if (YRIMM==28)
replace YIM=(1) if (YRIMM==29) 
replace YIM=0 if (YRIMM==31) 
tab YIM 
drop if YRIMM==30

*if a person is immigrant or nor
gen IMMG=0
replace IMMG=1 if(YIM==0)
label variable IMMG "If a person is immigrant or not"
label define immg 0 "Not immigrant" 1 "Immigrant"
label values IMMG immg
tab IMMG 

*Variables for Age Groups

gen AGE15_17=0
replace AGE15_17=1 if(AGEGRP==6)
label variable AGE15_17 "dummy variable if person's age b/w 15-17"
label define age15 0 "Age not 15-17" 1 "Age b/w 15-17"
label values AGE15_17 age15
tab AGE15_17
 
gen AGE18_19=0
replace AGE18_19=1 if(AGEGRP==7)
label variable AGE18_19 "dummy variable if person's age b/w 18-19"
label define age18 0 "Age not 15-17" 1 "Age b/w 18-19"
label values AGE18_19 age18
tab AGE18_19

gen AGE20_24=0
replace AGE20_24=1 if(AGEGRP==8)
label variable AGE20_24 "dummy variable if person's age b/w 20-24"
label define age20 0 "Age not 20-24" 1 "Age b/w 20-24"
label values AGE20_24 age20
tab AGE20_24

gen AGE25_29=0
replace AGE25_29=1 if(AGEGRP==9)
label variable AGE25_29 "dummy variable if person's age b/w 25-29"
label define age25 0 "Age not 25-29" 1 "Age b/w 25-29"
label values AGE25_29 age25
tab AGE25_29


 gen AGE30_34=0
replace AGE30_34=1 if(AGEGRP==10)
label variable AGE30_34 "dummy variable if person's age b/w 30-34"
label define age30 0 "Age not 30-34" 1 "Age b/w 30-34"
label values AGE30_34 age30
tab AGE30_34

gen AGE40_44=0
replace AGE40_44=1 if(AGEGRP==12)
label variable AGE40_44 "dummy variable if person's age b/w 40-44"
label define age40 0 "Age not 40-44" 1 "Age b/w 40-44"
label values AGE40_44 age40
tab AGE40_44

gen AGE45_49=0
replace AGE45_49=1 if(AGEGRP==13)
label variable AGE45_49 "dummy variable if person's age b/w 45-49"
label define age45 0 "Age not 45-49" 1 "Age b/w 45-49"
label values AGE45_49 age45

gen AGE50_54=0
replace AGE50_54=1 if(AGEGRP==14)
label variable AGE50_54 "dummy variable if person's age b/w 50-54"
label define age50 0 "Age not 50-54" 1 "Age b/w 50-54"
label values AGE50_54 age50
tab AGE50_54

gen AGE55_59=0
replace AGE55_59=1 if(AGEGRP==15)
label variable AGE55_59 "dummy variable if person's age b/w 55-59"
label define age55 0 "Age not 55-59" 1 "Age b/w 55-59"
label values AGE55_59 age55
tab AGE55_59

gen AGE60_64=0
replace AGE60_64=1 if(AGEGRP==16)
label variable AGE60_64 "dummy variable if person's age b/w 60-64"
label define age60 0 "Age not 60-64" 1 "Age b/w 60-64"
label values AGE60_64 age60
tab AGE60_64

*all the coefficient for age dummy variable will be relative to age of 35-39
*dropping people who are underage for legally working labour force
drop if (inrange(AGEGRP,3,5))
*dropping people who are old enough to likely not be in labour force
drop if (inrange(AGEGRP,18,21))
*Dropping unavailable data points of AGEGRP
drop if AGEGRP==22


*defining variable for person legally married or common law
gen MARR=0
replace MARR=1 if(MARSTH==2|MARSTH==3)
label variable MARR "dummy variable if person's  married or not"
label define marr 0 "Never married" 1 "Married"
label values MARR marr
tab MARR



*defining a variable for gender
gen MALE=0
replace MALE=1 if(SEX==2)
label variable MALE "dummy variable if person's  Male or Female"
label define male 0 "Female" 1 "Male"
label values MALE male
tab MALE






 
 
 
 
 

*Variable for Location of work, relative of British Columbia as working location

*dummy variable for Newfoundland and Labrador Location of job  
gen NEWF=0
replace NEWF=1 if (PWPR==1)
label variable NEWF "Newfoundland and Labrador as Location of work"
label define newf 0 "Not in Newfoundland or Labrador" 1 "New Foundland and Labrador"
label values NEWF newf
tab NEWF         

*dummy variable for Prince Edward as location of job  
gen PEI=0
replace PEI=1 if (PWPR==2)
label variable PEI "Prince Edward as location of work" 
label define pei 0 "Not in Prince Edward" 1 "In Prince Edward"
label values PEI pei 
tab PEI

*dummy variable for Nova Scotia as location of job
gen NS=0
replace NS=1 if (PWPR==3)
label variable NS "Nova Scotia as location of work"
label define ns 0 "Not in Nova Scotia" 1 "In Nova Scotia"
label values NS ns 
tab NS

*dummy variable for New Brunswick as location of job
gen NB=0
replace NB=1 if (PWPR==4)
label variable NB "New Brunswick as location of job"
label define nb 0 "Not in New Brunswick" 1 "In New Brunswick"
label values NB nb
tab NB

*dummy variable for Quebec
gen QB=0
replace QB=1 if (PWPR==5)
label variable QB "Quebec as location of job"
label define qb 0 "Not in Quebec" 1 "In Quebec"
label values QB qb
tab QB

*dummy variable for Ontario 
gen ONT=0
replace ONT=1 if (PWPR==6)
label variable ONT "Ontario as location of Job"
label define ont 0 "Not in Ontario" 1 "In Ontario"   
label values ONT ont 
tab ONT

*dummy variable for Manitoba
gen MN=0
replace MN=1 if (PWPR==7)
label variable MN "Manitoba as Location of job"
label define mn 0 "Not in Manitoba" 1 "In Manitoba"
label values MN mn
tab MN

*dummy variable for Saskatchewan
gen SKW=0
replace SKW=1 if (PWPR==8)
label variable SKW "Saskatchewan as location of job"
label define skw 0 "Not in Sasketchwan" 1 "In Sasketchwan"
label value SKW skw

*dummy variable for Alberta
gen ALB=0
replace ALB=1 if (PWPR==9)
label variable ALB " ALberta as location of Job"
label define alb 0 "Not in Alberta" 1 "In Alberta"
label values ALB alb
tab ALB

*dropping values for not applicable and not available 
drop if (PWPR==12|PWPR==13)


*Variable for official language that person can speak and converse in

*dummy variable if person uses only English as official language
gen ENG=0
replace ENG=1 if (KOL==1)
label variable ENG "People who can use only English as Language"
label define eng 0 "Doesn't use only in English" 1 "Only English as official"
label values ENG eng
tab ENG

*dummy variable if person uses only French as official language 
gen FRN=0
replace FRN=1 if (KOL==2)
label variable FRN "People who can use only French as official language"
label define frn 0 "Doesn't use only French" 1 "Only French as official"
label values FRN frn 
tab FRN

*dummy variable if person uses both English and French 
gen FREN=0
replace FREN=1 if (KOL==3)
label variable FREN "People who can use both French and English as official"
  
 *Regression model
reg LWAGE NEWF PEI NS NB QB ONT MN SKW ALB ENG FRN FREN MALE MARR AGE60_64 AGE55_59 AGE50_54 AGE45_49 AGE40_44  AGE30_34 AGE25_29 AGE20_24 AGE18_19 AGE15_17 YIM LOCED DEDUC HEDUC UEDUC A_DEDUC i.MVM##i.IMMG AB i.VMN##i.IMMG i.JP##i.IMMG i.KO##i.IMMG i.W_A##i.IMMG i.SE_A##i.IMMG i.ARB##i.IMMG i.LA##i.IMMG i.FLP##i.IMMG i.BL##i.IMMG i.CHI##i.IMMG i.S_A##i.IMMG  

*Comments on regression results:
  *Most interesting thing is that if education is from outside Canada our model predicts that on average wage will be 6% lower than if someone attained education from Canada. Our model predicts that Immigrant on average would have 9% higher wage than non-immigrants, I need to explore this a little more, since I expected otherwise. Black, WestAsian, Visible minority not elsewhere and South East asian minority group, immigrants had higher wages whereas other minorities appears to hace lower wages if they were immigrants. Additional year from immigration increases wage by 0.4% ( I need to correct this by adding c.YIM#c.YIM because I belive it's a decreasing function with time)
  *Only NewBrunswick, Nova Scotia and Prince Edward Island had lower wages than BC (negative respective coefficients). Multiple visible minorities have higher 8.38% (MVM coeefcient=8.38%) higher wages than non-minorities. Japanese minority have 17.2% higher wages than non-minorities. Filipino minority group has 3.37% higher wages than non-minorities. All other minorities appear to have lower wages than non-minorities. There some concerns that I would like to look further into such are as My adjusted R-squared value is too low, although I not interested in overall fit.        

*Summary of dependent and independent variables
*sum ( NEWF PEI NS NB QB ONT MN SKW ALB LWAGE WAGE ENG FREN FRN MALE  MARR AGE60_64 AGE55_59 AGE50_54 AGE45_49 AGE40_44  AGE30_34 AGE25_29 AGE20_24 AGE18_19 AGE15_17 YIM LOCED DEDUC HEDUC UEDUC A_DEDUC MVM AB VMN JP KO W_A SE_A ARB LA FLP BL CHI S_A)

*comments for personal use in future:
 *Variable for sector of occupation up for consideration
*NAICS


**NEW










   



