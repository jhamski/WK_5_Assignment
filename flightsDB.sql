-- SQL script for IS607 Week 5 Assignment
-- James Hamski | james.hamski@spsmail.cuny.edu

-- While I could have culled the required data far more using SQL, my goal was to rely on R as much as possible for this assignment. 

COPY(
SELECT 
*
FROM flights
WHERE origin IN ('LGA', 'EWR', 'JFK') 
AND dest = 'LAX' 
)

TO '/Users/Shared/flights.csv' WITH CSV HEADER;
-- It would be best to change the directory to the working directory for the R script, however
-- I've had difficulty figuring out the Postgres file permissions on MacOS. So, I copied the CSV files into 
-- my working directory in R. Alternatively, I could make my working directory in R be the Shared directory.

COPY(
SELECT * FROM weather
) 

TO '/Users/Shared/weather.csv' WITH CSV HEADER;

COPY(
SELECT * FROM planes
) 

TO '/Users/Shared/planes.csv' WITH CSV HEADER;



