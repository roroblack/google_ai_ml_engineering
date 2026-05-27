-- Create a model name sample_model, type logistic_reg to predict whether a visitor will make a transaction using the training_data view table.
CREATE MODEL
  `qwiklabs-gcp-02-fe4837def789`.`bqml_lab`.`sample_model` OPTIONS ( model_type = 'logistic_reg',
    input_label_cols = ['label']) AS
SELECT
  *
FROM
  `qwiklabs-gcp-02-fe4837def789`.`bqml_lab`.`training_data`;


  