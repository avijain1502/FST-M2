-- Load input file from HDFS
inputFile = LOAD 'hdfs:///user/avi/inputs' USING PigStorage('\t') AS (name:chararray, line:chararray);

-- filter out the first 2 lines from each file
ranked = RANK inputFile;
OnlyDialog = filter ranked BY (rank_inputFile>2);

-- Group by Name
grpd = GROUP OnlyDialog BY name;

-- Count the occurence of each word (Reduce)
names = FOREACH grpd GENERATE $0 as name, COUNT($1) as no_of_lines;
namesOrdered = ORDER names BY no_of_lines DESC;

-- remove the old results
rmf hdfs:///user/avi/pigProjectResults;

-- Store the result in HDFS
STORE namesOrdered INTO 'hdfs:///user/avi/pigProjectResults' USING PigStorage('\t');
