(page 24)

weights means the same as parameters

Using a pretrained model for a task different from what it was originally trained for is
known as transfer learning.

number of epochs: how many times to look at each image

over-fitting: when the model is so strict, it only works with the data it was trained for
  - when training or tuning, always leave 20% of your test data out of the training set, and use it to test your model

fine-tuning
  - is the process of fitting a pre-trained model to your usecase
  - A transfer learning technique that updates the parameters of a pre‐trained model by training for additional epochs using a different task from that used for pretraining.

CNN: Convolutional neural network
  - https://www.youtube.com/watch?v=pj9-rr1wDhM
  - https://ujjwalkarn.me/2016/08/11/intuitive-explanation-convnets/
  - `kernel`
    - each kernel in a CNN is designed to recognize a type of pattern, like horizontal lines, vertical lines, corners, etc...
      - kernels detect these patterns by iterating the image with a grid, pulling some values from the pixels (Red, Green, Blue, Luminance channels) inside the grid and converting it into a matrix
  - pooling
    - downscaling the extracted features of an image to keep it's more prominent parts
    - avoids over-fitting
  - the initial layers of a CNN detect the most basic patterns, and as you move from layer to layer, more detailed patterns will be detected
  - Layers of a CNN
    - Convolution
      - detects patterns
    - Pooling
      - pulls most prominent features to a smaller matrix
    - (repeat convolution and pooling)
    - Classifier
      - fully connected layers
        - receive the abstracted features from the convolution / pooling process