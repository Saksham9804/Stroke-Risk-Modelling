# Diabetes and Stroke Risk Analysis using LASI Data

## Project Overview
This project investigates the association between diabetes and stroke risk among older adults in India using data from the Longitudinal Ageing Survey of India (LASI) Wave 1 (2017-18). The analysis employs multiple regression techniques to identify robust predictors of stroke while accounting for sociodemographic, lifestyle, and clinical factors.

## Methodology
The study uses a comprehensive quantitative approach combining:
- **Logistic Regression**: Baseline model for binary stroke outcomes
- **LASSO Regression**: Variable selection to identify key predictors
- **Ridge Regression**: Coefficient stabilization for correlated predictors
- **Elastic Net Regression**: Hybrid approach combining LASSO and Ridge

### Key Features
- Diagnostic checks for multicollinearity (VIF and correlation matrix)
- Model performance evaluation using ROC curves and AUC (training: 81.66%, test: 80.56%)
- Model comparison using AIC and BIC criteria
- Comprehensive analysis of 19 predictors including demographics, lifestyle factors, and chronic conditions

## Key Findings
Individuals with diabetes have **35.5% higher odds** of stroke (OR = 1.36, 95% CI: 1.17-1.56). The analysis identifies consistent and robust predictors across all models:

**Strongest Risk Factors:**
- Hypertension (OR = 3.34) - strongest predictor
- Neurological disease (OR = 3.23)
- Male sex (OR = 1.76)
- Advanced age (75+ years: OR = 2.26)
- Not currently working (OR = 1.54)
- Past smoking (OR = 1.56)
- Heart disease (OR = 1.60)
- High cholesterol (OR = 1.44)

**Protective Factors:**
- Physical activity (vigorous: OR = 0.41)
- Current employment (OR = 0.66)
- Higher education (graduate: OR = 0.74)

## Technologies Used
- **Stata**: Data processing, regression modeling, and statistical analysis
- **LASSO/Ridge/Elastic Net**: Regularization techniques for robust inference
- **ROC Analysis**: Model validation and performance assessment

## Data Source
Longitudinal Ageing Survey of India (LASI), Wave 1: 2017-18  
International Institute for Population Sciences (IIPS) & National Institute on Aging (NIA)

## Model Performance
- Logistic regression achieved the best fit (AIC: 10156.86, BIC: 10523.08)
- No serious multicollinearity detected (all VIF < 10)
- Regularized models (LASSO, Elastic Net) provided consistent results, confirming robustness

## Limitations
- Cross-sectional design limits causal inference
- Self-reported health data may include recall bias
- Data from 2017-18 may not reflect recent trends
- Lacks information on disease duration and severity

## References
Study based on established methodologies from:
- Freijeiro-González et al. (2021) - LASSO variable selection
- Mosenzon et al. (2023) - Diabetes-stroke connections
- Aheto et al. (2021) - Comparative regression approaches

---

*Note: This analysis demonstrates the application of advanced statistical methods for epidemiological research using large-scale survey data.*
