# Linear Regression

Linear regression assumes a linear relationship between the input variables (x) and the single output variable (y). More specifically, that y can be calculated from a linear combination of the input variables (x).
When there is a single input variable (x), the method is referred to as simple linear regression. When there are multiple input variables, literature from statistics often refers to the method as multiple linear regression.
It is of the following type :

          Y = ßº + ß1.X + E
Where ßº = Intercept
      ß1 = slope
      E = noise
      
Y is the ***actual observed value*** and Y' is the ***expected value*** based on the model.

      e = Y - Y'
e is called **residual**.
The linear Regression model works to find ßº and ß1 such that **sum(e^2) is min**.

        ßº = cor(x,y) *  sd(y) / sd(x)
        
        ß1 = mean(y) - ( ßº * mean(x))
        
# Logistic Regression

Logistic Regression is used when the dependent variable(target) is **categorical**. For example, to predict whether an email is spam (1) or (0)
It is used for **classification of categorical variables**. It involves a **sigmoidal activation function** that provides an **output between o and 1
for any input**.

          Sig(x) = 1 / (1 + e^(-x) )
          
This results in a probability between 0 and 1 of belonging in the 1 class( binary classification : 0 or 1 )
We can then cut a cutoff point at 0.5, below which everything belongs to class 0.
We evaluate the model performace using a **confusion matrix**.
**Confusion Matrix** is a table that is often used to describe the performance of a classification model on a set of test data for which 
the true values are known. It allows the visualization of the performance of an algorithm.
    
|    . | Predicted NO | Predicted YES|
|------| -------------|---------------|
|Actual NO| TN | FP |
|Actual YES | FN | TP |

Accuracy =    ( TP + TN ) / ( TP + FP + TN + FN )

# RSS AND TSS

A fitted regression model uses the parameters to generate point estimate predictions which are the means of observed responses if you were to replicate the study with the same 𝑋
X
 values an infinite number of times (and when the linear model is true). The difference between these predicted values and the ones used to fit the model are called "residuals" which, when replicating the data collection process, have properties of random variables with 0 means.

**Residual Standard Error (RSE)** is the average amount the response will deviate away from the true value. It is a measure of lack of fit.

                  RSE = sqrt ( RSE / (n-2) )
                  
