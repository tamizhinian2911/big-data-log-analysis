logs = LOAD '/logs/input/NASA_access_log_Jul95'
       USING TextLoader()
       AS (line:chararray);

hours   = FOREACH logs GENERATE
          REGEX_EXTRACT(line, '\\[(\\d{2}/\\w+/\\d{4}):(\\d{2})', 2)
          AS hour;

filtered = FILTER hours BY hour IS NOT NULL;
grouped  = GROUP filtered BY hour;
counts   = FOREACH grouped GENERATE group AS hour, COUNT(filtered) AS requests;
sorted   = ORDER counts BY requests DESC;

STORE sorted INTO '/logs/output/peak_hours';
