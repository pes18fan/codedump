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

# Estimation of Median House Value using Linear Regression

Firstly, import the dataset.

```python
import pandas as pd

df = pd.read_csv("housing.csv")
df.head()
```

This dataset has information on various houses, with a median house value for
each as well, which we will have as the label to predict the value of.

```python
df.shape
```

There is therefore information on 20,640 houses, with nine features excluding
the target variable (`median_house_value`).

```python
df.describe()
```

Immediately, we see an issue with the data; for the `total_bedrooms` column,
the value of `count` is only 20,433, indicating that the remaining values are
invalid or NaN values. We therefore need to remove all rows containing that
invalid data from the set.

```python
df = df.dropna(subset=["total_bedrooms"])
df.describe()
```

We now have no more invalid values left. However, there is still one issue; the
`ocean_proximity` column has string values rather than numeric, hence we need
to convert the values there to numeric form. Firstly, we need to check what
values it varies between.

```python
df["ocean_proximity"].unique()
```

As the output shows, it is a enum-ish string variable which may be one of five
values. To make this numeric, the best approach would be to use **one-hot
encoding**, which would split this column into five separate ones, where each
one is a binary value that represents if that row uses that particular value.
Essentially, there would be a row each for `"NEAR BAY"`, `"<1H OCEAN"`, and the
three others, each column can have a value of 1 or 0, and when one of them is 1
the rest is 0.

First an attempt will be made at making a unique row for `"NEAR BAY"`.

```python
ocean_proximity_NEAR_BAY = pd.Series([1 if i == "NEAR BAY" else 0 for i in df["ocean_proximity"]])
ocean_proximity_NEAR_BAY.head()
```

We need to check if the values track to what is expected.

```python
ocean_proximity_NEAR_BAY.unique()
```

Everything looks good, we can thus add this new column to the features.

```python
df["ocean_proximity_NEAR_BAY"] = ocean_proximity_NEAR_BAY
df.head()
```

Similarly, we create similar columns for the remaining 4 values.

```python
ocean_proximity_1HR_OCEAN = pd.Series([1 if i == "<1H OCEAN" else 0 for i in df["ocean_proximity"]])
ocean_proximity_INLAND = pd.Series([1 if i == "INLAND" else 0 for i in df["ocean_proximity"]])
ocean_proximity_NEAR_OCEAN = pd.Series([1 if i == "NEAR OCEAN" else 0 for i in df["ocean_proximity"]])
ocean_proximity_ISLAND = pd.Series([1 if i == "ISLAND" else 0 for i in df["ocean_proximity"]])

df["ocean_proximity_1HR_OCEAN"] = ocean_proximity_1HR_OCEAN
df["ocean_proximity_INLAND"] = ocean_proximity_INLAND
df["ocean_proximity_NEAR_OCEAN"] = ocean_proximity_NEAR_OCEAN
df["ocean_proximity_ISLAND"] = ocean_proximity_ISLAND
df.head()
```

Now that we have completed the numerical conversion, we can remove the original
`ocean_proximity` column as we do not need it anymore.

```python
df = df.drop("ocean_proximity", axis=1)
df.head()
```

```python
df.describe()
```

We see that some new NaN values have been found on the `ocean_proximity` sub
columns. We will remove these before moving on.

```python
df = df.dropna(subset=["ocean_proximity_NEAR_BAY", "ocean_proximity_1HR_OCEAN", "ocean_proximity_INLAND", 
                       "ocean_proximity_NEAR_OCEAN", "ocean_proximity_ISLAND"])
df.describe()
```

Finally, the cleanup has been completed successfully for the dataframe. We can
now move on to the actual work.

```python
labels = df["median_house_value"]
```

## Linear Regression with One Input Feature

For this purpose, we shall use `housing_median_age` as the feature. This is a
reasonable choice because how old the house is determines things like wear and
tear to the house and the overall quality of all services that it provides,
which hugely affect value.

```python
features = df["housing_median_age"]
features.head()
```

Now, we pick the algorithm. Obviously, for the purposes of this lab, we will be
making use of **linear regression**. It is quite useful for problems like this
because it is simple yet can provide quite usable results for well organized
data.

Firstly, we should visualize the data so that we can see what we are working with.

```python
import matplotlib.pyplot as plt

plt.scatter(features, labels, marker='x', color='red')
plt.xlabel("median housing age")
plt.ylabel("median house value")
```

```python
from sklearn.preprocessing import StandardScaler

scaler_x = StandardScaler()
features_scaled = pd.DataFrame(scaler_x.fit_transform(features.values.reshape(-1,1)))
features_scaled.head()
```

```python
scaler_y = StandardScaler()
labels_scaled = pd.DataFrame(scaler_y.fit_transform(labels.values.reshape(-1,1)))[0]
labels_scaled.head()
```

We will now define the cost function. This is the function we need to minimize
throughout this task to optimize the model. For this case, we will be using
**Mean Squared Error (MSE)**.

```python
import numpy as np

def compute_cost(X, y, theta):
    return np.sum(np.square(np.matmul(X, theta) - y)) / (2 * len(y))
```

We will now compute an initial cost, providing a initial value for `theta` of
zero. `theta` specifically is a tuple containing the values of the intercept
(bias) and slope (weight) respectively for the model equation `y = b + wx`.

```python
theta_scaled = np.zeros(2)
X_scaled = np.column_stack((np.ones(len(features_scaled)), features_scaled))
y_scaled = labels_scaled
initial_cost = compute_cost(X_scaled, y_scaled, theta_scaled)

print(f"theta: {theta_scaled}")
print(f"cost: {initial_cost}")
```

Now, we work towards implementing gradient descent to minimize the cost.

```python
def gradient_descent(X, y, alpha, iterations):
    theta = np.zeros(2)
    m = len(y)
    
    for i in range(iterations):
        t0 = theta[0] - (alpha / m) * np.sum(np.dot(X, theta) - y)
        t1 = theta[1] - (alpha / m) * np.sum((np.dot(X, theta) - y) * X[:,1])
        theta = np.array([t0, t1])

    return theta
```

Now, we can train the model using this function.

```python
iterations = 5000
alpha = 0.01

theta = gradient_descent(X_scaled, y_scaled, alpha, iterations)
cost = compute_cost(X_scaled, y_scaled, theta_scaled)

print(f"theta: {theta}")
print(f"cost: {cost}")
```

We have minimized the cost to the lowest possible value we could reach with
this circumstance, and calculated the intercept as 3.186e-17 and 1.077e-01.

However, these are the scaled values. We need to unscale them to get the true
results.

```python
theta = np.zeros(2)
theta[1] = theta[1] * (scaler_y.scale_[0] / scaler_x.scale_[0])
theta[0] = scaler_y.mean_[0] + scaler_y.scale_[0]*theta[0] - theta[1] * scaler_x.mean_[0]
theta
```

```python
plt.scatter(features, labels, marker='x', color='red')
plt.xlabel("median housing age")
plt.ylabel("median house value")
samples = np.linspace(min(features), max(features))
plt.plot(samples, theta[0] + theta[1] * samples)
```

## Linear Regression with Multiple Input Features


Now, we will use all the input features available.

```python
features = df[df.columns.difference(["median_house_value"])]
features.head()
```

Now, we apply the standard scaler on all the features.

```python
x = features
y = labels
```

```python
scaler = StandardScaler()

standardized_data = pd.DataFrame(scaler.fit_transform(x), columns=["households", "housing_median_age", "latitude", "longitude",
                                                                   "median_income", "population", "total_bedrooms", "total_rooms",
                                                                   "ocean_proximity_NEAR_BAY", "ocean_proximity_1HR_OCEAN",
                                                                   "ocean_proximity_INLAND", "ocean_proximity_NEAR_OCEAN",
                                                                   "ocean_proximity_ISLAND"])
standardized_data.head()
```

We can modify the earlier gradient descent function to expand to multiple
features and work with it to now use linear regression with the selected
features.

```python
def gradient_descent_multi(X, y, theta, alpha, iterations):
    theta = np.zeros(X.shape[1])
    m = len(X)

    for i in range(iterations):
        gradient = (1/m) * np.matmul(X.T, np.matmul(X, theta) - y)
        theta = theta - alpha * gradient

    return theta

alpha = 0.1
iterations = 5000
theta = gradient_descent_multi(standardized_data, labels_scaled, theta, alpha, iterations)
cost = compute_cost(standardized_data, labels_scaled, theta)

print(f"theta: \n{theta}")
print(f"cost: {cost}")
```

Thus, we get the cost as 0.178.
