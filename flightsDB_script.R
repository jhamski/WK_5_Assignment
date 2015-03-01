# Homework WK 5 - IS607
# James Hamski | james.hamski@spsmail.cuny.edu
# primary reference: [PDF] - http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf

setwd("/Users/jim/Documents/Graduate\ School/IS\ 607/Week\ 5/WK_5_Assignment")

library("dplyr")
library("tidyr")

flights.input <- read.csv("flights.csv", header = TRUE)
planes.input <- read.csv("planes.csv", header = TRUE)
weather.input <- read.csv("weather.csv", header = TRUE)

# Combine year, month, and day columns into a single Date class column
flights <- unite(flights.input,col = "date", year, month, day, sep = "-")
flights$date <- as.Date(flights$date)

weather<- unite(weather.input,col = "date", year, month, day, sep = "-")
weather$date <- as.Date(weather$date)

# filter both by date. this makes a smaller dataset that's faster to work with and easier to QA
flights <- filter(flights, '2013-02-23' <= date & '2013-03-01' >= date)
weather <- filter(weather, '2013-02-23' <= date & '2013-03-01' >= date)

#####################################

# Join the three tables. Flights and Weather are hardest to join because their hours are not in the same format.
# Round all the rows in the flights column "dep_time" to the nearest hour


# flights and weather join on "date", flights and planes join on "tailnum"
# the final data frame for the assignment will be called flights.DF
flights.DF <- left_join(flights, weather, by = "date")
flights.DF <- left_join(flights.j, planes, by = "tailnum")

#####################################

# now flights.DF has way more columns than are required, so select is used
# I'm keeping date and tailnum in so I can run a SQL query to check my work

flights.DF <- select(flights.DF, date, tailnum, origin.x, 
                     carrier, temp, dep_delay, arr_delay, air_time, seats)

# checking my work - see line xx in SQL script 
# during development, this step showed that I had not performed the proper joins
(filter(flights.DF, 'N502UA' == tailnum))


