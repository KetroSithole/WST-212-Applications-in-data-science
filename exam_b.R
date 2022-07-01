library(stringr)
library(readr)
library(ggplot2)
library(dplyr)
library(tidyr)
library(caret)

Infl <- read_csv('appendicitis_influenza.csv')
page <- readr::read_file('sale_website')
df <- read.csv("data.csv", header=T, stringsAsFactors=F)

# q1a
q1a <- ggplot(data = Infl,
              mapping = aes(Year)) +
  geom_line(mapping = aes(y=Appendicitis),
            col='Blue') +
  geom_line(mapping = aes(y=Influenza),
            col='Red')
q1a


# q1b
q1b <- ggplot(data = Infl,
              mapping = aes(Year)) +
  geom_line(mapping = aes(y=Appendicitis),
            col='Blue') +
  geom_line(mapping = aes(y=Influenza),
            col='Red')+
  geom_area(mapping=aes(y=Appendicitis),
            fill="Blue",
            alpha=0.6) +
  geom_area(mapping=aes(y=Influenza),
            fill="Red",
            alpha=1) +
  labs(x = 'Year',
       y = 'Number of cases',
       title='Number of Influenza and Appendicitis case from 1970 to 2005')
q1b

#question2
# q2a
q2a <- gather(Infl, `Appendicitis`, 
              key = "Condition", value = "Cases") %>% select(-Influenza)
q2a

# q2b

q2b <- gather(Infl, `Appendicitis`, 
              key = "Condition", value = "Cases") %>% select(-Influenza) %>% 
  mutate_at(c('Cases'), log)
q2b

# Question 3

extract_items <- function(page){
  fn=str_extract_all(page, "<name>[\\w\\s]+", simplify = TRUE)
  str_replace(fn, '<name>',"")
}


extract_newprices <- function(page){
  fn=str_extract_all(page, "<newprice>[A-Z][\\d]+", simplify = TRUE)
  str_replace(fn, '<newprice>',"")
  
}

extract_oldprices <- function(page){
  fn=str_extract_all(page, "<oldprice>[A-Z][\\d]+", simplify = TRUE)
  str_replace(fn, '<oldprice>',"")
}
# Question 4

# q4a 

df <- df %>% select(- id,-X)
q4a <- df

# q4b 

df <- df %>% mutate(diagnosis = case_when(diagnosis == 'B' ~ 'Benign', TRUE ~ 'Malignant'))
q4b <- df

set.seed(85)

#train <- df		        	        

nrows <- nrow(df)
index <- sample(1:nrow(df), 0.7 * nrows)	

# q4c_train

q4c_train <- df[index,]		



# q4c_test 

q4c_test <- df[-index,]