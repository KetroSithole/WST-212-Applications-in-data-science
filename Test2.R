library(dplyr)
library(ggplot2)
library(tidyr)
library(readr)

species <- read_csv('species.csv')
data(who)
data(population)
data(table1)


# Question 1a
q1a <- ggplot(species,
              mapping= aes(
                x=weight,
                y=hindfoot_length))+
  geom_point()
q1a

# Question 1b

q1b<- ggplot(species)+
  aes(x=weight,y=hindfoot_length) +geom_point(aes(x=weight,y=hindfoot_length,color= species_id), alpha =0.1)
q1b

# Question 1c


q1c <- ggplot(data=species,aes(x=species_id,y=hindfoot_length))+geom_boxplot()+facet_wrap(~plot_type)
q1c

# Question 1d

q1d<- species %>% 
  group_by(year, genus) %>%
  summarise(n=n())
q1d


#Question 2

q2 <- who %>% 
  inner_join(population, by = c("country","year" ))
q2


# Question 3a
q3a <- table1 %>% select(1:3) %>% spread(country,cases)
q3a

#Question 3b

q3b<- mutate_if(table1, is.numeric, log)
q3b


