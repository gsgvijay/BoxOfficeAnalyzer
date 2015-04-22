
setwd("C:\\Users\\Kshitij\\Desktop\\ALDA\\Project")
movie_details<-read.table('list3.csv',header = TRUE, sep = ",")
formula <- as.formula("weekend ~ Sentiment + Cast + Budget")
lm.earning<-lm(formula, data = movie_details)
plot(lm.earning)
summary(lm.earning)
# Residual should be normally distributed.
lm.earning.res = resid(lm.earning) 
# The bell curve histogram shows that the 
hist(lm.earning.res, main="Histogram of Residuals", xlab = "bf residuals")


#Predicting the earnings
#predict(lm.earning, data.frame(Cast=2.2 , Budget=250), interval="prediction")
predict(lm.earning, data.frame(Sentiment = 0, Cast=1.47, Budget=1.77), interval="confidence")

var<- c("Cast","Budget", "Sentiment")
plot(subsetvar)
subsetvar <- movie_details[var]
plot(subsetvar)

cor(subsetvar)
cor.test(subsetvar[,1],subsetvar[,2])
cor.test(subsetvar[,2],subsetvar[,3])
cor.test(subsetvar[,1],subsetvar[,3])

