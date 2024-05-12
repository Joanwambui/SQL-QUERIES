SELECT (COUNT(*) FILTER (WHERE call_category IS NULL OR call_category = 'n/a'))::float / COUNT(*) * 100.0
FROM callers;
