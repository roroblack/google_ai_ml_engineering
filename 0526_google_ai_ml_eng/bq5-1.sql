-- SELECT
--   ml_predict_results.fullVisitorId,
--   ml_predict_results.predicted_label AS predicted_transactions
-- FROM
--   ML.PREDICT( MODEL `qwiklabs-gcp-02-fe4837def789`.`bqml_lab`.`sample_model`,
--     (
--     SELECT
--       july_data.os,
--       july_data.is_mobile,
--       july_data.country,
--       july_data.pageviews,
--       july_data.fullVisitorId
--     FROM
--       `qwiklabs-gcp-02-fe4837def789`.`bqml_lab`.`july_data` AS july_data )) AS ml_predict_results
-- ORDER BY
--   ml_predict_results.predicted_label DESC
-- LIMIT
--   10;



  -- This time you will try to predict the number of transactions each visitor makes, sort the results, and select the top 10 visitors by transactions.
SELECT
  fullVisitorId,
  SUM(predicted_label) AS total_predicted_transactions
FROM
  ML.PREDICT( MODEL `qwiklabs-gcp-02-fe4837def789`.`bqml_lab`.`sample_model`,
    (
    SELECT
      *
    FROM
      `qwiklabs-gcp-02-fe4837def789`.`bqml_lab`.`july_data`))
GROUP BY
  fullVisitorId
ORDER BY
  total_predicted_transactions DESC
LIMIT
  10;