library(rpart)
library(rpart.plot)
library(cluster)
library(randomForest)

train_data <- read.csv("/Users/elenavaldes/Desktop/train.csv", fileEncoding = "UTF-8")
test_data <- read.csv("/Users/elenavaldes/Desktop/test.csv")


# ANALYSIS 1: Survival Based on Class (1, 2, 3)
# PREDICTION
barplot(table(train_data$Pclass), main = "Numero di passeggeri per classe di viaggio",
        xlab = "Classe di viaggio", ylab = "Numero di passeggeri", col = "blue")

tree_model <- rpart(Survived ~ Pclass, data = train_data, method = "class")
plot(tree_model, uniform = TRUE, main = "Albero di decisione per la sopravvivenza",
     margin = 0.1, branch = 0.6, compress = TRUE)
text(tree_model, use.n = TRUE, all = TRUE, xpd = TRUE, cex = 0.8)
rpart.plot(tree_model)

train_predictions <- predict(tree_model, train_data, type = "class")
train_accuracy <- sum(train_predictions == train_data$Survived) / nrow(train_data)
cat("Accuratezza sull'insieme di addestramento:", train_accuracy, "\n")









# ANALYSIS 2: Survival Based on Age
# CLUSTERING AGE
train_data <- train_data[!is.na(train_data$Age), ]

selected_features <- train_data$Age
scaled_features <- scale(selected_features)

k <- 3
kmeans_model <- kmeans(scaled_features, centers = k)

centroids <- kmeans_model$centers
print(centroids)

cluster_labels <- kmeans_model$cluster
train_data$Cluster <- cluster_labels

mean_age <- mean(train_data$Age)
sd_age <- sd(train_data$Age)

age_interval_1 <- mean_age + (-2 * sd_age)  # da -2 a -1
age_interval_2 <- mean_age + (-1 * sd_age)  # da -1 a 0.5
age_interval_3 <- mean_age + (0.5 * sd_age)  # da 0.5 a 3
cat("Età corrispondenti all'intervallo da -2 a -1:", age_interval_1, "\n")
cat("Età corrispondenti all'intervallo da -1 a 0.5:", age_interval_2, "\n")
cat("Età corrispondenti all'intervallo da 0.5 a 3:", age_interval_3, "\n")

plot(scaled_features, col = cluster_labels, main = "Clustering basato sull'età", xlab = "Osservazioni", ylab = "Età")
points(kmeans_model$centers, col = 1:k, pch = 8, cex = 2)

cluster_counts <- table(cluster_labels)
legend_labels <- paste("Cluster", 1:k, ": ", cluster_counts)
legend("topright", legend = legend_labels, col = 1:k, pch = 16, cex = 1, bty = "n")

boxplot(train_data$Age ~ train_data$Cluster, xlab = "Cluster", ylab = "Età", main = "Distribuzione delle età per cluster")
boxplot_stats <- by(train_data$Age, train_data$Cluster, boxplot.stats)
for (i in 1:length(boxplot_stats)) {
  cat("Cluster", i, "\n")
  cat("Mediana:", boxplot_stats[[i]]$stats[3], "\n")
  cat("Primo quartile:", boxplot_stats[[i]]$stats[2], "\n")
  cat("Terzo quartile:", boxplot_stats[[i]]$stats[4], "\n")
  cat("Valori minimi:", boxplot_stats[[i]]$stats[1], "\n")
  cat("Valori massimi:", boxplot_stats[[i]]$stats[5], "\n")
  cat("\n")
}

# CLUSTERING ETÀ & TARIFFA
train_data <- train_data[!is.na(train_data$Age), ]

selected_features <- train_data[, c("Age", "Fare")]
scaled_features <- scale(selected_features)

k <- 3
kmeans_model <- kmeans(scaled_features, centers = k)

centroids <- kmeans_model$centers
print(centroids)

cluster_labels <- kmeans_model$cluster
train_data$Cluster <- cluster_labels

plot(scaled_features, col = cluster_labels, main = "Clustering dei passeggeri", xlab = "Age", ylab = "Fare")
points(kmeans_model$centers, col = 1:k, pch = 8, cex = 2)

table(train_data$Cluster)

aggregate(selected_features, by = list(Cluster = cluster_labels), FUN = mean)

# SILHOUETTE
dist_matrix <- dist(scaled_features)

silhouette_scores <- silhouette(cluster_labels, dist_matrix)

mean_silhouette <- mean(silhouette_scores[, "sil_width"])
cat("Il coefficiente di Silhouette medio è:", mean_silhouette, "\n")

cluster_avg_silhouette <- tapply(silhouette_scores[, "sil_width"], cluster_labels, mean)

sorted_clusters <- sort(cluster_avg_silhouette, decreasing = FALSE)

barplot(sorted_clusters, horiz = TRUE, main = "Silhouette Plot", xlab = "Coefficienti di Silhouette")

# PREDIZIONE
train_data <- train_data[!is.na(train_data$Age), ]

logistic_model <- glm(Survived ~ Age, data = train_data, family = binomial)

train_predictions <- predict(logistic_model, newdata = train_data, type = "response")
head(train_predictions)

age_intervals <- cut(train_data$Age, breaks = c(0, 10, 20, 30, 40, 50, 60, Inf), include.lowest = TRUE)

mean_predictions <- tapply(train_predictions, age_intervals, mean)

barplot(mean_predictions, main = "Predizioni di sopravvivenza raggruppate per età",
        xlab = "Età", ylab = "Media delle probabilità di sopravvivenza", col = "blue", ylim = c(0, 1))
abline(h = 0.5, lty = 2, col = "red")

train_predictions <- predict(logistic_model, newdata = train_data, type = "response")
predicted_classes <- ifelse(train_predictions >= 0.5, 1, 0)

confusion_matrix <- table(predicted_classes, train_data$Survived)
print(confusion_matrix)

accuracy <- sum(diag(confusion_matrix)) / sum(confusion_matrix)
print(paste("Accuracy:", accuracy))










# ANALYSIS 3: Survival Based on Sex
# CLUSTERING AGE & SEX
train_data <- train_data[complete.cases(train_data$Age, train_data$Sex), ]

train_data$Sex <- ifelse(train_data$Sex == "male", 0, 1)

k <- 3
kmeans_model <- kmeans(train_data[, c("Age", "Sex")], centers = k)
centroids <- kmeans_model$centers
print(centroids)

cluster_labels <- kmeans_model$cluster
train_data$Cluster <- cluster_labels

plot(train_data$Age, train_data$Sex, col = cluster_labels, pch = 16, 
     main = "Clustering basato sull'età e sul sesso", xlab = "Età", ylab = "Sesso")
points(centroids[, "Age"], centroids[, "Sex"], col = 1:k, pch = 8, cex = 2)

# PREDICTION
train_data$Sex <- factor(train_data$Sex)
train_data <- train_data[complete.cases(train_data$Sex, train_data$Survived), ]
train_data$Survived <- factor(train_data$Survived)

rf_model <- randomForest(Survived ~ Sex, data = train_data, ntree = 500)

test_data$Sex <- factor(test_data$Sex, levels = levels(train_data$Sex))
predictions <- predict(rf_model, newdata = test_data)
plot(Survived ~ Sex, data = train_data, main = "Sopravvivenza in base al sesso", xlab = "Sex", ylab = "Survived", col = predictions)
train_predictions <- predict(rf_model, newdata = train_data)

accuracy_train <- sum(train_predictions == train_data$Survived) / length(train_data$Survived)
print(paste("Accuracy sul dataset di addestramento:", accuracy_train))
