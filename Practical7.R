library(dplyr)
library(tidyr)
library(readr)
library(ggplot2)


gapminder_orig <- read_csv("gapminder.csv")
seps_orig <- read_csv('seps.csv')

gapminder <- gapminder_orig
seps <- seps_orig

#Question 1
q1a=gapminder %>% filter(continent=="Americas",year ==2007) %>%
  select(c(-country,-lifeExp, -pop, -gdpPercap))
q1a


q1b=gapminder %>% filter(gdpPercap==min(gdpPercap))
q1b

q1c=gapminder %>% filter(gdpPercap==max(gdpPercap))
q1c

q1d=gapminder %>% mutate(gdp=gdpPercap*pop)
q1d

q1e= gapminder %>%summarise(mean_life_exp=mean(lifeExp))
q1e

q1f= gapminder %>% group_by(year) %>% 
  summarize(mean_life_exp=mean(lifeExp))
q1f

q1g= gapminder %>% group_by(continent) %>% filter(lifeExp>mean(lifeExp))%>%count(continent)
q1g

q1h=gapminder%>% mutate(high_life_expectancy=if_else(lifeExp>mean(lifeExp),1,0))
q1h

#Question 2

q2a<-seps %>% gather(key = 'year', value = 'value',FY1993:FY1998)
q2a

q2b<-seps %>% gather(key = 'year', value = 'value',FY1993:FY1998) %>% spread('Field','value')
q2b

