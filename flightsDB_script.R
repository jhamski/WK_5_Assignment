# Homework WK 5 - IS607
# James Hamski | james.hamski@spsmail.cuny.edu

setwd("/Users/jim/Documents/Graduate\ School/IS\ 607/Week\ 5/WK_5_Assignment")

library("dplyr")

flights <- read.csv("flights.csv", header = TRUE)
planes <- read.csv("planes.csv", header = TRUE)
flights <- read.csv("weather.csv", header = TRUE)

