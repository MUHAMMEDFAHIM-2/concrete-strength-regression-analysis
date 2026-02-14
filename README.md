# 📊 Statistical Consultancy Report  
## Predicting Concrete Compressive Strength Using Regression & ANOVA in R

This project presents a full statistical consultancy analysis conducted in **R** to model and interpret the factors affecting **concrete compressive strength**.

The analysis follows a structured consultancy workflow:

> Data Cleaning → Exploratory Analysis → Hypothesis Testing → Regression Modelling → Diagnostics → Interpretation

---

## 📁 Repository Structure

├── Task 2.R

├── STATISTICAL CONSULTANCY REPORT.pdf

└── README.md


- **Task 2.R** – Complete R script used for data cleaning, modelling, and diagnostics  
- **STATISTICAL CONSULTANCY REPORT.pdf** – Detailed written consultancy report  

---

## 🎯 Objective

To:

- Identify key predictors of compressive strength  
- Test whether fly ash significantly impacts strength  
- Evaluate model assumptions and statistical validity  
- Provide interpretable conclusions for engineering decision-making  

---

## 📊 Dataset Overview

- 1,030 observations  
- 11 variables  
- 25 duplicate rows removed  
- Final dataset: 1,005 observations  

### Key Variables
- Cement
- Slag
- Fly Ash
- Water
- Superplasticizer
- Coarse Aggregate
- Fine Aggregate
- Age
- ContainsFlyAsh (categorical)
- Strength (MPa) – Target variable

---

## 🔎 Exploratory Data Analysis

Key findings:

- Strength ranged from 2.33 MPa to 82.6 MPa  
- Mean ≈ 35 MPa  
- Cement and Age positively correlated with strength  
- Water negatively correlated with strength  
- Moderate multicollinearity observed among cement-related components  

Visual tools used:
- Correlation heatmap  
- Scatter plots  
- Histograms  
- Q–Q plots  
- Boxplots  

---

## 🧪 Hypothesis Testing

### 1️⃣ One-Way ANOVA (Fly Ash Effect)

- p-value > 0.05  
- No statistically significant difference in strength between mixes with and without fly ash  

### 2️⃣ Two-Way ANOVA (Fly Ash × Age Group)

- Age → Highly significant  
- Fly Ash → Not significant  
- Interaction → Not significant  

Conclusion:  
Curing age significantly affects compressive strength; fly ash does not show significant impact in this dataset.

---

## 📈 Regression Modelling

### Data Transformation
- Log transformation applied to Strength (to address right skewness)

---

### 🔹 Full Model

Predictors:
- Cement
- Slag
- FlyAsh
- Water
- Superplasticizer
- CoarseAgg
- FineAgg
- Age

**Model Fit:**
- R² ≈ 0.54  
- Adjusted R² ≈ 0.54  
- Overall model significant (p < 0.001)

Significant predictors:
- Cement (+)
- Slag (+)
- FlyAsh (+)
- Water (−)
- Superplasticizer (+)
- Age (+)

---

### 🔹 Reduced Model (More Interpretable)

Predictors:
- Cement
- Water
- Superplasticizer
- Age

**Model Fit:**
- R² ≈ 0.44  
- Adjusted R² ≈ 0.44  

Although less predictive, this model is more practical and interpretable for applied settings.

---

## 🔬 Model Diagnostics

Performed:

- Shapiro–Wilk test  
- Kolmogorov–Smirnov test  
- Variance Inflation Factor (VIF)  
- Breusch–Pagan test  
- Durbin–Watson test  
- Residual analysis  

Findings:

- Moderate multicollinearity  
- Presence of heteroscedasticity  
- Mild positive autocorrelation  
- Residuals approximately normal in central region  

Despite assumption violations (common in large samples), the model remains stable and informative.

---

## 📌 Key Insights

- Cement content and curing age are dominant predictors of strength.  
- Water content negatively impacts compressive strength.  
- Fly ash does not show statistically significant influence in this dataset.  
- A simplified regression model provides strong interpretability with reasonable predictive power.

---

## 🛠 Tools Used

- R  
- readxl  
- dplyr  
- ggplot2  
- corrplot  
- car  
- lmtest  

---

## 📄 Full Report

See detailed methodology, statistical output, and visualisations in:

`STATISTICAL CONSULTANCY REPORT.pdf`

---

## 👤 Author

Muhammed Fahim Englampurath  
MSc Data Science — University of Salford  

GitHub: https://github.com/MUHAMMEDFAHIM-2  
LinkedIn: https://www.linkedin.com/in/muhammed-fahim-03209b1bb/
