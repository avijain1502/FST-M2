-- Load the CSV file
salesTable = LOAD 'hdfs:///user/avi/sales.csv' USING PigStorage(',') AS (Product:chararray,Price:chararray,Payment_Type:chararray,Name:chararray,City:chararray,State:chararray,Country:chararray);
-- Group data using the country column
GroupByCountry = GROUP salesTable BY Country;
-- Generate result format
CountByCountry = FOREACH GroupByCountry GENERATE CONCAT((chararray)$0, CONCAT(':', (chararray)COUNT($1)));
-- remove previous results
rmf hdfs:///user/avi/salesOutput;
-- Save result in HDFS folder
STORE CountByCountry INTO 'hdfs:///user/avi/salesOutput' USING PigStorage('\t');
