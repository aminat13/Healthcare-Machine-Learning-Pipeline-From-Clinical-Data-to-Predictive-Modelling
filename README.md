# Healthcare Machine Learning Pipeline: From Clinical Data to Predictive-Modelling

## Overview

This project applies statistical modelling and machine learning techniques to real-world healthcare datasets. The aim is to evaluate treatment effectiveness, construct a real-world evidence (RWE) cohort, and build predictive models for disease classification.

The project is divided into three sections:

- Statistical modelling / inference
- Data engineering / cohort design
- Supervised ML classification

## Key Skills Demonstrated
- Exploratory Data Analysis (EDA)
- Logistic & Linear Regression (R)
- Clinical interpretation of statistical models
- Cohort design using ICD-10 and ATC codes
- Decision Trees (rpart)
- Random Forests (ensemble learning)
- Model evaluation (confusion matrix, balanced accuracy)
- Feature importance analysis

## Section 1 – Clinical Data Analysis

Using a randomized controlled trial dataset on acupuncture for chronic headaches:

### Methods:
- Exploratory Data Analysis (EDA)
- Logistic regression (treatment response ≥35%)
- Interaction models (migraine status, sex)
- Linear regression (health score & medication change)

### Key Findings:
- Acupuncture significantly increased odds of treatment response (OR ≈ 2.48)
- No significant interaction with migraine status or sex
- Trends toward improved general health and reduced medication use (not statistically significant)

## Section 2 – RWE Cohort Construction

A rule-based pipeline was designed to construct a patient cohort using:

- ICD-10 codes → Alzheimer’s disease (G30)
- ATC codes → Anti-dementia drugs (N06D)
- Age filtering → 40–80 years
- Exclusion criteria → Non-Alzheimer’s dementia (F01–F03)

This simulates real-world evidence cohort building using structured healthcare data.

## Section 3 – Machine Learning Models

### Models & Performance

| Model           | Description              | Balanced Accuracy |
|----------------|--------------------------|------------------|
| Decision Tree  | rpart classification tree | ~0.897           |
| Random Forest  | 100-tree ensemble model   | ~0.925           |

### Key Insights:
- Random forest outperformed decision tree due to reduced overfitting
- Important features included tumour size and shape-related metrics
- Boundary irregularity (e.g., concave points) was highly predictive of malignancy

## Technologies Used
- R (primary language)
- Packages: readxl, dplyr, rpart, randomForest, psych
- (conceptual cohort construction)

## Learning Outcomes

This project demonstrates:

- Application of machine learning in healthcare settings
- Interpretation of statistical models in a clinical context
- Understanding of model performance and limitations
- Integration of domain knowledge with data science techniques

## Limitations
- Limited sample size reduced statistical power in some models
- Missing follow-up data impacted analysis
- No hyperparameter tuning performed for models
