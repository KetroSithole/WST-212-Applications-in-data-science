library(stringr)
library(lubridate)
library(nycflights13)
library(dplyr)

#Example of how the  regex template works:

# given_text <- 'I am a WST 212 student in 2021. The course material is really interesting 
#               with various components.'  
# pat_example <- 'really'
# q_example <- str_replace(given_text, pat_example, '')



#Question 1
sample_text <- 'I am a student from the University of Pretoria. I
                was born in Durban, South Africa and I have been a huge soccer
                fan for 9 years. I also have a passion for Philosophy 
                and love talking about it and discovering more things about the field. 
                Therefore, I am going to get a degree in Philosophy toimprove my chances 
                of becoming a Philosophy professor. I have been working towards this goal
                for 4 years. I am currently enrolled in a PhD program. It is very difficult, 
                but I am confident that it will be a good decision.'


pat11 <- 'Durban'
pat11

q11 <-str_extract(sample_text, pat11)

pat12 <- "([0-9])"

q12 <- str_extract_all(sample_text,pat12,simplify = TRUE)
q12

pat13 <- ("Philosophy")

q13 <-str_locate(sample_text,pat13)
q13

pat14 <- "PhD"

q14 <-str_detect(sample_text,pat14)
q14
  
#Question 2
  string <- 'Hi my name are John and my email address are john.doe@somecompany.co.uk and my friend\'s 
email are jane_doe124@gmail.com, but the following are invalid emails: j@p, jj@p, j@pp and jp.com.'

pat21 <- "[\\w]+[\\@][\\w.]+"
  
q21 <-str_extract_all(string,pat21,simplify = TRUE)
q21
  
  
pat22 <-"[\\w.][\\w.]+[\\@][\\w.]+[\\w.]+"
  
q22  <- str_extract_all(string,pat22,simplify = TRUE)
q22
  
pat23 <-"are"
  
q23 <-str_replace_all(string,pat23,"is")
q23

  
  
#Question 3
q3df <- flights %>% mutate(date = make_date(year,month,day)) %>% 
  group_by(date) %>% 
  summarise(avg_air = mean(air_time,na.rm=TRUE))

q3   <- q3df %>% filter(avg_air == max(avg_air)) %>% 
  select(date)
