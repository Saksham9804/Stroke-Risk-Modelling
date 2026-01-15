
use "C:\Users\User\Desktop\project\3_LASI_W1_Individual.dta"



encode state, gen(states)

g wt = indiaindividualweight

*education
gen edu = .
replace edu = 0 if dm006 == 2
recode dm008 (1/3 = 1 "Less than secondary school")(4 5 = 2 "Secondary and Higher Secondary")(6/9 = 3 "Graduate School"), gen(educate)
replace edu = 1 if educate == 1
replace edu = 2 if educate == 2
replace edu = 3 if educate == 3
recode edu (0 = 0 "No Education")(1 = 1 "Less than Secondary")(2 = 2 "Secondary and Higher Secondary")(3 = 3 "Graduate"), gen(education)

*marital status
recode dm021 (1 = 1 "Currently Married")(2/7 = 2 "Not Currently Married"), gen(marital_status)

*living arrangement
recode living_arrangements (1 = 1 "Alone")(3 = 2 "With Family")(2 4 = 3 "With Family and/or others")(5 = 4 "With Others"), gen(living_arrangement)

*Sex
recode dm003 (1 = 1 "Male")(2 = 0 "Female"), gen(sex)

*caste
recode dm013 (4 = 1 "Others")(3 = 2 "OBC")(1 = 3 "SC")(2 = 4 "ST"), gen(caste)

*region
recode stateid (1/8=1 "North") (9 22 23=2 "Central") (10 19 20 21=3 "East") (11/18=4 "North East") (24/27=5 "West") (28/36=6 "South"), gen(region)

*age group
recode dm005 (min/44 = 1 "<45")(45/49 = 2 "45-49")(50/54 = 3 "50-54")(55/59 = 4 "55-59")(60/64 = 5 "60-64")(65/69 = 6 "65-69")(70/74 = 7 "70-74")(75/max = 8 "75+"), gen(age_grp)

*religion: Hindu/Muslim/Others
recode dm010 (2 = 1 "Hindu")(3 = 2 "Muslim")(4 = 3 "Christian")(else = 4 "Others"), gen(religion)

*alcohal
recode hb101 (2 = 0 "Never")(1 = 1 "Yes"), gen(alc_use)

*Tobacco
recode hb001 (2 = 1 "Never Used")(else = .), gen(never_use)

gen past_smoke = .
replace past_smoke = 1 if hb003_a == 2

gen past_slt = .
replace past_slt = 1 if hb006 == 2

recode hb003_a (1 = 1 "Currently Smoking")(else = .), gen(currently_smoking)
recode hb006 (1 = 1 "Currently SLT")(else = .), gen(curr_slt)

gen tob_used = .
replace tob_used = 0 if never_use == 1
replace tob_used = 1 if past_smoke == 1
replace tob_used = 2 if past_slt == 1
replace tob_used = 3 if currently_smoking == 1
replace tob_used = 4 if curr_slt == 1

recode tob_used (0 = 0 "Never Used")(1 = 1 "Past Smoke")(2 = 2 "Past SLT")(3 = 3 "Current Smoke")(4 = 4 "Current Current SLT"), gen(tob_use)

*Physical Activity:
recode hb214 (min/149 = 0 "No")(150/max = 1 "Yes"), gen(mod_act)
recode hb212 (min/74 = 0 "No")(75/max = 1 "Yes"), gen(vig_act)

g phact = 0 if hb211 == 5 & hb213 == 5
replace phact = 1 if mod_act == 0 | vig_act == 0
replace phact = 2 if mod_act == 1
replace phact = 3 if vig_act == 1
recode phact (0 = 0 "Physically Inactive")(1 = 1 "Physically Active")(2 = 2 "Moderately Active")(3 = 3 "Vigorously Active"), gen(phy_act)

*Working Status
g w = .
replace w = 0 if we001 == 2
replace w = 1 if we004 == 2
replace w = 2 if we004 == 1
recode w (0 = 0 "Never Worked")(1 = 1 "Not Currently Working")(2 = 2 "Currently Working"), g(work_status)


**** ADL limitations ***

recode ht401 (1=1 "Yes") (else=0 "No"), gen (ht401r)
recode ht402 (1=1 "Yes") (else=0 "No"), gen (ht402r)
recode ht403 (1=1 "Yes") (else=0 "No"), gen (ht403r)
recode ht404 (1=1 "Yes") (else=0 "No"), gen (ht404r)
recode ht405 (1=1 "Yes") (else=0 "No"), gen (ht405r)
recode ht406 (1=1 "Yes") (else=0 "No"), gen (ht406r)

egen adl = rowtotal(ht401r-ht406r)
recode adl(0=0 "No ADL limitation") (1=1 "One ADL limitation") (2/13=2 "Two+ ADL limitations"), gen(adll)
tab adll [aw=indiaindividualweight], m

**** IADL limitations ***

recode ht407 (1=1 "Yes") (else=0 "No"), gen (ht407r)
recode ht408 (1=1 "Yes") (else=0 "No"), gen (ht408r)
recode ht409 (1=1 "Yes") (else=0 "No"), gen (ht409r)
recode ht410 (1=1 "Yes") (else=0 "No"), gen (ht410r)
recode ht411 (1=1 "Yes") (else=0 "No"), gen (ht411r)
recode ht412 (1=1 "Yes") (else=0 "No"), gen (ht412r)
recode ht413 (1=1 "Yes") (else=0 "No"), gen (ht413r)

egen iadl = rowtotal(ht407r-ht413r)

recode iadl (0=0 "No IADL limitation") (1=1 "One IADL limitation") (2/13=2 "Two+ IADL limitations"), gen(iadll)


recode ht002 (2 = 0 "No")(1 = 1 "Yes"), gen(hypertension)
recode ht003 (2 = 0 "No")(1 = 1 "Yes"), gen(diabetes)
recode ht004 (2 = 0 "No")(1 = 1 "Yes"), gen(cancer)
recode ht005 (2 = 0 "No")(1 = 1 "Yes"), gen(lung_disease)
recode ht006 (2 = 0 "No")(1 = 1 "Yes"), gen(heart_disease)
recode ht007 (2 = 0 "No")(1 = 1 "Yes"), gen(stroke)
recode ht008 (2 = 0 "No")(1 = 1 "Yes"), gen(bone_disease)
recode ht009 (2 = 0 "No")(1 = 1 "Yes"), gen(neuro_disease)
recode ht010 (2 = 0 "No")(1 = 1 "Yes"), gen(cholesterol)

*correlation matrix 

correlate stroke diabetes age sex education mpce_quintile caste religion work_status phy_act alc_use tob_use hypertension cancer lung_disease heart_disease bone_disease neuro_disease cholesterol
*heatplot
correlate diabetes age sex education mpce_quintile caste religion work_status phy_act alc_use tob_use hypertension cancer lung_disease heart_disease bone_disease neuro_disease cholesterol
matrix C = r(C)
heatplot C, values(format(%4.2f) color(white) size(vsmall)) xlabel(, angle(45) labsize(small)) ylabel(, labsize(small)) legend(on) aspectratio(1)






*vif if linear regression 
reg stroke diabetes age sex education mpce_quintile caste religion work_status phy_act alc_use tob_use hypertension cancer lung_disease heart_disease bone_disease neuro_disease cholesterol
estat vif

*unadjusted logistic
logistic stroke diabetes
estat ic 


*LOGISTIC REGRESSION RESULTS 
logistic stroke i.diabetes i.age i.sex i.education i.mpce_quintile i.caste i.religion i.work_status i.phy_act i.alc_use i.tob_use i.hypertension i.cancer i.lung_disease i.heart_disease i.bone_disease i.neuro_disease i.cholesterol 

*AIC BIC 
estat ic

*LOGISTIC MODEL FITTING 

set seed 12345
gen group = uniform()
sort group
gen sample = 1 if group <= 0.7 
replace sample = 2 if group > 0.7

logistic stroke i.diabetes i.age i.sex i.education i.mpce_quintile i.caste i.religion i.work_status i.phy_act i.alc_use i.tob_use i.hypertension i.cancer i.lung_disease i.heart_disease i.bone_disease i.neuro_disease i.cholesterol if sample==1


predict p_train if sample == 1, pr 
predict p_test if sample == 2, pr
lroc if sample == 1
lroc if sample == 2

*LASSO REGRESSION RESULTS BIC 
lasso logit stroke i.diabetes i.age i.sex i.education i.mpce_quintile i.caste i.religion i.work_status i.phy_act i.alc_use i.tob_use i.hypertension i.cancer i.lung_disease i.heart_disease i.bone_disease i.neuro_disease i.cholesterol,selection(bic)
*LASSO COEFFICIENT 
matrix list e(b)

*LASSO REGRESSION RESULTS AIC 
lasso logit stroke i.diabetes i.age i.sex i.education i.mpce_quintile i.caste i.religion i.work_status i.phy_act i.alc_use i.tob_use i.hypertension i.cancer i.lung_disease i.heart_disease i.bone_disease i.neuro_disease i.cholesterol,selection(aic)

*RIDGE REGRESSION 
elasticnet logit stroke i.diabetes i.age i.sex i.education i.mpce_quintile i.caste i.religion i.work_status i.phy_act i.alc_use i.tob_use i.hypertension i.cancer i.lung_disease i.heart_disease i.bone_disease i.neuro_disease i.cholesterol,alpha(0) selection(bic)

*ridge coeff
matrix list e(b)

*RIDGE  REGRESSION RESULTS AIC
elasticnet logit stroke i.diabetes i.age i.sex i.education i.mpce_quintile i.caste i.religion i.work_status i.phy_act i.alc_use i.tob_use i.hypertension i.cancer i.lung_disease i.heart_disease i.bone_disease i.neuro_disease i.cholesterol,alpha(0) selection(aic)
*elastic net BIC 
elasticnet logit stroke i.diabetes i.age i.sex i.education i.mpce_quintile i.caste i.religion i.work_status i.phy_act i.alc_use i.tob_use i.hypertension i.cancer i.lung_disease i.heart_disease i.bone_disease i.neuro_disease i.cholesterol,selection(bic)

*elastic net  coeff
matrix list e(b)

*elastic net AIC
elasticnet logit stroke i.diabetes i.age i.sex i.education i.mpce_quintile i.caste i.religion i.work_status i.phy_act i.alc_use i.tob_use i.hypertension i.cancer i.lung_disease i.heart_disease i.bone_disease i.neuro_disease i.cholesterol,selection(aic)








*unadjusted logistic
logistic stroke diabetes

*model selection 
estat ic

*adjusted logistic unadjusted logistic 
logistic stroke diabetes age sex education mpce_quintile caste religion work_status phy_act alc_use tob_use hypertension cancer lung_disease heart_disease bone_disease neuro_disease cholesterol

*model selection adjusted logistic
estat ic

*lasso 
lasso logit  stroke diabetes age sex education mpce_quintile caste religion work_status phy_act alc_use tob_use hypertension cancer lung_disease heart_disease bone_disease neuro_disease cholesterol

*lasso coeff

matrix list e(b)

*Check for missing values
count if missing(sleep_qual)
count if missing(age)
count if missing(sex)
count if missing(chronic)
count if missing(education)
count if missing(mpce_quintile)
count if missing(caste)
count if missing(religion)
count if missing(work_status)
count if missing(marital_status)
count if missing(phy_act)
count if missing(alc_use)
count if missing(residence)
count if missing(region)
count if missing(lifesatf)
count if missing(dep_symp)
count if missing(park_visit)
count if missing(adll)
count if missing(iadll)

*Cleaning the data: 42, 170
drop if missing(tob_use, age, sex, education, mpce_quintile, caste, religion, work_status, marital_status, phy_act, alc_use, residence, region, hypertension, diabetes, cancer, lung_disease, heart_disease, stroke, bone_disease, neuro_disease, cholesterol)


*logistic regression

logistic stroke diabetes

logistic stroke diabetes [pw = wt]

logistic stroke i.diabetes i.age i.sex i.education i.mpce_quintile i.caste i.religion i.work_status i.phy_act i.alc_use i.tob_use i.hypertension i.cancer i.lung_disease i.heart_disease i.bone_disease i.neuro_disease i.cholesterol 

*logistic aic bic 
estat ic

*lasso regression aic bic  
lasso logit stroke i.diabetes i.age i.sex i.education i.mpce_quintile i.caste i.religion i.work_status i.phy_act i.alc_use i.tob_use i.hypertension i.cancer i.lung_disease i.heart_disease i.bone_disease i.neuro_disease i.cholesterol,selection(bic)

*lasso coeff
matrix list e(b)

*ridge regrssion aic bic 
elasticnet logit stroke i.diabetes i.age i.sex i.education i.mpce_quintile i.caste i.religion i.work_status i.phy_act i.alc_use i.tob_use i.hypertension i.cancer i.lung_disease i.heart_disease i.bone_disease i.neuro_disease i.cholesterol,alpha(0) selection(bic)

*ridge coeff
matrix list e(b)

*elastic net AIC bic
elasticnet logit stroke i.diabetes i.age i.sex i.education i.mpce_quintile i.caste i.religion i.work_status i.phy_act i.alc_use i.tob_use i.hypertension i.cancer i.lung_disease i.heart_disease i.bone_disease i.neuro_disease i.cholesterol,selection(bic)

*elastic net  coeff
matrix list e(b)


*training and test data 
set seed 12345
gen group = uniform()
sort group
gen sample = 1 if group <= 0.7 
replace sample = 2 if group > 0.7

logistic stroke diabetes age sex education mpce_quintile caste religion work_status phy_act alc_use tob_use hypertension cancer lung_disease heart_disease bone_disease neuro_disease cholesterol if sample==1 

predict p_train if sample == 1, pr 
predict p_test if sample == 2, pr
lroc if sample == 1
lroc if sample == 2

*correlation matrix 
correlate stroke diabetes age sex education mpce_quintile caste religion work_status phy_act alc_use tob_use hypertension cancer lung_disease heart_disease bone_disease neuro_disease cholesterol

*vif if linear regression 
reg stroke diabetes age sex education mpce_quintile caste religion work_status phy_act alc_use tob_use hypertension cancer lung_disease heart_disease bone_disease neuro_disease cholesterol
estat vif






*extracting
keep prim_key hhid stateid state tob_use age sex education mpce_quintile caste religion work_status marital_status phy_act alc_use residence region lifesatf dep_symp adll iadll hypertension diabetes cancer lung_disease heart_disease stroke bone_disease neuro_disease cholesterol 