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

<!-- #region id="hkrj8hwszHQT" -->
The idea here is to train a multitude of neural networks via PyTorch in order to create a classification model to determine whether a given point is within a particular region or not.

Firstly, import Pytorch and set it up with a random seed.
<!-- #endregion -->

```python colab={"base_uri": "https://localhost:8080/"} id="BXL8BI0Cc_YT" outputId="47631ff2-b807-45ca-ff00-cb60906b7c41"
import torch

torch.manual_seed(42)
```

<!-- #region id="oluiEfIs0Vw8" -->
Now, import the dataset.
<!-- #endregion -->

```python colab={"base_uri": "https://localhost:8080/", "height": 206} id="wqR725FOdT-F" outputId="6f720dcf-696a-4b53-f380-1bc65eac33f0"
import pandas as pd

df = pd.read_csv("circles_binary_classification.csv")

df.head()
```

<!-- #region id="KrhSdlG90X2R" -->
We can have a quick look at it via `describe()`.
<!-- #endregion -->

```python colab={"base_uri": "https://localhost:8080/", "height": 300} id="E3Xh2EDgdjRp" outputId="5e9ae6d5-29b4-4783-cf07-4fe847ac1ebd"
df.describe()
```

<!-- #region id="mgF_p2J40b4l" -->
The set appears fairly normal. We can now move on to setting up the features `X` and the label `y`.
<!-- #endregion -->

```python id="uy0sntrfdksx"
X = df[["X1", "X2"]].values
y = df["label"].values

# Convert to tensors
X = torch.tensor(X, dtype=torch.float32)
y = torch.tensor(y, dtype=torch.float32)
```

```python colab={"base_uri": "https://localhost:8080/", "height": 472} id="lZoE-5jCdzV1" outputId="a353243c-4b50-4d94-d226-349886ecc6ed"
import matplotlib.pyplot as plt

plt.scatter(X[:, 0], X[:, 1], c=y, cmap="coolwarm")
plt.xlabel("X1")
plt.ylabel("X2")
plt.title("Circles Dataset")
plt.show()
```

<!-- #region id="C2LPIX7a00Gm" -->
Plotting the information, we see that `X1` and `X2` each is a list of points that are within a certain boundary and outside of that boundary respectively. The task of our neural net will be to determine whether a given point is within that boundary or outside of it; therefore we are training it to recognize where that boundary is.
<!-- #endregion -->

<!-- #region id="mNwh023setY2" -->
Now set up the train test split.
<!-- #endregion -->

```python colab={"base_uri": "https://localhost:8080/"} id="wjLObdhqew5u" outputId="fe3919a0-9c71-4616-d602-4e75cb7fb553"
from sklearn.model_selection import train_test_split

X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

# Convert back to tensors as sklearn returns numpy
X_train = torch.tensor(X_train, dtype=torch.float32)
X_test = torch.tensor(X_test, dtype=torch.float32)
y_train = torch.tensor(y_train, dtype=torch.float32)
y_test = torch.tensor(y_test, dtype=torch.float32)
```

<!-- #region id="HpEc3-c708fx" -->
Make the code device-agnostic, so that it uses CUDA if it's present but runs fine on the CPU if not.
<!-- #endregion -->

```python colab={"base_uri": "https://localhost:8080/", "height": 35} id="nij9zp2-fPLs" outputId="d83b444a-a576-43c9-f655-67ab774a7667"
device = "cuda" if torch.cuda.is_available() else "cpu"
device
```

```python id="fCxc-vYcfUS-"
X_train, X_test = X_train.to(device), X_test.to(device)
y_train, y_test = y_train.to(device), y_test.to(device)
```

<!-- #region id="Kzke0WJSgTnT" -->
Some setup before defining the models themselves, to define the loss, accuracy, optimizer and training loop.
<!-- #endregion -->

```python id="CWFbI1vzgaBL"
import torch.nn as nn

loss_fn = nn.BCEWithLogitsLoss()

def accuracy_fn(y_true, y_logits):
  y_pred = torch.round(torch.sigmoid(y_logits))
  correct = (y_pred.squeeze() == y_true).sum().item()
  return correct / len(y_true)
```

<!-- #region id="aJwXUNgb5SNb" -->
For the optimizer, that is, the algorithm that determines the manner in which the model is trained, we will be using the simple stochastic gradient descent (SGD) algorithm.

SGD works by stepping the weight towards the direction with the largest gradient. The larger the gradient, the larger the step.
<!-- #endregion -->

```python id="P3i6Eub4g8G_"
def train_and_test(model, epochs=100):
  model.to(device)
  optimizer = torch.optim.SGD(model.parameters(), lr=0.1)

  train_losses = []
  test_losses = []

  for epoch in range(epochs):
    model.train()
    y_logits = model(X_train).squeeze()
    loss = loss_fn(y_logits, y_train)

    optimizer.zero_grad()
    loss.backward()
    optimizer.step()

    model.eval()
    with torch.no_grad():
      test_logits = model(X_test).squeeze()
      test_loss = loss_fn(test_logits, y_test)

    train_losses.append(loss.item())
    test_losses.append(test_loss.item())

    if epoch % 10 == 0:
      train_acc = accuracy_fn(y_train, y_logits)
      test_acc = accuracy_fn(y_test, test_logits)
      print(f"epoch {epoch} | train loss: {loss:.4f} | test loss: {test_loss:.4f} | train acc: {train_acc:.4f} | test acc: {test_acc:.4f}")

  return train_losses, test_losses
```

<!-- #region id="wjVgppPo1btF" -->
These functions will be essential for the overall workflow of training the neural networks.

Additionally, we will use a decision boundary plotter, which will be of tremendous help in visualizing our results.
<!-- #endregion -->

```python id="LJ7Liv2cj6sl"
import numpy as np

def plot_decision_boundary(model: torch.nn.Module, X: torch.Tensor, y: torch.Tensor):
    """Plots decision boundaries of model predicting on X in comparison to y.

    Source - https://madewithml.com/courses/foundations/neural-networks/ (with modifications)
    """
    # Put everything to CPU (works better with NumPy + Matplotlib)
    model.to("cpu")
    X, y = X.to("cpu"), y.to("cpu")

    # Setup prediction boundaries and grid
    x_min, x_max = X[:, 0].min() - 0.1, X[:, 0].max() + 0.1
    y_min, y_max = X[:, 1].min() - 0.1, X[:, 1].max() + 0.1
    xx, yy = np.meshgrid(np.linspace(x_min, x_max, 101), np.linspace(y_min, y_max, 101))

    # Make features
    X_to_pred_on = torch.from_numpy(np.column_stack((xx.ravel(), yy.ravel()))).float()

    # Make predictions
    model.eval()
    with torch.inference_mode():
        y_logits = model(X_to_pred_on)

    # Test for multi-class or binary and adjust logits to prediction labels
    if len(torch.unique(y)) > 2:
        y_pred = torch.softmax(y_logits, dim=1).argmax(dim=1)  # mutli-class
    else:
        y_pred = torch.round(torch.sigmoid(y_logits))  # binary

    # Reshape preds and plot
    y_pred = y_pred.reshape(xx.shape).detach().numpy()
    plt.contourf(xx, yy, y_pred, cmap=plt.cm.RdYlBu, alpha=0.7)
    plt.scatter(X[:, 0], X[:, 1], c=y, s=40, cmap=plt.cm.RdYlBu)
    plt.xlim(xx.min(), xx.max())
    plt.ylim(yy.min(), yy.max())
```

<!-- #region id="nen2lBqgfeSE" -->
## Model V0 (2 -> 5 -> 1, no activation)
<!-- #endregion -->

<!-- #region id="tHvw3-KG1sVB" -->
The first model `V0` is an extremely simple network, which only has a single hidden layer, with only 5 neurons. It does not use any activation function between the layers.
<!-- #endregion -->

```python id="QIxfr1yFfk7c"
class ModelV0(nn.Module):
  def __init__(self):
    super().__init__()
    self.layer1 = nn.Linear(2, 5)
    self.layer2 = nn.Linear(5, 1)

  def forward(self, x):
    return self.layer2(self.layer1(x))
```

<!-- #region id="DNArBaXV13E0" -->
We will now train this network for a hundred epochs, which should be enough for something of this level of simplicity.
<!-- #endregion -->

```python colab={"base_uri": "https://localhost:8080/"} id="G5ql2Lscf6Tk" outputId="49c99ca2-439d-4014-9b17-56b507874d88"
model_v0 = ModelV0()
losses_v0 = train_and_test(model_v0, epochs=100)
```

<!-- #region id="WLUtPcaC19tC" -->
Visibly, the loss levels have barely decreased, and the accuracy has similarly barely increased; in fact the test accuracy has decreased. To observe this more clearly we can visualize the results.
<!-- #endregion -->

```python colab={"base_uri": "https://localhost:8080/", "height": 545} id="NVIXd9eoiii6" outputId="93843388-bdf5-486c-b96c-fda0ece12971"
plt.figure(figsize=(12, 6))
plt.subplot(1, 2, 1)
plt.title("train")
plot_decision_boundary(model_v0, X_train, y_train)
plt.subplot(1, 2, 2)
plt.title("test")
plot_decision_boundary(model_v0, X_test, y_test)
```

<!-- #region id="sKdQWCLd2Ham" -->
Looking at the decision boundary it is clear that the network has no clue what it is doing; the result is not much better than randomly guessing which point is within or outside the actual boundary.
<!-- #endregion -->

```python colab={"base_uri": "https://localhost:8080/", "height": 430} id="KfLDFxO6kSc5" outputId="6501348a-6562-4747-f84e-24d847c5c9ef"
plt.plot(losses_v0[0], label="train loss")
plt.plot(losses_v0[1], label="test loss")
plt.legend()
plt.show()
```

<!-- #region id="cL-CIgrg2WC7" -->
As visible above, the losses have barely decreased as well; simply reaching and then hanging around the value of $ln(2)$. Will increasing the number of layers and neurons help make this better?
<!-- #endregion -->

<!-- #region id="8KLMd9dmkc8m" -->
## Model V1 (2 -> 15 -> 15 -> 1, no activation)
<!-- #endregion -->

<!-- #region id="8mJ3saYx2oQT" -->
The second network, `V1`, is essentially a beefed-up version of `V0` which has an extra hidden layer, and each hidden layer now has 15 neurons instead of 5.
<!-- #endregion -->

```python id="NJY0jjftkZ9r"
class ModelV1(nn.Module):
  def __init__(self):
    super().__init__()
    self.layer1 = nn.Linear(2, 15)
    self.layer2 = nn.Linear(15, 15)
    self.layer3 = nn.Linear(15, 1)

  def forward(self, x):
    return self.layer3(self.layer2(self.layer1(x)))
```

<!-- #region id="Te5-Jqss3AyN" -->
Now we will be training it, this time for a thousand epochs to account for the increased complexity.
<!-- #endregion -->

```python colab={"base_uri": "https://localhost:8080/"} id="ELa87yVTkxKx" outputId="eab4f263-3657-4d49-f7b7-8dbae0b204d1"
model_v1 = ModelV1()
losses_v1 = train_and_test(model_v1, epochs=1000)
```

<!-- #region id="u8kY4_-x3Heb" -->
Unfortunately, there is not much improvement here as well compared to `V0`. In fact, the results are essentially the same, which is clearer when visualizing the decision boundary.
<!-- #endregion -->

```python colab={"base_uri": "https://localhost:8080/", "height": 545} id="VmkBo3pRlGsY" outputId="f0486a9b-c66d-4640-9bc6-52be4d3d374f"
plt.figure(figsize=(12, 6))
plt.subplot(1, 2, 1)
plt.title("train")
plot_decision_boundary(model_v1, X_train, y_train)
plt.subplot(1, 2, 2)
plt.title("test")
plot_decision_boundary(model_v1, X_test, y_test)
```

<!-- #region id="8-iUSBmD3PlH" -->
Again, the results are no better than a random guess.
<!-- #endregion -->

```python colab={"base_uri": "https://localhost:8080/", "height": 432} id="r7utSIxQlQbV" outputId="0f3a2960-7310-404b-c316-898d329d0a49"
plt.plot(losses_v1[0], label="train loss")
plt.plot(losses_v1[1], label="test loss")
plt.legend()
plt.show()
```

<!-- #region id="E-iFcqal3SDB" -->
The loss once again hangs around $ln(2)$.
<!-- #endregion -->

<!-- #region id="zDhydjLy3hb9" -->
Why is this occuring? Well, this is because we are not utilizing the real capabilities of neural networks just yet. Currently, both `V0` and `V1` are simply just overly complicated linear models.

Each layer is in the form

$$
y = Wx + b
$$

Stacking multiple layers without activations gives something akin to

$$
y = W_3(W_2(W_1x + b_1) + b_2) + b_3
$$

Which you could just rewrite as

$$
y = W'x + b'
$$

This linearity prevents the models from learning nonlinear patterns, which is a necessity to solving problems of this nature. For this purpose, activation functions are used.
<!-- #endregion -->

<!-- #region id="9kokImVHlnPQ" -->
## Model V2 (2 -> 64 -> 64 -> 10 -> 1, with ReLU)
<!-- #endregion -->

<!-- #region id="U_ri4o464MdZ" -->
`V2` is slightly beefed up from `V1` in terms of the number of layers and the neurons, but the most significant change is the addition of an activation function in between layers. In this case, the `ReLU` function is used, which is defined as

$$
\mathrm{ReLU}(x) = \max(0, x)
$$

This function introduces non-linearity to the network which theoretically should make it capable to learn to solve this type of problem.
<!-- #endregion -->

```python id="GOAjt5xJl3tp"
class ModelV2(nn.Module):
  def __init__(self):
    super().__init__()
    self.model = nn.Sequential(
        nn.Linear(2, 64),
        nn.ReLU(),
        nn.Linear(64, 64),
        nn.ReLU(),
        nn.Linear(64, 10),
        nn.ReLU(),
        nn.Linear(10, 1)
    )

  def forward(self, x):
    return self.model(x)
```

<!-- #region id="q55Zq0Ok4nN4" -->
Training it for 500 epochs,
<!-- #endregion -->

```python colab={"base_uri": "https://localhost:8080/"} id="jD1ydGi-mNTA" outputId="89b105c5-fc33-4808-b93d-e9d3837d3eb7"
model_v2 = ModelV2()
losses_v2 = train_and_test(model_v2, epochs=500)
```

<!-- #region id="E_VUgSgb4svF" -->
An immediate improvement is visible. The level of loss has significantly decreased, and the accuracy is also very high at about 91.37%. We can visualize the decision boundary to see it more clearly.
<!-- #endregion -->

```python colab={"base_uri": "https://localhost:8080/", "height": 545} id="Hfilf_7AmY5y" outputId="6b44819a-ec8a-4f8e-ebbe-50e15fd2c0af"
plt.figure(figsize=(12, 6))
plt.subplot(1, 2, 1)
plt.title("train")
plot_decision_boundary(model_v2, X_train, y_train)
plt.subplot(1, 2, 2)
plt.title("test")
plot_decision_boundary(model_v2, X_test, y_test)
```

<!-- #region id="D23IaCII43RG" -->
The network is finally capable of actually solving the problem to some extent, as it has successfully managed to divide the two sets of points in a fairly clean way, despite hugging a bit close to the outer points.
<!-- #endregion -->

```python colab={"base_uri": "https://localhost:8080/", "height": 430} id="kzE97lkmmk6R" outputId="0d1981c5-82bc-4f06-8847-122c2d183ea0"
plt.plot(losses_v2[0], label="train loss")
plt.plot(losses_v2[1], label="test loss")
plt.legend()
plt.show()
```

<!-- #region id="O6M1GX3m5Exc" -->
The loss has decreased quite significantly despite an unstable spike and bounces starting around the 410 epoch mark.
<!-- #endregion -->

<!-- #region id="Xbh0fXklzeJk" -->
### Using the Adam Optimizer
<!-- #endregion -->

<!-- #region id="LBVj8a3I5-e-" -->
While the SGD optimizer is fairly effective for most tasks, it has the tendency to be quite slow and also unstable in steep regions, which was evident starting at around the 410 epoch mark in the earlier loss graph. The Adam optimizer can be used to fix these issues.

Adam (Adaptive Moment Estimation) is an optimizer that works by modifying the learning rate based on how past gradients have been changing. If the movement is consistently occuring in one direction, the step sizes can be increased, otherwise it slows the rate down for stability.

We will now test `V2` with the Adam optimizer.
<!-- #endregion -->

```python id="fE3QHqu0zfvk"
def train_and_test_adam(model, epochs=100):
  model.to(device)
  # Replace default optimizer with Adam
  optimizer = torch.optim.Adam(model.parameters(), lr=0.01)

  train_losses = []
  test_losses = []

  for epoch in range(epochs):
    model.train()
    y_logits = model(X_train).squeeze()
    loss = loss_fn(y_logits, y_train)

    optimizer.zero_grad()
    loss.backward()
    optimizer.step()

    model.eval()
    with torch.no_grad():
      test_logits = model(X_test).squeeze()
      test_loss = loss_fn(test_logits, y_test)

    train_losses.append(loss.item())
    test_losses.append(test_loss.item())

    if epoch % 10 == 0:
      train_acc = accuracy_fn(y_train, y_logits)
      test_acc = accuracy_fn(y_test, test_logits)
      print(f"epoch {epoch} | train loss: {loss:.4f} | test loss: {test_loss:.4f} | train acc: {train_acc:.4f} | test acc: {test_acc:.4f}")

  return train_losses, test_losses
```

```python colab={"base_uri": "https://localhost:8080/"} id="sMIQIyz8zoPE" outputId="cb0d34c7-04d0-4c97-8e5e-61a9ca8a4950"
model_v2 = ModelV2()
losses_v2 = train_and_test_adam(model_v2, epochs=500)
```

<!-- #region id="fzejPxgf6zny" -->
An immediate improvement is visible; the loss has decreased significantly, and so has the accuracy, reaching close to a 100%.
<!-- #endregion -->

```python colab={"base_uri": "https://localhost:8080/", "height": 545} id="zEThcgm3zs5T" outputId="ad73be51-7a71-4b76-8790-d401f2aa39e1"
plt.figure(figsize=(12, 6))
plt.subplot(1, 2, 1)
plt.title("train")
plot_decision_boundary(model_v2, X_train, y_train)
plt.subplot(1, 2, 2)
plt.title("test")
plot_decision_boundary(model_v2, X_test, y_test)
```

<!-- #region id="qgew4nTa68eg" -->
The decision boundary reflects the same.
<!-- #endregion -->

```python colab={"base_uri": "https://localhost:8080/", "height": 430} id="K0B9dOxvz_X4" outputId="ee035b37-f0c9-4864-e803-50dbd0de88fb"
plt.plot(losses_v2[0], label="train loss")
plt.plot(losses_v2[1], label="test loss")
plt.legend()
plt.show()
```

<!-- #region id="RYs1B4546_BP" -->
The loss graph shows that the loss fell very quickly, reaching essentially zero before even a hundred epochs, showcasing the high performance levels of the Adam optimizer compared to SGD.
<!-- #endregion -->
