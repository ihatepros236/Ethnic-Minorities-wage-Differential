clear
*use "C:\Users\ahmad\Desktop\Econ 435\term paper\2011Census\nhs2011_pumf.dta"

*STATA is dropping values with scientific notations such as exponential to solve that we are going to merge delimited file of data with our data file. 
import delimited "C:\Users\ahmad\Desktop\Econ 435\term paper\2011Census\nhs2011_pumf.tab", case(upper)
keep WAGES
rename WAGES WAGE
merge 1:1 _n using "C:\Users\ahmad\Desktop\Econ 435\term paper\2011Census\nhs2011_pumf.dta"

*Dropping people who are self-employed 
drop if(COW>1)

*defining depended variable log function of wage
drop if (WAGE== 8888888|WAGE== 9999999)

*Wage=1 not possible considering minimum wages, hence we will drop it,
*it's probably because of age group of 15-17, which includes 15 year old(15 year old not allowed to legally work full time in Canada)
drop if(WAGE==1|WAGE==0)

label variable WAGE "Wages of Individuals"

*My sample is people who worked full time full year only. 
*I am controlling for number of weeks worked too, to avoid variations in wages due to number of hours or week worked
*I cannot stress this enough, My sample includes people who Worked 49 to 52 weeks full time.
*Alternatively, I could have used "drop if (FPTWK!=1)"
*but this would have only accounted for full time and part time not number of hours/weeks

drop if(WRKACT!=11)

summ WAGE

gen LWAGE=log(WAGE)
label variable LWAGE "log function of wages of individuals"
tab LWAGE

 

*Howerver you will notice that if I use full time full year (49-52 weeks), I will have  far more Females than males in my sample  

*defining a variable for gender
gen MALE=0
replace MALE=1 if(SEX==2)
label variable MALE "dummy variable if person's  Male"
label define male 0 "Female" 1 "Male"
label values MALE male
tab MALE


*dropping data which is not available for minority
drop if VISMIN==14


*Dummy variable for person being a visible minority

gen ALLVMIN=0
replace ALLVMIN=1 if(VISMIN!=13)
label variable ALLVMIN "Dummy variable if a person is visible minority or not"
label define allvmin 0 "White person" 1 "Visible minority"
label values ALLVMIN allvmin
tab ALLVMIN 
  

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
label define la 0 "Not Latin American" 1 " Latin American"
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
 gen ADEDUC=0
replace ADEDUC=1 if(HDGREE==3|HDGREE==4)
label variable ADEDUC "dummy variable if person has diploma, apprenticeship or not"
label define dued 0 "No diploma nor Apprenticeship" 1 "Apprenticeship"
label values ADEDUC dued
tab ADEDUC

*defining variable for college and university level education
gen UEDUC=0
replace UEDUC=1 if(inrange(HDGREE,5,10))
label variable UEDUC "dummy variable if person has Undergraduate degree or diploma above undergraduate degree"
label define ued 0 "No University/college Education" 1 "University college Education"
label values UEDUC ued
tab UEDUC

*defining variable for which education achieved is Highschool diploma or equivalent

gen HEDUC=0
replace HEDUC=1 if(HDGREE==2)
label variable HEDUC "dummy variable if person has highschool education or not"
label define hed 1 "Educ is Highschool" 0 "Educ not Highschool"
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

gen NED=0
replace NED=1 if(LOC_ST_RES==4)
label variable NED "dummy variable if person has no post secondary education"
label define ned 1 "No post education achieved" 0 "post education achieved"
label values NED ned
tab NED 

drop if (LOC_ST_RES==5)


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
replace YIM=1 if (YRIMM==29) 
tab YIM 
drop if YRIMM==30

*if a person is immigrant or not
gen IMMG=0
replace IMMG=1 if(IMMSTAT==2|IMMSTAT==3)
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







*Defining variable for broad occupation categories:

*Defining variable for Management occupation:
gen MANG=0 
replace MANG=1 if (NOCS==1)
label variable MANG "People with management occupation"
label define mang 0 "Person not in management" 1 "Person in Management"
label values MANG mang 
tab MANG


*Defining variable for Business, finance and administrative occupations:
gen BFA=0
replace BFA=1 if (NOCS==2)
label variable BFA "People with Business finance or Administration as occupation"
label define bfa 0 "People not in Business finance or Administration" 1 "People in Business finance or Administration"
label values BFA bfa 
tab BFA

*Defining variable for People in natural and applied sciences and related occupations:
gen SCI=0 
replace SCI=1 if (NOCS==3)
label variable SCI "People with natural and applied sciences and related occupations"
label define sci 0 "People not in Sciences occupation" 1 "Person in Sciences occupation"
label values SCI sci
tab SCI

*Defining variable for People in Health occupations:
gen HELT=0
replace HELT=1 if(NOCS==4)
label variable HELT "People in health Science sector"
label define helt 0 "People not in Health Sector" 1 "Person with Health Science occupation"
label values HELT helt
tab HELT 

*Defining variable for People with occupation in social science, education,government service and religion
gen PUB=0
replace PUB=1 if (NOCS==5)
label variable PUB "If People with social science, education, gov't service or relion as occupation"
label define pub 0 "person not in Social.sci and Public services sector" 1 "Person in Social.sci and Public services sector"
label values PUB pub 
tab PUB

*Defining variable for People with occupation in Art, culture and sports:
gen ACS=0 
replace ACS=1 if(NOCS==6)
label variable ACS "If people with occupation in Art, culture and sports"
label define acs 0 "Person not in Art, culture and sports" 1 "Person works in Arts, culture and sports"
label values ACS acs
tab ACS

*Defining variable for People with Sales and Service occupations
gen SSO=0 
replace SSO=1 if (NOCS==7)
label variable SSO "if person in Sales and Services occupations"
label define sso 0 "Person not in sales and services occupation" 1"Person in sales and services occupation"
label values SSO sso
tab SSO   

*Define variable for People with Trades, transport and equipment operators and related occupations
gen TTE=0
replace TTE=1 if (NOCS==8)
label variable TTE "If person in Trades, transport and equipment operator related occupation"
label define tte 0 "Person not in trades, transport.. field" 1 "Person in trades, transport.. field"
label values TTE tte
tab TTE



*Define variable for People with occupation unique to primary industry
gen PRI=0
replace PRI=1 if(NOCS==9)
label variable PRI "If person has occupation unique to primary industry"
label define pri 0 "Person not in industry unique work" 1 "Person in industry unique work"
label values PRI pri

*dropping not available and not applicable values
drop if (NOCS==11|NOCS==12)
*Summary of dependent and independent variables

sum ( WAGE LWAGE NEWF PEI NS NB QB ONT MN SKW ALB ENG FRN  MALE MARR AGE60_64 AGE55_59 AGE50_54 AGE45_49 AGE40_44  AGE30_34 AGE25_29 AGE20_24 AGE18_19 AGE15_17 c.YIM##c.YIM LOCED DEDUC HEDUC UEDUC ADEDUC i.MVM##i.IMMG AB i.VMN##i.IMMG i.JP##i.IMMG i.KO##i.IMMG i.W_A##i.IMMG i.SE_A##i.IMMG i.ARB##i.IMMG i.LA##i.IMMG i.FLP##i.IMMG i.BL##i.IMMG i.CHI##i.IMMG i.S_A##i.IMMG  PRI TTE SSO ACS PUB HELT SCI BFA MANG)


<<<<<<< HEAD
*4 decimal places as when some variables are converted into percentage 2 decimals seem a good idea.
 set cformat %9.4f

 
 
 
 
 *Regression model with all visible minorities as group without controlling for factors other than IMMG and Gender
reg LWAGE MALE ALLVMIN IMMG
=======
**NEW
>>>>>>> 365254caaa43135a34a07df4d45ed5e287c00a3f

reg LWAGE MALE i.ALLVMIN##i.IMMG
 
 

 
*  Regression model

reg LWAGE NEWF PEI NS NB QB ONT MN SKW ALB ENG FRN MALE MARR AGE60_64 AGE55_59 AGE50_54 AGE45_49 AGE40_44  AGE30_34 AGE25_29 AGE20_24 AGE18_19 AGE15_17  c.YIM##c.YIM IMMG LOCED DEDUC HEDUC UEDUC ADEDUC MVM AB VMN JP KO  W_A SE_A ARB LA FLP BL CHI S_A  PRI TTE SSO ACS PUB HELT SCI BFA MANG

 
reg LWAGE NEWF PEI NS NB QB ONT MN SKW ALB ENG FRN MALE MARR AGE60_64 AGE55_59 AGE50_54 AGE45_49 AGE40_44  AGE30_34 AGE25_29 AGE20_24 AGE18_19 AGE15_17  c.YIM##c.YIM LOCED DEDUC HEDUC UEDUC ADEDUC i.MVM##i.IMMG AB i.VMN##i.IMMG i.JP##i.IMMG i.KO##i.IMMG i.W_A##i.IMMG i.SE_A##i.IMMG i.ARB##i.IMMG i.LA##i.IMMG i.FLP##i.IMMG i.BL##i.IMMG i.CHI##i.IMMG i.S_A##i.IMMG  PRI TTE SSO ACS PUB HELT SCI BFA MANG

 *Location of educaation and IMMG  interaction
reg LWAGE NEWF PEI NS NB QB ONT MN SKW ALB ENG FRN MALE MARR AGE60_64 AGE55_59 AGE50_54 AGE45_49 AGE40_44  AGE30_34 AGE25_29 AGE20_24 AGE18_19 AGE15_17  c.YIM##c.YIM i.IMMG##LOCED DEDUC HEDUC UEDUC ADEDUC MVM AB VMN JP KO W_A SE_A ARB LA FLP BL CHI S_A  PRI TTE SSO ACS PUB HELT SCI BFA MANG

 

 
 
 
 

 
 
  *grouping for all minorities but aborginal and whites
 gen VNNO=0
 replace VNNO=1 if inrange(VISMIN,1,12)
label variable VNNO "All ethnicities apart from white and Aborignal"
label define vnno 0 "white nor aborginal" 1 "Not white or Aboriginal"
label values VNNO vnno 
 
 
 
* Further Exploring Aboriginal Ethnicity with education level
 reg LWAGE NEWF PEI NS NB QB ONT MN SKW ALB ENG FRN  MALE MARR AGE60_64 AGE55_59 AGE50_54 AGE45_49 AGE40_44  AGE30_34 AGE25_29 AGE20_24 AGE18_19 AGE15_17 c.YIM##c.YIM LOCED i.AB##i.DEDUC i.AB##i.HEDUC i.AB##i.UEDUC i.AB##i.ADEDUC i.VNNO##i.DEDUC i.VNNO##i.HEDUC i.VNNO##i.UEDUC i.VNNO##i.ADEDUC  PRI TTE SSO ACS PUB HELT SCI BFA MANG

 
*grouping for all minorities but WA and whites
gen NVM=0
replace NVM=1 if(inrange(VISMIN,1,7)|inrange(VISMIN,9,12)|AB==1)
label variable NVM "All ethnicities apart from white and West Asian"
label define nvm 0 "white or West Asian" 1 "Not White nor West Asian"
label values NVM nvm
 
  *Further Exploring West Asian minorities Ethnicity with education level
 reg LWAGE NEWF PEI NS NB QB ONT MN SKW ALB ENG FRN MALE MARR AGE60_64 AGE55_59 AGE50_54 AGE45_49 AGE40_44  AGE30_34 AGE25_29 AGE20_24 AGE18_19 AGE15_17 c.YIM##c.YIM IMMG LOCED i.W_A##i.DEDUC i.W_A##i.HEDUC i.W_A##i.UEDUC i.W_A##i.ADEDUC  i.NVM##i.DEDUC i.NVM##i.HEDUC i.NVM##i.UEDUC i.NVM##i.ADEDUC  PRI TTE SSO ACS PUB HELT SCI BFA MANG


 *I used eststo for storing regressions however not in this file
 *esttab using table5.rtf, se nobaselevels label
 

 



  



