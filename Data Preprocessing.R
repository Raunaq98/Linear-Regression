# imported dataset by the name of "houses"

# checking for any discripancies 
summary(houses)
# try to chec krelative difference between mean and median

# crime_rate, rainfall and n_hot_rooms have some issues with their distribution
# n_hos_beds has 8 NA values too.

# exploring these variables even further
library(ggplot2)
library(dplyr)

#### crime_rate
houses %>% ggplot(aes(x=crime_rate)) +
         geom_histogram()+
         labs(title = "histogram of crime_rate")+
         theme_bw()
# doesnt give much info so we look at scatterplot

houses %>% ggplot(aes(x=crime_rate,y=price)) +
         geom_point()+
         theme_bw()+
         labs(title = "scatterplot of crime_rate v/s price")
# as alot of points are out of range, these cannot be considered as outliers

#### n_hot_rooms
houses %>% ggplot(aes(x=n_hot_rooms,y=price)) +
         geom_point()+
         theme_bw()+
         labs(title = "scatterplot of n_hot_rooms v/s price")
# we see 2 clear outliers

#### rainfall
houses %>% ggplot(aes(x=rainfall,y=price)) +
         geom_point()+
         theme_bw()+
         labs(title = "scatterplot of rainfall v/s price")
# we see 1 clear outlier

#### categorical variables

houses %>% ggplot(aes(x=airport)) + 
         geom_bar()+
         theme_bw()+
         labs(title = "airport barplot")

houses %>% ggplot(aes(x=waterbody)) + 
         geom_bar()+
         theme_bw()+
         labs(title = "waterbody barplot")

houses %>% ggplot(aes(x=bus_ter)) + 
         geom_bar()+
         theme_bw()+
         labs(title = "bus_ter barplot")
# it has only 1 value, this variable wont affect the solution and has to be ignored.


#### OUTLIERS

# treating n_hot_rooms
quantile(houses$n_hot_rooms,0.99)
#     99% 
#    15.39952 
upper1<- 3*quantile(houses$n_hot_rooms,0.99)    # 3 times the upper limit

clean_hot_rooms <- function(x){
         if (x > upper1){
                  x<- upper1
         }else{
                  x<- x
         }
}
houses$n_hot_rooms<- sapply(houses$n_hot_rooms,clean_hot_rooms)

# treating rainfall
lower1<- 0.3*quantile(houses$rainfall,0.01)  # 0.3 times the lower limit
clean_rainfall <- function(x){
         if (x < lower1){
                  x<- lower1
         }else{
                  x<- x
         }
}
houses$rainfall<- sapply(houses$rainfall,clean_rainfall)
summary(houses$rainfall)


#### MISSING VALUES 

# we will replacee n_hos_beds NA with mean value
mean_bed<- mean(houses$n_hos_beds,na.rm=TRUE)

impute_beds<- function(beds){
         out<- beds
         for(i in 1:length(beds)){
                  if(is.na(beds[i])){
                           out[i]<- mean_bed
                  }else{
                           out[i]<-beds[i]
                  }
         }
         return(out)
}
correct_beds <- impute_beds(houses$n_hos_beds)
houses$n_hos_beds<- correct_beds


##### VARIABLE TRANSFORMATION

temp1 <- houses %>% ggplot(aes(x=crime_rate,y=price)) +
         geom_point()+
         theme_bw()+
         labs(title = "crime_rate")
# it can be seen as a logarithmic relationship.
# we need it to be more linear for a better model fit

new_crime_rate <- log(1 + houses$crime_rate)

temp2 <- houses %>% ggplot(aes(x=new_crime_rate,y=price)) +
         geom_point()+
         theme_bw()+
         labs(title = "log of crime_rate")    

library(cowplot)
plot_grid(temp1,temp2)

houses$crime_rate<- new_crime_rate
# now its a much more inverse linear relationship



##### DISTANCE VARIABLES
# we have 4 distance variables, we can use their mean to make a single new one
houses <- houses %>% mutate( dist = (dist1+dist2+dist3+dist4)/4)

## hence, now we dont need dist1,dist2,dist3,dist4 and bus_ter
clean_houses <- houses %>% select(-c(dist1,dist2,dist3,dist4,bus_ter))


#### FACTORS
# we need to assign numbers to categorical variables before feeding to regression models
library(dummies)
clean_houses <- dummy.data.frame(clean_houses)

# minimum dummy variables needed = variables - 1
# we can remove airporntNO and waterbodyNone
clean_houses <- clean_houses %>% select(-c(waterbodyNone,airportNO))


#### CORRELATION

library(corrgram)
corrgram(clean_houses,order=TRUE, lower.panel=panel.shade,
         upper.panel=panel.pie, text.panel=panel.txt)


#### SAVING FINAL DATA
dir<- getwd()
path<- paste0(dir,"/houses.csv")
write.csv(clean_houses,path)
