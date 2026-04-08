USE weblog;

SELECT * FROM access_logs LIMIT 10;
SELECT COUNT(*) FROM access_logs;
SELECT * FROM access_logs WHERE line LIKE '%200%' LIMIT 10;

