resource "aws_iam_policy" "athena_query_results_management" {
  name        = "GlueCICDAthenaQueryResultsPolicy-${var.environment}"
  description = "Allows appropriate Athena query results management."
  policy      = data.aws_iam_policy_document.athena_query_results_management.json
}

resource "aws_iam_policy" "silver_tables_read_access" {
  name        = "GlueCICDSilverLayerAccessPolicy-${var.environment}"
  description = "Grants read access to the tables that belong to the Silver layer."
  policy      = data.aws_iam_policy_document.silver_tables_read_access.json
}
