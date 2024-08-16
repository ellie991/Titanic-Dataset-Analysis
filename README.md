This project analysis is based on a Titanic dataset that includes passenger information such as passenger ID, survival status (0=no, 1=yes), passenger class (1, 2, 3), name, sex, age, ticket number, fare, cabin, and embarkation port. The project's goal is understanding the factors influencing passenger survival rates. The study investigates how survival probabilities are associated with passenger class, age, and sex.
The project leverages R for data processing and model building, employing libraries such as `rpart`, `rpart.plot`, `cluster`, and `randomForest` to conduct the analysis. Through these methods, the project aims to provide insights into the factors that contributed to passenger survival on the Titanic involving data visualization and model building.

- ANALYSIS 1: Survival Based on Class (1, 2, 3)
A decision tree model is used to analyze survival rates across different passenger classes. This helps in visualizing how class affects survival chances.
After importing the two datasets, I created a bar plot to visually represent the distribution of passengers across the three classes. It was observed that the third class has the highest number of passengers, followed by the first and second classes.
The decision tree shows that passengers in higher classes (1 and 2) are more likely to survive compared to those in the lower class (3). So, that means class is a significant factor in predicting survival, with higher-class passengers having greater survival probabilities, possibly due to having access to lifeboats. The model’s accuracy on the training set was 68%.

<img width="572" alt="Screenshot 2024-08-16 alle 13 00 18" src="https://github.com/user-attachments/assets/61a28525-7577-43c8-b976-83d6c6d27f90">
<img width="569" alt="Screenshot 2024-08-16 alle 13 00 38" src="https://github.com/user-attachments/assets/24b3b378-d64b-411f-977e-8e4388debf6e">


- ANALYSIS 2: Survival Based on Age
This includes examining the impact of age on survival and how different age clusters behave.
I performed age clustering using the K-means algorithm after removing rows with missing age data. Age was standardized, and K-means clustering with three clusters was applied. The scatter plot of standardized ages shows clusters of different age groups, with cluster 1 representing younger passengers, cluster 2 middle-aged passengers, and cluster 3 older passengers. A box plot further detailed age distribution within each cluster, highlighting significant outliers in the first cluster.
A second clustering considering both age & fare was done, revealing that clusters were primarily differentiated by fare, with clusters showing a range of fares and ages. The silhouette score, which measures clustering quality, was 0.46, indicating a good clustering fit.

<img width="481" alt="Screenshot 2024-08-16 alle 13 05 20" src="https://github.com/user-attachments/assets/a38675df-f34e-424f-9131-505104d685cb">
<img width="529" alt="Screenshot 2024-08-16 alle 13 06 16" src="https://github.com/user-attachments/assets/8513ddde-8c4d-4dc4-9187-2c7d28940d64">


- ANALYSIS 3: Survival Based on Sex
This analysis explores the relationship between sex and survival using clustering and random forests. It aims to understand how gender influences survival probabilities and to develop predictive models based on sex. Sex was coded numerically (male=0, female=1) and K-means clustering with three clusters was applied. The scatter plot showed that older passengers were predominantly male, as indicated by a noticeable outlier age of 80 years.
The model predicted survival based on sex showing a 79% survival rate for females and 20% for males, showing that female passengers had a higher survival rate compared to males. Random Forest model accuracy: 78%.

<img width="551" alt="Screenshot 2024-08-16 alle 13 07 14" src="https://github.com/user-attachments/assets/330e19ba-3d46-416e-8ece-d38df20fa435">
<img width="525" alt="Screenshot 2024-08-16 alle 13 06 46" src="https://github.com/user-attachments/assets/cdf55257-4e22-4bdd-bd7b-e78fdfeeeee5">

