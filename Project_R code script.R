## Data Analysis and Preprocessing
#1
# Load the required libraries and the data 'projectdata.csv' and call it p
library(dplyr)
library(ggplot2)
setwd(choose.dir())

#read.csv('projectdata.csv',stringsAsFactors = FALSE)   -> p
read.csv('projectdata.csv')   -> p

#2
# Look at the structure of the dataset
View(p)
str(p)

#3
# Change the description variable from factor to character
p$description <- as.character(p$description)

#4
# Re-look at the structure of the dataset
str(p)

#5
# Explore the data - which variables have missing values and what is the count of these missing values
summary(p)

#6
# check the number of unique values in each column
p_columns <- ((colnames(p)))
class(p_columns)
library(stringr)
for (i in p_columns){

  print(str_c(i,':',length(unique(p[,i]))))

}

#7
# what is the median price
price_med <- median(p$startprice)

#8
# add a variable priceclass, which takes value 1 if the price is above median value, or 0 otherwise
p =p %>% mutate(priceclass=ifelse(p$startprice>price_med,1,0)) 
View(p)

#9
# Re-look at the structure of the dataset 
str(p)

#10
# Identify and convert categorical variables to factor 

p$biddable   <- as.factor(p$biddable)
p$sold       <- as.factor(p$sold)
p$UniqueID   <- as.factor(p$UniqueID)
p$priceclass <- as.factor(p$priceclass)
p$storage    <- as.factor(p$storage)
str(p)
summary(p)

#11
# Find Maximum value of all numerical variables 

num_col <- unlist(lapply(p,is.numeric))
for (x in (1:length(num_col))){

  if ((num_col)[x] == T) {

    colname <- names(num_col)[x]

    print(paste(colname,':',max(p[colname])))

    

  }

}

#12
# Find Maximum value of all categorical variables

fac_col <- unlist(lapply(p,is.factor))
for (x in (1:length(fac_col))){

  if ((fac_col)[x] == T) {

    print(names(fac_col)[x])

  }

}

 

print(apply(p[fac_col],2,max,na.rm = F))

 

#13

# use lapply function to Calculate Median of each of the numerical variables 

 

num_col <- unlist(lapply(p,is.numeric))

 

lapply(p[num_col],median)

 

#14

# use lapply function to Calculate standard deviation of each of the numerical variables 

 

num_col <- unlist(lapply(p,is.numeric))

 

lapply(p[num_col],sd)

 

#15

# use the tapply function to calculate the median price according to sold 

 

tapply(p$startprice, p$sold, median)

 

#16

# use the tapply function to calculate the median price according to biddable

 

tapply(p$startprice, p$biddable, median)

 

## Data Manipulation and EDA 

 

#17

# Load the dplyr package 

 

library(dplyr)

 

#18

# Print out a df with the columns startprice, condition, and sold

 

o <- select(p,c('startprice','condition','sold'))

 

View(o)

 

#19

# Print out the columns biddable to sold 

 

l <- select(p,c(-1,-11,-12))

 

View(l)

 

#20

# Add the new variable var1 which calculates the ratio of storage to startprice and save the result in p

 

p =p %>% mutate(var1 = as.numeric(storage)/as.numeric(startprice)) 

 

View(p)

 

#21

# Arrange p by price

 

p <- arrange(p,startprice)

 

#22

# Arrange p so that condition is grouped 

 

p <- arrange(p,condition)

 

#23

# Arrange p so that biddable and sold is grouped 

 

help("arrange")

 

p <- arrange(p,condition,sold)

 

#24

# Definition of notbought - create a df of observations when ipad was notsold 

 

notbought <- filter(p,sold==0)

View(notbought)

 

#25

#  Arrange notbought so that condition and sold is is grouped 

 

notbought <- arrange(notbought,condition,sold)

 

#26

# Generate summary about startprice column of p. Summary should include min, max, mean, sd and IQR 

 

library(purrr)

 

# invoke_map(list(min_startprice='min', max_startprice='max', mean_startprice = 'mean',sd_startprice ='sd', 

#                 IQR_startprice = 'IQR'),

#            list(p$startprice,p$startprice,p$startprice,p$startprice,p$startprice))

 

summarise(p,min=min(p$startprice)

           ,max=max(p$startprice)

           ,mean=mean(p$startprice)

           ,standard_deviation=sd(p$startprice)

           ,IQR(p$startprice)

          )

 

#27

# Generate summary about storage column of housing

 

summary(p$storage)

 

## Visualization 

 

#28

# Load the required package 

 

library(ggplot2)

 

#29

# Create a scatter plot between startprice and storage 

 

ggplot(data=p,aes(y=startprice,x=storage))+geom_point()

 

#30

# In the above plot, add the color argument which should be dependent on the sold Variable

 

ggplot(data=p,aes(y=startprice,x=storage,color = sold))+geom_point()

 

#31

# In the above plot where you had used the color argument, please add the smooth line using 

# the geom_smooth() function 

 

ggplot(data=p,aes(y=startprice,x=storage,color = sold))+geom_point()+geom_smooth()

 

#32

# Make a univariate histogram on startprice

 

ggplot(data=p,aes(x=startprice))+geom_histogram(bins=40)

 

#33

# In the above plot, add set binwidth to 200 in the geom layer

 

ggplot(data=p,aes(x=startprice))+geom_histogram(bins=30,binwidth = 200)

 

#34

# In the above plot,  MAP ..density.. to the y aesthetic (i.e. in a second aes() function)

 

ggplot(data=p,aes(x=startprice))+geom_histogram(aes(y=..density..),bins=30,binwidth = 200)

 

#35

# Now, In the above plot, plus SET the fill attribute to "#377EB8"

 

ggplot(data=p,aes(x=startprice))+geom_histogram(aes(y=..density..),bins=30,binwidth = 200,fill='#377EB8')

 

#36

# Draw a bar plot of sold, filled according to biddable 

 

ggplot(data=p,aes(x=sold,fill=biddable))+geom_bar()

 

#37

# In the previous plot, Change the position argument to "stack""

 

ggplot(data=p,aes(x=sold,fill=biddable))+geom_bar(position = "stack")

 

#38

# Change the position argument to "fill"

 

ggplot(data=p,aes(x=sold,fill=biddable))+geom_bar(position = "fill")

 

#39

# Change the position argument to "dodge"

 

ggplot(data=p,aes(x=sold,fill=biddable))+geom_bar(position = "dodge")

 

#40

# Now create a basic scatter plot between pce and psavert variables on econ_2: 

 

ggplot(data=p,aes(y=startprice,x=storage))+geom_point()

 

#41

# Separate rows according to sold 

 

ggplot(data=p,aes(y=startprice,x=storage))+geom_point()+facet_grid(sold ~. )

 

#42

# Separate columns according to biddable 

 

ggplot(data=p,aes(y=startprice,x=storage))+geom_point()+facet_grid(.~biddable )

 

#43

# Separate by both columns and rows 

 

ggplot(data=p,aes(y=startprice,x=storage))+geom_point()+facet_grid( sold~biddable)

 

## Text Analytics

 

#44

# load the required packages and libraries required for text analytics 

 

library(wordcloud)

library(wordcloud2)

library(tm)

library(SnowballC)

library(stringr)

library(readr)

library(DT)

 

 

#45

# Now, extract the relevant variable, the one containing the text. Please copy the following code as below

 

r1 = as.character(p$description) 

#Set the seed to 100 for code reproducibility 

set.seed(100) 

# run the following command, 'sample = sample(r1, (length(r1)))', in your RStudio, now 

#you are ready for Bag of Words 

sample = sample(r1, (length(r1))) 

 

#46

# Create a Corpus - which, in simple terms, is nothing but a collection of text documents

 

H1 <- VectorSource(sample)

 

H2 <- VCorpus(H1)

 

#47

# Now, remove punctuations

 

H3 <- tm_map(H2,removePunctuation)

H3[[790]][1]

 

#48

# Next, change the case of the word to lowercase so that same words are not counted as different 

#because of lower or upper case.

 

H4 <- tm_map(H3,content_transformer(tolower))

H4[[765]][1]

 

#49

# Next, remove numbers

 

H5 <- tm_map(H4,removeNumbers)

H5[[765]][1]

 

#50

# Next, remove whitespaces

 

H6 <- tm_map(H5,stripWhitespace)

H6[[765]][1]

 

#51

# Now, remove unhelpful terms, also referred as stopwords

 

H7 <- tm_map(H6,removeWords,stopwords('english'))

H7[[765]][1]

 

#52

# Now, please carry out the process of stemming, motivated by the desire to represent words 

# with different endings as the same word.

 

H8 <- tm_map(H7,stemDocument)

H8[[765]][1]

 

#53

# creat a document term matrix from the corpus

 

H9 <- DocumentTermMatrix(H8)

 

#54

# now create the data frame from the output of the above line

 

H10 <- as.matrix(H9)

dim(H10)

 

View(H10)

 

H11 <- sort(colSums(H10),decreasing = T)

View(H11)

 

H12 <- data.frame(word=names(H11),freq=H11)

View(H12)

 

#55

# Create a word cloud and set random.order = TRUE:

 

library(wordcloud)

 

wordcloud(word=H12$word,freq=H12$freq,random.order = TRUE)

 

#56

# Create a word cloud and set random.order = FALSE:

 

wordcloud(word=H12$word,freq = H12$freq,random.order = FALSE)

 

#57

# In the above word cloud, adjust the frequency level with min.freq parameter set at 5

 

wordcloud(word=H12$word, freq=H12$freq,random.order = FALSE,min.freq = 5)

 

## Text Analytics - Creating Word Cloud for Un Sold ipads

 

# 58

#Create a new dataframe from the original data 'p' which only includes those observations where the ipad was not sold

 

notsoldipads = subset(p, sold == 0)

View(notsoldipads)

 

n1 = as.character(notsoldipads$description)

#Set the seed to 100 for code reproducibility

set.seed(100)

#sample

sample2 = sample(n1,(length(n1)))

 

#59

##Bag of Words - Run the above codes

#1 - Create a Corpus

#2 - Remove punctuations

#3 - Convert to lowercase

#4 - Remove Numbers

#5 - Remove whitespaces

#6 - Remove stopwords

#7 - Perform Stemminga

 

L1 <- VectorSource(sample2)

L2 <- VCorpus(L1)

 

L3 <- tm_map(L2,removePunctuation)

L3[[413]][1]

 

L4 <- tm_map(L3,content_transformer(tolower))

L4[[413]][1]

 

L5 <- tm_map(L4,removeNumbers)

L5[[413]][1]

 

L6 <- tm_map(L5,stripWhitespace)

L6[[413]][1]

 

L7 <- tm_map(L6,removeWords,stopwords('en'))

L7[[413]][1]

 

corpus2 <- tm_map(L7,stemDocument)

corpus2[[411]][1]

 

# 60

# create a document term matrix from the resultant corpus. Run the following codes

 

frequencies2 = DocumentTermMatrix(corpus2)

 

# 61

# now create the data frame from the output of the above line

 

# Create three word clouds using the following three instructions

# WordCloud 1 - Create a word cloud and set random.order = TRUE.

# WordCloud 2 - Create a word cloud and set random.order = FALSE

# WordCloud 3 - In the above word cloud, adjust the frequency level with min.freq parameter set at 5

 

L8 <- as.matrix(frequencies2)

View(L8)

 

L9 <- sort(colSums(L8),decreasing = T)

View(L9)

 

L10 <- data.frame(word=names(L9),freq=L9)

View(L10)

 

wordcloud(word=L10$word,freq=L10$freq,random.order = T)

wordcloud(word=L10$word,freq=L10$freq,random.order = F)

wordcloud(word=L10$word,freq=L10$freq,random.order = F,min.freq = 5)

 

## Creating Word Cloud for Sold ipads

 

# 62

# Create a new dataframe from the original data 'p_sold' 

# which only includes those observations where the ipad was sold

 

p_sold = subset(p,sold == 1)

View(p_sold)

 

# 63

# Now, run the following commands in your R Studio , extracting relevant positive tweets

 

p1 = as.character(p_sold$description)

#Set the seed to 100 for code reproducibility

set.seed(100)

#sample

sample3 = sample(p1, (length(p1)))

 

# 64

# Bag of Words - Run the above codes

#1 - Create a Corpus

#2 - Remove punctuations

#3 - Convert to lowercase

#4 - Remove Numbers

#5 - Remove whitespaces

#6 - Remove stopwords

#7 Perform Stemming

 

U1 <- VectorSource(sample3)

U2 <- VCorpus(U1)

 

U3 <- tm_map(U2,removePunctuation)

U3[[340]][1]

 

U4 <- tm_map(U3,content_transformer(tolower))

U4[[340]][1]

 

U5 <- tm_map(U4,removeNumbers)

U5[[340]][1]

 

U6 <- tm_map(U5,stripWhitespace)

U6[[340]][1]

 

U7 <- tm_map(U6,removeWords,stopwords('en'))

U7[[340]][1]

 

U8 <- tm_map(U7,stemDocument)

U8[[340]][1]

 

# 65

# creat a document term matrix from the resultant corpus

 

U9 <- DocumentTermMatrix(U8)

 

# 66

# now create the data frame from the output of the above line

 

U10 <- as.matrix(U9)

 

U11 <- sort(colSums(U10),decreasing = TRUE)

View(U11)

 

U12 <- data.frame(word=names(U11),freq=U11)

View(U12)

 

# 67

# Create three-word clouds using the following three instructions

# WordCloud 1 - Create a word cloud and set random.order = TRUE.

# WordCloud 2 - Create a word cloud and set random.order = FALSE

# WordCloud 3 - In the above word cloud, adjust the frequency level with min.freq parameter set at 5

 

wordcloud(word=U12$word,freq=U12$freq,random.order = T)

wordcloud(word=U12$word,freq=U12$freq,random.order = F)

wordcloud(word=U12$word,freq=U12$freq,random.order = F,min.freq = 5)

 
