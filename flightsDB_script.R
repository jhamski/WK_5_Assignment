# Homework WK 5 - IS607
# James Hamski | james.hamski@spsmail.cuny.edu
# primary reference: [PDF] - http://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf

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

# filter both by date. this makes a smaller data frame that's faster to work with and easier to QA
flights <- filter(flights, '2013-02-23' <= date & '2013-03-01' >= date)
weather <- filter(weather, '2013-02-23' <= date & '2013-03-01' >= date)

# Join the three tables. Flights and Weather are hardest to join because their hours are not in the same format.
# Round all the rows in the flights column "dep_time" 
# This isn't quite right- since the rounding will happen at "5" not "3". I know there's a work around
# by converting to a better date/time class or by using the Lubridate package, but I didn't have a chance to implement.
# the max error is 1 hour, which is likely acceptable, but far from ideal. 

flights$dep_time <-round(flights$dep_time, -2)/100

flights <- unite(flights,col = "date-time", date, dep_time, sep = " ")
weather <- unite(weather,col = "date-time", date, hour, sep = " ")

# the final data frame for the assignment will be called flights.DF
flights.DF <- left_join(flights, weather, by = "date-time")

# flights and planes join on "tailnum"
flights.DF <- left_join(flights.DF, planes.input, by = "tailnum")

# now flights.DF has way more columns than are required, so select is used

flights.DF <- select(flights.DF, origin.x, 
                     carrier, temp, dep_delay, arr_delay, air_time, seats)

#the str function indicates the data frame is as specified by the assignment
str(flights.DF)


