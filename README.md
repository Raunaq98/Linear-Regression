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
        

# ERRORS

A fitted regression model uses the parameters to generate point estimate predictions which are the means of observed responses if you were to replicate the study with the same 𝑋
X
 values an infinite number of times (and when the linear model is true). The difference between these predicted values and the ones used to fit the model are called "residuals" which, when replicating the data collection process, have properties of random variables with 0 means.

**Residual Sum of squares (RSS)** — Here the cost function is the (y(i) — y(pred))² which is minimized to find that value of β0 and β1, to find that best fit of the predicted line. This is an absolute difference between the actual y and the predicted y. Now, if the units of the actual y and predicted y changes the RSS will change. So, we use the relative term R².

**Residual Standard Error (RSE)** is the average amount the response will deviate away from the true value. It is a measure of lack of fit.

Instead of adding the actual value’s difference from the predicted value, in the **Total Sum of Squares (TSS)**, we find the difference from the mean y the actual value.

**R- squared value** is the proportion of variance in the model. It varies between 0 and 1. higher the value of R², greater if the fit.
                    
                     R² = 1 - RSS/TSS
                  
**p-values** are used to discard  NULL hypothesis. Lower the value of P-values, better is that feature for our model.


# Subset Selection

Instead of training the model on all variables, we usse a subset of all available variables. It is of three types :

          1. Best Subset Selection :  We fit separate models for each possible combination 
          of the n predictors and then select the best subset. At first, we fit 0 variables ie. NULL model. 
          We then fit 1 variable. when we have 2 variables, we chose that combination of two variables 
          from total n variables that has the highest R² value. Similarly for 3,4...n we find the best combinations.
          We then choose the combination out of these based on the highest adjusted R² value.
          
          2. Forward step-wise selection : For computational reasons, the best subset cannot be applied for any 
          large n due to the 2ncomplexity. Forward Stepwise begins with a model containing no predictors, 
          and then adds predictors to the model, one at the time. At each step, the variable that gives 
          the greatest additional improvement to the fit is added to the model selected in the previous step.
          
          3. Backward step-wise selection : We start with all variable and keep removing them one by one

# Ridge Regression

**Multicollinearity** is a phenomenon in which one predictor variable in a multiple regression model can be linearly predicted from the others with a substantial degree of accuracy. In this situation, the coefficient estimates of the  multiple regression may change erratically in response to small changes in the model or the data. 
          
Ridge Regression is a technique for analyzing multiple regression data that suffer from multicollinearity. When multicollinearity occurs, least squares estimates are unbiased, but their **variances are large** so they may be far from the true value. By **adding a degree of bias** to the regression estimates, ridge regression reduces the standard errors. The problem with linear regression is that the model usually ovefits to training data leading to high variance. 

Regression involves minimising the sum of squared residuals. In case of **Ridge Regression**, we minimise :

          Ridge Regression : min( sum of squared residuals    +    [lambda] x [Slope²]  )
          
where **Slope²** adds a penalty and **lamba** (tuning parameter) determines how severe it is. As a result, ridge tries to fit a line that
has a lower slope ie. lower sensitivity of y on x. Higher the value of lambda, the lower is the slope of the fit line.

The disadvantage is that it includes all n predictor variables in the analysis. This is handled using the **Laso Regression**.

# Laso Regression
Instead of square of slope, we use its absolute value.

          Ridge Regression : min( sum of squared residuals    +    [lambda] x |Slope|  )

          
