# Code to generate the figures in: Clinical Characteristics of Bronchopulmonary Dysplasia and the Risk of Sepsis Onset Prediction via Machine Learning Models 

This is the R and python code needed to repeat the analysis in the manuscript:

R version 4.1.3 and python version 3.8.2 was used to run all of this code. 
# Missing data
To filter for missing data, the missing data module in Python 3.9.12 software was used.

# ML Classification Algorithms

Binary classifications were carried out in Python using scikit-learn (v0.24.1). Ten ML algorithms were implemented to distinguish sepsis patients from BPD individuals(Logistic Regression (LR), Random Forest (RF), Support Vector Machine (SVM), Decision Tree (DTREE), Ada Boost (ADB), Gaussian Naïve Bayes (NB), Linear Discriminant Analysis (LDA), k Nearest Neighbors (KNN), and Gradient Boosting Classifier (GB)),and multilayer perceptron (MLP). The synthetic minority oversampling technique (SMOTE) expands the number of samples in a minority class to ensure equal representation among groups in ML. The bootstrap method was used 1000 times for internal validation. The performance of each algorithm was assessed on the basis of average sensitivity, specificity, the mean area under the receiver operating characteristic (ROC) curve, and the mean F1 of the resampled samples 1000 times for pediatric patients with combined septic and nonseptic BPD. Receiver operating characteristic (ROC) was plotted using the matplotlib library (version 3.3.4) in Python were drawn as part of the internal validation process. 


 SHAP Value Calculation    
The precise contribution (magnitude and direction) of the feature output by each classifier was determined using Shapley additive explanations (SHAPs). The SHAP values were calculated using RF algorithm for each classifier. SHAP summary plots were visualized in Python using the Sharp library (version 0.39.0).


# Nomogram,DCA and CIC 

Nomogram charts (rms package) were drawn using the selected risk factors. The concordance statistic (C statistic) and calibration curve (rms package) were used to distinguish and calibrate the nomograms. The DCA curve and CIC (ggDCA package) were used to determine the effectiveness evaluation and evaluate the clinical applicability of the risk prediction nomogram. Statistical analyses were performed via R software.
