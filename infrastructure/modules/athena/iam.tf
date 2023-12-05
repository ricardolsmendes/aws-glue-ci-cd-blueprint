resource "aws_iam_policy" "athena_query_results_management" {
  name        = "GlueCICDAthenaQueryResultsPolicy-${var.environment}"
  description = "Allows appropriate Athena query results management."
  policy      = data.aws_iam_policy_document.athena_query_results_management.json
  tags        = local.default_tags
}

resource "aws_iam_policy" "silver_layer_access" {
  name        = "GlueCICDSilverLayerAccessPolicy-${var.environment}"
  description = "Grants access to the assets that belong to the Silver layer."
  policy      = data.aws_iam_policy_document.silver_layer_access.json
  tags        = local.default_tags
}
