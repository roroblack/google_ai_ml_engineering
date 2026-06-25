
-- Function not found: TOTAL at [3:3]
-- SELECT
--   country,
--   TOTAL(predicted_label) as total_predicted_purchases
-- FROM
--   ml.PREDICT(MODEL `bqml_lab.sample_model`, (
-- SELECT * FROM `bqml_lab.july_data`))
-- GROUP BY country
-- ORDER BY total_predicted_purchases DESC
-- LIMIT 10;

-- 1. Why am I getting "Function not found: TOTAL at [3:3]" when I run this query?
-- 2. Please suggest new code to resolve any issues.
SELECT
  country,
  SUM(predicted_label) AS total_predicted_purchases
FROM
  ML.PREDICT( MODEL `qwiklabs-gcp-02-fe4837def789`.`bqml_lab`.`sample_model`,
    (
    SELECT
      os,
      is_mobile,
      country,
      pageviews
    FROM
      `qwiklabs-gcp-02-fe4837def789`.`bqml_lab`.`july_data` ))
GROUP BY
  country
ORDER BY
  total_predicted_purchases DESC
LIMIT
  10;