library(ggplot2)
library(dplyr)

ggplot(clean_houses,aes(x=crime_rate,y=price))+
         geom_point()+
         theme_bw()+
         geom_smooth(method="lm")


#### SIMPLE LINEAR REGRESSION

simple_linear<- lm(price~room_num,clean_houses)
summary(simple_linear)

clean_houses %>% ggplot(aes(x=room_num,y=price))+
         geom_point() +
         theme_bw()+
         geom_smooth(method=lm)+
         labs(title = "simple linear regression")


#### MULTIPLE LINEAR REGRESSION

multiple_linear <- lm(price~.,clean_houses)
summary(multiple_linear)


#### SPLITTING DATA
library(caTools)
set.seed(0)

sample<- sample.split(clean_houses$price,SplitRatio = 0.8) 
train<- subset(clean_houses,sample==TRUE)
test<- subset(clean_houses,sample==FALSE)

#### RUNNING MODEL

lm_final <- lm(price~.,train)
summary(lm_final)

#### MAKING PREDICTIONS

predictions<- predict(lm_final,test)

#### RESULTS

result <- cbind(test$price,predictions)
colnames(result)<- c("actual","predicted")
result<- as.data.frame(result)

#### MODEL EVALUATION

MSE <-  mean( (result$actual - result$predicted)^2)
# [1] 25.12386

RMSE<- sqrt(MSE)
# [1] 5.012371

SSE <- sum( (result$predicted - result$actual)^2)
SST<- sum( (mean(clean_houses$price) - result$actual)^2 )
r_squared<- 1-SSE/SST
#[1] 0.5670301