## Quadratic functions

- `a` controls the curvature
- `b` controls the x position
- `c` controls the x position

## Loss functions

### Mean Square Error (mse)

```python
def mse(
  predictions,
  actuals
):
  return (
    (predictions - actuals)**2
  ).mean()
```

## Tensor

A tensor is a mathematical object that can be thought of as a multidimensional array of numbers.

A tensor can be a an array of numbers inside an array, or an array of numbers inside an array inside an array, and so on.

The **rank of a tensor** is the number of indices needed to identify a particular element in the tensor. It is related to the number of dimensions of the tensor. For example, a rank-2 tensor has two indices and can be thought of as a matrix.

## Derivative

A derivative is a concept in calculus that measures how a function changes as its inputs change. It is calculated by taking the slope of the tangent line at a specific point on the function's graph.


## Exercises

I don't know math. I just learned about Pytorch, Mean Squared Error and derivatives. Give me practical exercises to consolidate my knowledge.

1. Implement a simple neural network in Pytorch using the Mean Squared Error (MSE) as the loss function.

2. Use Pytorch's automatic differentiation to calculate the derivatives of a given function.

3. Use Pytorch to implement linear regression and use MSE as the loss function.

4. Use Pytorch to implement a logistic regression model and use MSE as the loss function.

5. Write a program in Pytorch that uses stochastic gradient descent to minimize the MSE of a given dataset.

6. Implement a multivariate linear regression model in Pytorch and use MSE as the loss function.

7. Use Pytorch to calculate the derivatives of a given function with respect to multiple variables.

8. Implement a logistic regression model in Pytorch using the cross-entropy loss.

9. Use Pytorch to implement a convolutional neural network and use MSE as the loss function.

10. Use Pytorch to implement a recurrent neural network and use MSE as the loss function.