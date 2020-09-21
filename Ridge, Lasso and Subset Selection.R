#### SUBSET SELECTION

library(leaps)

lm_best_selection<- regsubsets(price~., 
                               data = clean_houses,
                               nvmax = 20) # total variables = 20
summary(lm_best_selection)
# to compare adjusted r^2 value
which.max( summary(lm_best_selection)$adjr2)
# [1] 9
coef(lm_best_selection,8)
# (Intercept)     air_qual     room_num     teachers    poor_prop   airportYES   n_hos_beds  n_hot_rooms         dist 
# -8.22796010 -17.12484002   4.00060153   1.03360799  -0.58517689   1.18298230   0.33531318   0.09963185  -1.14187507 
# hence, we need to use these variables only

lm_forward_selection <- regsubsets(price~., 
                                   data = clean_houses,
                                   nvmax = 20,
                                   method = "forward")

lm_backward_selection <- regsubsets(price~., 
                                    data = clean_houses,
                                    nvmax = 20,
                                    method = "backward")


### RIDGE REGRESSION

library(glmnet)

# segregate data into dependent and independent variables.
x = model.matrix(price~., data = clean_houses)[,-1]
y = clean_houses$price

# finding lambda value
# usually between 10^10 and 10^(-2)
grid = 10^seq(10,-2,length = 100)

# creating model
lm_ridge = glmnet(x,y,
                  alpha = 0,
                  lambda = grid)
# using cross validation to get the best lambda value
cv_fit = cv.glmnet(x,y,
                   alpha = 0,
                   lambda = grid)
opt_lambda = cv_fit$lambda.min
# [1] 0.2154435
plot(cv_fit, main="lambda values")

# r-squared value at opt_lambda
tss <- sum((y-mean(y))^2)
predicted <- predict(lm_ridge,s=opt_lambda, newx = x)

rss <- sum((predicted-y)^2)

r = 1 - rss/tss
# [1] 0.7210045




### LASSO REGRESSION

lm_lasso = glmnet(x,y,
                  alpha = 1,
                  lambda = grid)
