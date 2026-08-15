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

<!-- #region id="ZjLL-Fro3MHC" -->
Firstly, import torch and manually seed it.
<!-- #endregion -->

```python colab={"base_uri": "https://localhost:8080/"} id="6cdmWvT2UdKy" outputId="5ef4403e-ac6c-4760-c42a-158ca8b52087"
import torch

torch.manual_seed(42)
```

<!-- #region id="vEQQpCuy3TtP" -->
Create a transform to convert a datset to tensors, then normalize all the values for easier training.
<!-- #endregion -->

```python id="EAsaG-C1VG0p"
import torchvision.transforms as transforms

transform = transforms.Compose([
    transforms.ToTensor(),
    transforms.Normalize((0.5, 0.5, 0.5),
                         (0.5, 0.5, 0.5))
])
```

<!-- #region id="lgSFdwCU3bpw" -->
Next, we grab the datasets, for both training and testing.

In this case, we will be using the CIFAR-10 dataset, which is a collection of 60,000 32x32 images, each classifiable into one of 10 categories. This dataset is among the most commonly used for training computer vision algorithms.
<!-- #endregion -->

```python colab={"base_uri": "https://localhost:8080/"} id="-0A7dqP-U7qH" outputId="538e6ab9-a6b4-4047-ecb3-8527ef98cd31"
import torchvision

trainset = torchvision.datasets.CIFAR10(
    root='./data',
    train=True,
    download=True,
    transform=transform
)

testset = torchvision.datasets.CIFAR10(
    root='./data',
    train=False,
    download=True,
    transform=transform
)
```

<!-- #region id="lsvC73zy3gT0" -->
We will now create a train and test loader so that training is done in batches of 64 instead of training on all 60,000 images at once which would be extremely heavy on the computer.
<!-- #endregion -->

```python id="8D0KeZqpVlz2"
trainloader = torch.utils.data.DataLoader(trainset, batch_size=64, shuffle=True)
testloader = torch.utils.data.DataLoader(testset, batch_size=64, shuffle=False)
```

<!-- #region id="f8VyBYyz3qpN" -->
Visualize the data in the set to see what we're working with.
<!-- #endregion -->

```python colab={"base_uri": "https://localhost:8080/", "height": 227} id="UU6kuO832ucU" outputId="cde08210-7cb7-4828-9599-b3410df8b189"
import matplotlib.pyplot as plt
import numpy as np

def imshow(img):
    img = img / 2 + 0.5
    npimg = img.numpy()
    plt.imshow(np.transpose(npimg, (1, 2, 0)))
    plt.show()

dataiter = iter(trainloader)
images, labels = next(dataiter)

classes = ('plane', 'car', 'bird', 'cat', 'deer', 'dog', 'frog', 'horse', 'ship', 'truck')

plt.figure(figsize=(10,4))
for i in range(4):
    plt.subplot(1, 4, i+1)
    img = images[i] / 2 + 0.5
    plt.imshow(np.transpose(img.numpy(), (1, 2, 0)))
    plt.title(classes[labels[i]])
    plt.axis('off')
```

<!-- #region id="HwTO-bbN5B1i" -->
Make the code device-agnostic.
<!-- #endregion -->

```python colab={"base_uri": "https://localhost:8080/", "height": 35} id="PUSjevbaX90K" outputId="c79724bb-f50a-44b8-9ecb-571824e640d4"
device = "cuda" if torch.cuda.is_available() else "cpu"
device
```

<!-- #region id="d2_vgosd3r9m" -->
We will use cross-entropy loss for the loss function.

Cross-entropy loss is a type of loss function which is specialized for use in classification problems. It measures the distance between a model's prediction and the correct classification.

For multi-class classification, the formula for cross-entropy loss can be given by

$$
CE = - \frac{1}{N} \sum_{i=1}^{N} \sum_{j=1}^{C} \left( y_{i,j} \log (p_{i,j}) \right)
$$

Where

- $N$ is the number of samples,
- $C$ is the number of classes,
- $y_{i,j}$ is 1 if class $j$ is correct for sample $i$, 0 otherwise.
- $p_{i,j}$ is the predicted probability by the model of sample $i$ being in class $j$.

Cross-entropy loss is especially useful because it assigns heavy penalties to answers that are confident but incorrect.
<!-- #endregion -->

```python id="vtNnPcttYyJV"
import torch.nn as nn

loss_fn = nn.CrossEntropyLoss()
```

<!-- #region id="jJAXU2rn39BX" -->
Create the train & test function. We will be using the Adam optimizer, currently with a learning rate of `0.001`, and training for ten epochs.
<!-- #endregion -->

```python id="z7UOrqxbanMT"
def train_and_test(model, epochs=10, learning_rate=0.001):
  model.to(device)
  optimizer = torch.optim.Adam(model.parameters(), lr=learning_rate)

  train_losses = []
  test_losses = []

  for epoch in range(epochs):
    model.train()
    running_loss = 0.0
    correct = 0
    total = 0

    for inputs, labels in trainloader:
      inputs = inputs.to(device)
      labels = labels.to(device)

      optimizer.zero_grad()

      outputs = model(inputs)
      loss = loss_fn(outputs, labels)

      loss.backward()
      optimizer.step()

      running_loss += loss.item()

      _, predicted = torch.max(outputs, 1)
      correct += (predicted == labels).sum().item()
      total += labels.size(0)

    train_loss = running_loss / len(trainloader)
    train_acc = 100 * correct / total
    train_losses.append(train_loss)

    model.eval()
    test_running_loss = 0.0
    test_correct = 0
    test_total = 0
    with torch.no_grad():
        for inputs, labels in testloader:
            inputs = inputs.to(device)
            labels = labels.to(device)
            outputs = model(inputs)

            loss = loss_fn(outputs, labels)
            test_running_loss += loss.item()

            _, predicted = torch.max(outputs, 1)
            test_correct += (predicted == labels).sum().item()
            test_total += labels.size(0)

    test_loss = test_running_loss / len(testloader)
    test_acc = 100 * test_correct / test_total
    test_losses.append(test_loss)

    print(f"epoch {epoch+1} | train acc: {train_acc:.2f} | train loss: {train_loss:.4f} | test acc: {test_acc:.2f} | test loss: {test_loss:.4f}")

  return train_losses, test_losses
```

<!-- #region id="zlQHOC65478o" -->
For comparison of the model sizes create a function to count the number of parameters.
<!-- #endregion -->

```python id="aulH0GeZhZjE"
def count_params(model):
  return sum(p.numel() for p in model.parameters())
```

<!-- #region id="zbCYPl5A43XW" -->
## Plain NN


<!-- #endregion -->

<!-- #region id="lfxEpV5qXSVm" -->
The first model will simply be a plain neural network with the images (32x32 with 3 color channels) flattened for the initial layer, two hidden layers with 512 and 256 neurons each, and the final layer having the 10 class outputs. We use $\mathrm{ReLU}$ as the activation function.
<!-- #endregion -->

```python id="UF0nuo80Xd7Y"
import torch.nn.functional as F

class NN(nn.Module):
  def __init__(self):
    super().__init__()
    self.fc1 = nn.Linear(32*32*3, 512)
    self.fc2 = nn.Linear(512, 256)
    self.fc3 = nn.Linear(256, 10)

  def forward(self, x):
    x = x.view(-1, 32*32*3)
    x = F.relu(self.fc1(x))
    x = F.relu(self.fc2(x))
    x = self.fc3(x)
    return x
```

```python colab={"base_uri": "https://localhost:8080/"} id="1A9-Xcw3bVuK" outputId="d03179b5-e60b-4fcd-b786-e0ce19e00717"
import time

model_nn = NN()
print("number of parameters: ", count_params(model_nn))
print()

start = time.time()
losses_nn = train_and_test(model_nn)
end = time.time()
print("train time: ", end - start, "seconds")
```

<!-- #region id="vUOJL3QYYNEp" -->
We can see from the training results that the training accuracy is not particularly great at 72%, and the test accuracy is far worse at around 53%. This is a clear case of **overfitting**, that is, the model fails to generalize to new data despite working well on the data it has seen.
<!-- #endregion -->

```python colab={"base_uri": "https://localhost:8080/", "height": 430} id="0Sgh6_TyrPux" outputId="b686cc5a-a229-4540-ca7b-b5a1cbf57e28"
plt.plot(losses_nn[0], label="train loss")
plt.plot(losses_nn[1], label="test loss")
plt.legend()
plt.show()
```

<!-- #region id="JjIfM4e_YkLj" -->
Plotting makes it clearer; the test losses have not decreased but rather shown instability.
<!-- #endregion -->

<!-- #region id="gluoBYls5FYt" -->
## AlexNet
<!-- #endregion -->

<!-- #region id="-h-w1Wv_YskO" -->
AlexNet uses a significantly different approach. Instead of using a fully connected network, it has convolutional filters as layers, where each filter only sees a small portion of the full image. This allows the network to keep the structure of the image, unlike the NN where the flattening of the entire image causes structural data to collapse.
<!-- #endregion -->

```python id="g8GxiQJ1d0tH"
class AlexNetCIFAR(nn.Module):
    def __init__(self):
        super().__init__()
        self.features = nn.Sequential(
            nn.Conv2d(3, 64, kernel_size=3, padding=1),
            nn.ReLU(),
            nn.MaxPool2d(2),

            nn.Conv2d(64, 192, kernel_size=3, padding=1),
            nn.ReLU(),
            nn.MaxPool2d(2),

            nn.Conv2d(192, 384, kernel_size=3, padding=1),
            nn.ReLU(),

            nn.Conv2d(384, 256, kernel_size=3, padding=1),
            nn.ReLU(),

            nn.Conv2d(256, 256, kernel_size=3, padding=1),
            nn.ReLU(),
            nn.MaxPool2d(2)
        )

        self.classifier = nn.Sequential(
            nn.Flatten(),
            nn.Linear(256 * 4 * 4, 4096),
            nn.ReLU(),
            nn.Dropout(0.5),
            nn.Linear(4096, 4096),
            nn.ReLU(),
            nn.Dropout(0.5),
            nn.Linear(4096, 10)
        )

    def forward(self, x):
        x = self.features(x)
        x = self.classifier(x)
        return x
```

```python colab={"base_uri": "https://localhost:8080/"} id="Qk-Gox3ke2Fh" outputId="d07dfc99-9fee-4e87-ca62-e949208fd255"
model_alex = AlexNetCIFAR()
print("number of parameters: ", count_params(model_alex))
print()

start = time.time()
losses_alex = train_and_test(model_alex)
end = time.time()
print("train time: ", end - start, "seconds")
```

<!-- #region id="jbeILI9zZTPK" -->
The difference in approach causes a clear change. While the model is significantly larger in size at about 21 times larger than the plain NN, and thus takes longer to train, it does provide better results with a higher train accuracy of around 84%. More importantly, it provides a significantly better test accuracy around 75%, showing a higher capability in generalization to new data.
<!-- #endregion -->

```python colab={"base_uri": "https://localhost:8080/", "height": 430} id="xro18zq9ruur" outputId="aee61bf9-735f-477e-c902-28023bd2641d"
plt.plot(losses_alex[0], label="train loss")
plt.plot(losses_alex[1], label="test loss")
plt.legend()
plt.show()
```

<!-- #region id="-A0esZECZqbI" -->
The plot reflects the previously retrieved info; both the train and test losses are decreasing, and while the test loss is still a little unstable, the level of instability is far lower than in the case of the plain NN.
<!-- #endregion -->

<!-- #region id="F64ZZ1-i5HDG" -->
## TinyVGG
<!-- #endregion -->

<!-- #region id="TKop2jETZ3s7" -->
While AlexNet provides much better performance, it also increases the complexity of the model by a large amount. As seen in the previous cells, AlexNet took over double the time to train compared to the plain NN, due to the 35.8 million parameters it contains in comparison to the plain NN's 1.7 million. This is a problem for cases where we have poorer hardware.

TinyVGG attempts to fix this issue. The main reason for the slow speed of AlexNet was the presence of large fully connected layers at the end, and the fact that it was designed for larger images; TinyVGG reduces the full connections and keeps a consistent structure of more convolutional layers instead. This should theoretically make it faster and more efficient.
<!-- #endregion -->

```python id="kFDhUj9_fqRS"
class TinyVGG(nn.Module):
    def __init__(self):
        super().__init__()
        self.conv_block1 = nn.Sequential(
            nn.Conv2d(3, 32, 3, padding=1),
            nn.ReLU(),
            nn.Conv2d(32, 32, 3, padding=1),
            nn.ReLU(),
            nn.MaxPool2d(2)
        )

        self.conv_block2 = nn.Sequential(
            nn.Conv2d(32, 64, 3, padding=1),
            nn.ReLU(),
            nn.Conv2d(64, 64, 3, padding=1),
            nn.ReLU(),
            nn.MaxPool2d(2)
        )

        self.classifier = nn.Sequential(
            nn.Flatten(),
            nn.Linear(64 * 8 * 8, 128),
            nn.ReLU(),
            nn.Linear(128, 10)
        )

    def forward(self, x):
        x = self.conv_block1(x)
        x = self.conv_block2(x)
        x = self.classifier(x)
        return x
```

```python colab={"base_uri": "https://localhost:8080/"} id="UcceKpmMg6uo" outputId="ca278278-1a25-4777-a965-53c16f372fcc"
model_tinyvgg = TinyVGG()
print("number of parameters: ", count_params(model_tinyvgg))
print()

start = time.time()
losses_tinyvgg = train_and_test(model_tinyvgg)
end = time.time()
print("train time: ", end - start, "seconds")
```

<!-- #region id="AKjfmaWZa7qI" -->
The results paint a clear picture. The train accuracy is very high at around 94%, beating out AlexNet. In addition, it also has a test accuracy around 75%, similar to AlexNet.

Most significantly though, it trains at a much higher speed; 10 epochs are done in just 209 seconds here, compared to AlexNet which took about 324 seconds, over 1.5x the time. This is possible due to its significantly smaller size; it only uses 591,274 parameters compared to the 35.8 million used by AlexNet, and even less than the 1.7 million used by the plain neural network.
<!-- #endregion -->

```python colab={"base_uri": "https://localhost:8080/", "height": 430} id="qryURaBWrLTh" outputId="16ba7f40-e2de-4c29-efe7-217d60c90f26"
plt.plot(losses_tinyvgg[0], label="train loss")
plt.plot(losses_tinyvgg[1], label="test loss")
plt.legend()
plt.show()
```

<!-- #region id="xCARhSA_bYR1" -->
The test losses are quite unstable in TinyVGG but the overall performance is still fairly good.
<!-- #endregion -->
