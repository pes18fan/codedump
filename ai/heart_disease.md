---
jupyter:
  jupytext:
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.3'
      jupytext_version: 1.19.5
  kernelspec:
    display_name: Python 3 (ipykernel)
    language: python
    name: python3
---

# Heart Disease Prediction via Logistic Regression

First we grab the dataset from Kaggle.

```python
import kagglehub
from kagglehub import KaggleDatasetAdapter

file_path = "Heart_Disease_Prediction.csv"

df = kagglehub.dataset_load(
  KaggleDatasetAdapter.PANDAS,
  "neurocipher/heartdisease",
  file_path
)

df.head()
```

The dataset consists of information on a number of patients, followed by the "Heart Disease" column that indicates whether the patient has or doesn't have heart disease.

```python
df.shape
```

Dataset consists of 270 patients with 14 pieces of information on each. Next we need to ensure there are no missing values.

```python
df.describe()
```

Every column has a `count` of 270, and as `count` only counts non-NaN values, there are no missing values.

```python
labels_str = df["Heart Disease"]
labels_str
```

This is the target variable, and while it appears to be binary it is a string rather than a binary number, so we need to convert it to that.

```python
labels = labels_str.map({'Absence': 0, 'Presence': 1})
labels.head()
```

We now need to ensure "Presence" and "Absence" were indeed the only possible values for "Heart Disease".

```python
labels.unique()
```

This confirms `labels` is binary, so we can move on.


## Logistic Regression with One Input Feature

For this purpose we will choose the feature "Cholesterol". This is because abnormal levels of cholesterol is known to be a fairly well known indicator of cardiovascular issues.

```python
features = df["Cholesterol"]
features.head()
```

```python
x = features
y = labels
```

The features and labels have been chosen. Now, we move to picking the algorithm.


For this purpose, **Logistic Regression** is a good choice. This is because logistic regression is specifically designed for classifying and fitting data into specific containers by transformation using a logistic function.

```python
from sklearn.linear_model import LogisticRegression
```

One important step that should be performed now is feature scaling. Scaling is necessary to tame outliers, because those outliers would otherwise dominate the decision-making of the model and increase inaccuracy dramatically. For this purpose we will use the `StandardScaler` provided by `sklearn`.

```python
from sklearn.preprocessing import StandardScaler
scaler = StandardScaler()
```

```python
import pandas as pd
```

```python
standardized_data = pd.DataFrame(scaler.fit_transform(x.values.reshape(-1,1)), columns=['cholesterol'])
standardized_data.head()
```

We now split the data such that some of it is used for training and the rest for testing. We will be using 20% of the data for testing and the rest to train.

```python
from sklearn.model_selection import train_test_split
```

```python
x_train, x_test, y_train, y_test = train_test_split(standardized_data, y, test_size=0.2, shuffle=True, random_state=42)
print("x_train shape", x_train.shape)
print("x_test shape:", x_test.shape)
print("y_train shape:", y_train.shape)
print("y_test shape:", y_test.shape)
```

Now we need to pick a loss function to tell the algorithm how to perform the learning. We will use the log-loss function, which is the default for scikit-learn (so we don't need to explicitly pick it).

The log loss function is a function that measures the divergence of the predicted probability with the actual labels. The less the output of this function, the better the model. For a hypothetical perfect model, the log loss = 0.

```python
model = LogisticRegression(random_state=42).fit(x_train, y_train)
```

The model has been trained. We can now see how well it does.

```python
scores = model.score(x_test, y_test)
scores
```

The score is around 0.611 which indicates the model got 61.1% of its predictions correct.

```python
pred_labels = model.predict(x_test)
```

```python
from sklearn.metrics import confusion_matrix

cm = confusion_matrix(y_test, pred_labels)
print(cm)
```

According to the confusion matrix, we can see that the model got 28 positive diagnoses right and 5 negative diagnoses correct, but had 16 false negatives and 5 false positives.

We can find further information by calculating the F1 score, recall, precision and accuracy.

```python
from numpy import mean, std
from sklearn.metrics import accuracy_score, precision_score, recall_score, f1_score
```

```python
from sklearn.metrics import classification_report

f1 = f1_score(y_test, pred_labels)
recall = recall_score(y_test, pred_labels)
precision = precision_score(y_test, pred_labels)

f1_avg = mean(f1_score(y_test, pred_labels, average=None))
recall_avg = mean(recall_score(y_test, pred_labels, average=None))
precision_avg = mean(precision_score(y_test, pred_labels, average=None))

f1_sd = std(f1_score(y_test, pred_labels, average=None))
recall_sd = std(recall_score(y_test, pred_labels, average=None))
precision_sd = std(precision_score(y_test, pred_labels, average=None))

print('\nf1:\t\t',f1)
print('recall\t\t',recall)
print('precision\t',precision)

print('\nf1_avg:\t\t',f1_avg)
print('recall_avg\t',recall_avg)
print('precision_avg\t',precision_avg)

print('\nf1_sd:\t\t',f1_sd)
print('recall_sd\t',recall_sd)
print('precision_sd\t',precision_sd)

print('\n',classification_report(y_test, pred_labels))
```

The precision of 0.5 implies the level of usefulness of the results, which is not particularly high.

The recall of 0.24 is especially poor and implies the results are not very complete; however the class of data in the binary value 0 (negatives) have a significantly higher recall of 0.85.

The F1 score is a score that denotes the overall effect of the precision and recall. In this case, the F1 score is 0.32, implying poor performance in both cases.

We can also use cross-validation to get even more accurate numbers without the risk of overfitting on the test data.

```python
from sklearn.model_selection import cross_val_predict

model = LogisticRegression(random_state=42)

cv_pred_labels = cross_val_predict(model, standardized_data, labels, cv=10)
```

```python
accuracy = accuracy_score(labels, cv_pred_labels)

cm = confusion_matrix(labels, cv_pred_labels)

f1 = f1_score(labels, cv_pred_labels)
recall = recall_score(labels, cv_pred_labels)
precision = precision_score(labels, cv_pred_labels)

f1_avg = mean(f1_score(labels, cv_pred_labels, average=None))
recall_avg = mean(recall_score(labels, cv_pred_labels, average=None))
precision_avg = mean(precision_score(labels, cv_pred_labels, average=None))

f1_sd = std(f1_score(labels, cv_pred_labels, average=None))
recall_sd = std(recall_score(labels, cv_pred_labels, average=None))
precision_sd = std(precision_score(labels, cv_pred_labels, average=None))

print('accuracy:\t', accuracy)

print(cm)

print('\nf1:\t\t',f1)
print('recall\t\t',recall)
print('precision\t',precision)

print('\nf1_avg:\t\t',f1_avg)
print('recall_avg\t',recall_avg)
print('precision_avg\t',precision_avg)

print('\nf1_sd:\t\t',f1_sd)
print('recall_sd\t',recall_sd)
print('precision_sd\t',precision_sd)

print('\n',classification_report(labels, cv_pred_labels))
```

This provides a final accuracy of 0.54.

Notably, the recall and precision is even lower.

Overall, only using one input feature seems to provide poor results. Theoretically, having multiple features fixes this issue, which we shall test next.


## Logistic Regression with Multiple Input Features

We will now use all the features except for "Heart Disease" which is the label, as the input features.

```python
features = df[df.columns.difference(["Heart Disease"])]
features.head()
```

```python
x = features
```

We now follow similar steps as followed in the single feature form to create the model.

```python
standardized_data = pd.DataFrame(scaler.fit_transform(x), columns=["age", "bp", "chest pain type", "cholesterol",
                                                                   "ekg results", "exercise angina", "fbs over 120",
                                                                   "max hr", "number of vessels fluro", "st depression",
                                                                   "sex", "slope of st", "thallium"])
standardized_data.head()
```

```python
x_train, x_test, y_train, y_test = train_test_split(standardized_data, y, test_size=0.2, shuffle=True, random_state=42)
print("x_train shape", x_train.shape)
print("x_test shape:", x_test.shape)
print("y_train shape:", y_train.shape)
print("y_test shape:", y_test.shape)
```

```python
model = LogisticRegression(random_state=42).fit(x_train, y_train)
```

The model is now ready. We can now test to see how well this one does.

```python
scores = model.score(x_test, y_test)
scores
```

Immediately, we can see that the score has shot up to 0.907 from 0.611, indicating this model is significantly better performing.

```python
pred_labels = model.predict(x_test)
```

```python
cm = confusion_matrix(y_test, pred_labels)
print(cm)
```

The confusion matrix tells a similar story; there are very few false positives and false negatives and a lot of correct predictions.

Now we prepare the full classification report.

```python
from sklearn.metrics import classification_report

f1 = f1_score(y_test, pred_labels)
recall = recall_score(y_test, pred_labels)
precision = precision_score(y_test, pred_labels)

f1_avg = mean(f1_score(y_test, pred_labels, average=None))
recall_avg = mean(recall_score(y_test, pred_labels, average=None))
precision_avg = mean(precision_score(y_test, pred_labels, average=None))

f1_sd = std(f1_score(y_test, pred_labels, average=None))
recall_sd = std(recall_score(y_test, pred_labels, average=None))
precision_sd = std(precision_score(y_test, pred_labels, average=None))

print('\nf1:\t\t',f1)
print('recall\t\t',recall)
print('precision\t',precision)

print('\nf1_avg:\t\t',f1_avg)
print('recall_avg\t',recall_avg)
print('precision_avg\t',precision_avg)

print('\nf1_sd:\t\t',f1_sd)
print('recall_sd\t',recall_sd)
print('precision_sd\t',precision_sd)

print('\n',classification_report(y_test, pred_labels))
```

We can see that the evaluation metrics have significantly increased in values, implying far better performance.


Using cross-validation for better accuracy,

```python
model = LogisticRegression(random_state=42)

cv_pred_labels = cross_val_predict(model, standardized_data, labels, cv=10)
```

```python
accuracy = accuracy_score(labels, cv_pred_labels)

cm = confusion_matrix(labels, cv_pred_labels)

f1 = f1_score(labels, cv_pred_labels)
recall = recall_score(labels, cv_pred_labels)
precision = precision_score(labels, cv_pred_labels)

f1_avg = mean(f1_score(labels, cv_pred_labels, average=None))
recall_avg = mean(recall_score(labels, cv_pred_labels, average=None))
precision_avg = mean(precision_score(labels, cv_pred_labels, average=None))

f1_sd = std(f1_score(labels, cv_pred_labels, average=None))
recall_sd = std(recall_score(labels, cv_pred_labels, average=None))
precision_sd = std(precision_score(labels, cv_pred_labels, average=None))

print('accuracy:\t', accuracy)

print(cm)

print('\nf1:\t\t',f1)
print('recall\t\t',recall)
print('precision\t',precision)

print('\nf1_avg:\t\t',f1_avg)
print('recall_avg\t',recall_avg)
print('precision_avg\t',precision_avg)

print('\nf1_sd:\t\t',f1_sd)
print('recall_sd\t',recall_sd)
print('precision_sd\t',precision_sd)

print('\n',classification_report(labels, cv_pred_labels))
```

The final accuracy here is 0.84, far higher than when using only one input feature.

The precision and recall are also significantly higher at 0.84 and 0.79 respectively, indicating that the results are both quite useful and also have a high level of completeness.
