\logs = LOAD '/logs/input/NASA_access_log_Jul95'
       USING TextLoader()
       AS (line:chararray);

requests = FOREACH logs GENERATE
           REGEX_EXTRACT(line, '^(\\S+) \\S+ \\S+ \\[([^\\]]+)\\] "(\\S+) (\\S+)[^"]*" (\\d+) (\\S+)', 4)
           AS request;

filtered = FILTER requests BY request IS NOT NULL;
grouped  = GROUP filtered BY request;
counts   = FOREACH grouped GENERATE group AS page, COUNT(filtered) AS hits;
sorted   = ORDER counts BY hits DESC;
STORE sorted INTO '/logs/output/top_pages';
