-- Load input file from HDFS
inputFile = LOAD 'hdfs:///user/avi/input.txt' AS (line);
-- Tokeize each word in the file (Map)
words = FOREACH inputFile GENERATE FLATTEN(TOKENIZE(line)) AS word;
-- Combine the words from the above stage
grpd = GROUP words BY word;
-- Count the occurence of each word (Reduce)
totalCount = FOREACH grpd GENERATE group, COUNT(words);
-- remove the old results
rmf hdfs:///user/avi/pigResults;
-- Store the result in HDFS
STORE totalCount INTO 'hdfs:///user/avi/pigResults';
