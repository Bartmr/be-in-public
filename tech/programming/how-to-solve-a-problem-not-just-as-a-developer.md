# How to solve a problem (not only) as a developer

This is a personal step-by-step guide on how you should approach a problem and come up with a solution. A good rule of thumb is to start tackling a problem from it's outside, and start building from the outside to the inside. This means starting by designing a boundary of what you want and what you have right now, and then come up with smaller steps to achieve that goal. But not so fast! These smaller steps are itself smaller problems, and you should repeat the same process: know what you want from these smaller steps and what you have, and come up with even smaller steps on how to obtain that, and so on...

In software development, there are two patterns related to this type of problem solving:

> "program to interfaces, not implementations"
An interface is what the name implies. It's something that you communicate with and expect a result, like a screen or a button with LED lights. Which means you should always start building on how you are going to communicate with the solution: what is the input and what is the end result. Only after you decide what the interface will need as input and what is the expected result, you are going to solve the intricacies and the steps that will convert an input into a result. When you develop a new product, you start to envision how the product will interact with the user what is going to be the end-result, and then how you will achieve said interaction.

> **YAGNI** (You Ain't Gonna Need It)
You should design your solution for what you have right now, and what is needed today.Solve for what you have today, not for what you MIGHT have tomorrow. Avoid predicting the future, because a lot of the times, what the future will need will be very different from what a human being can predict, specially given its biases.

Let's see an example:

You are have e-commerce store, and you need to process your customer's purchases. You must build a solution that allows you to get payed and ship the customer their purchase, all with the necessary legal steps.

Let's start with a function representing all that happens during the purchase:

- Files
  - **processPurchase.js**
```javascript
function processPurchase() {

}
```

Let's start with the outer shell of the solution: what you have right now, and the outcome of it. So, you have your customer ID, and the product ID that they want to purchase. Let's set that as parameters.

- Files
  - **processPurchase.js**
```javascript
function processPurchase(
  // What we have
  {
    customerId,
    productId
  }) {

}
```

Now let's define our outcome: the transaction can either run smoothly and be completed, or it can fail midway, due to various reasons that we will explore only when after we carve the shell of the problem.

- Files
  - **processPurchase.js**
```javascript
function processPurchase(
  // What we have
  {
    customerId,
    productId
  }) {
  return 'done' // or 'failed'
}
```

We now have the first layer structured, let's build it's inside. What high-level steps are needed to process a purchase? Let's start by