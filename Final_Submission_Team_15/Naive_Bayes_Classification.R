# clear variables
rm(list=ls())

#load libraries
library(plyr)
library(stringr)
library(e1071)
library(infotheo)
#library(klaR)

# Read Movie tweets. For each movie give the csv file containing the collected tweets from topsy.
mydata = read.csv("jackRyanShadowRecruit.csv", header=FALSE)
rows <- nrow(mydata)
mydata <- mydata$V1
mydata <- unlist(lapply(mydata, function(x) { str_split(x, "\n") }))

# Read AFINN List
afinn_list <- read.delim(file='AFINN-111.txt', header=FALSE, stringsAsFactors=FALSE)
names(afinn_list) <- c('word', 'score')
afinn_list$word <- tolower(afinn_list$word)

# Categorize words as per word weight/score
negTerms_5 <- c(afinn_list$word[afinn_list$score==-5])
negTerms_4 <- c(afinn_list$word[afinn_list$score==-4])
negTerms_3 <- c(afinn_list$word[afinn_list$score==-3])
negTerms_2 <- c(afinn_list$word[afinn_list$score==-2])
negTerms_1 <- c(afinn_list$word[afinn_list$score==-1])
posTerms_5 <- c(afinn_list$word[afinn_list$score==5])
posTerms_4 <- c(afinn_list$word[afinn_list$score==4])
posTerms_3 <- c(afinn_list$word[afinn_list$score==3])
posTerms_2 <- c(afinn_list$word[afinn_list$score==2])
posTerms_1 <- c(afinn_list$word[afinn_list$score==1])
final_scores <- matrix('', 0, 11)


for (i in 1:rows)
{
  initial_sentence <- mydata[i]
  # Remove the punctuation, control factors, digits and convert to lower case
  mydata[i] <- gsub('[[:punct:]]', '', mydata[i])
  mydata[i] <- gsub('[[:cntrl:]]', '', mydata[i])
  mydata[i] <- gsub('\\d+', '', mydata[i])
  mydata[i] <- tolower(mydata[i])
  wordList <- str_split(mydata[i], '\\s+')
  words <- unlist(wordList)
  
  #Match the words
  posMatches_5 <- match(words, posTerms_5)
  posMatches_4 <- match(words, posTerms_4)
  posMatches_3 <- match(words, posTerms_3)
  posMatches_2 <- match(words, posTerms_2)
  posMatches_1 <- match(words, posTerms_1)
  negMatches_5 <- match(words, negTerms_5)
  negMatches_4 <- match(words, negTerms_4)
  negMatches_3 <- match(words, negTerms_3)
  negMatches_2 <- match(words, negTerms_2)
  negMatches_1 <- match(words, negTerms_1)
  posMatches_5 <- sum(!is.na(posMatches_5))
  posMatches_4 <- sum(!is.na(posMatches_4))
  posMatches_3 <- sum(!is.na(posMatches_3))
  posMatches_2 <- sum(!is.na(posMatches_2))
  posMatches_1 <- sum(!is.na(posMatches_1))
  negMatches_5 <- sum(!is.na(negMatches_5))
  negMatches_4 <- sum(!is.na(negMatches_4))
  negMatches_3 <- sum(!is.na(negMatches_3))
  negMatches_2 <- sum(!is.na(negMatches_2))
  negMatches_1 <- sum(!is.na(negMatches_1))
  score <- c(negMatches_5, negMatches_4, negMatches_3, negMatches_2, negMatches_1, posMatches_1, posMatches_2, posMatches_3, posMatches_4, posMatches_5)
  newrow <- c(initial_sentence, score)
  final_scores <- rbind(final_scores, newrow)
}
rownames(final_scores) <- NULL

temp<- final_scores
temp_rows <- nrow(temp)
neg_sum = 0
pos_sum = 0
neut_sum = 0

# Classifying the tweets depending upon the score of the tweet
for(k in 1:temp_rows){
  c_n = as.numeric(temp[k,2])*-5 + as.numeric(temp[k,3])*-4 + as.numeric(temp[k,4])*-3 + as.numeric(temp[k,5])*-2 + as.numeric(temp[k,6])*-1 + as.numeric(temp[k,7])*1 + as.numeric(temp[k,8])*2 + as.numeric(temp[k,9])*3 + as.numeric(temp[k,10])*4 + as.numeric(temp[k,11])*5
  if(c_n > 0){
    pos_sum = pos_sum + 1;
  }
  else if(c_n < 0){
    neg_sum = neg_sum + 1;
  }
  else {
    neut_sum = neut_sum + 1;
  }
}



final <- matrix('',0,6)
colnames(final) <- c('Movie Name', '-ve tweets', '+ve tweets', 'neutral tweets', 'total tweets', 'status')
newest_row <- c('Jack Ryan: Shadow Recruit',neg_sum, pos_sum, neut_sum, temp_rows, 'flop')
final <- rbind(final, newest_row)
rownames(final) <- NULL

# classify as bins
prob_scores <- matrix('',0,4)
j <- 1
colnames(prob_scores) <- c('Movie_Name', 'neg_tweets', 'pos_tweets', 'neut_tweets', 'total_tweets', 'status')
for(j in 1:nrow(final)){
  neg_prob <- as.numeric(final[j,2])/as.numeric(final[j,5])
  pos_prob <- as.numeric( final[j,3])/as.numeric(final[j,5])
  neut_prob <- as.numeric(final[j,4])/as.numeric(final[j,5])
  if(neg_prob < 0.25){
    negp <- 1
  }else if(neg_prob >= 0.25 && neg_prob < 0.5){
    negp <- 2
  }else if(neg_prob >= 0.5 && neg_prob < 0.75){
    negp <- 3
  }else {
    negp <- 4
  }
  
  if(pos_prob < 0.25){
    posp <- 1
  }else if(pos_prob >= 0.25 && pos_prob < 0.5){
    posp <- 2
  }else if(pos_prob >= 0.5 && pos_prob < 0.75){
    posp <- 3
  }else {
    posp <- 4
  }
  
  if(neut_prob < 0.25){
    neup <- 1
  }else if(neut_prob >= 0.25 && neut_prob < 0.5){
    neup <- 2
  }else if(neut_prob >= 0.5 && neut_prob < 0.75){
    neup <- 3
  }else {
    neup <- 4
  }
  
  if(final[j,6] == "hit"){
    status = 1
  }else{
    status = 0
  }
  prob_row <- c(as.numeric(negp),as.numeric(posp),as.numeric(neup) , as.numeric(status))
  prob_scores <- rbind(prob_scores, prob_row)
}
rownames(prob_scores) <- NULL






class(prob_scores) <- "numeric"

prob_df <- as.data.frame(prob_scores)


## builing classifier using training data
# t_data = read.csv("training_data_set_naiveBayes.csv", header=FALSE)
# tr_df <- as.data.frame(t_data)
# classifier <- naiveBayes(as.factor(V4)~. , data=tr_df)
# classifier
# table(predict(classifier, newdata = tr_df), tr_df[,4])
# predict(classifier, newdata = tr_df)

# using classifier to predict test data
table(predict(classifier, newdata = prob_df), prob_df[,4])
predict(classifier, newdata = prob_df)
