import sys
from typing import Any

from awsglue import context, utils
from pyspark import context as spark_context


class SampleSilverJob:
    """
    Transforms a JSON file from the data lake's bronze logical layer into a Parquet table
    in the silver layer.

    Job parameters:
      source-bucket-name: The source bucket name.
      source-file-path: The source file path.
      target-bucket-name: The target bucket name.
      target-table-path: The target table path.
    """

    def __init__(self):
        args = utils.getResolvedOptions(
            sys.argv,
            [
                "source-bucket-name",
                "source-file-path",
                "target-bucket-name",
                "target-table-path",
            ],
        )

        self._source_bucket_name = args["source_bucket_name"]
        self._source_file_path = args["source_file_path"]
        self._target_bucket_name = args["target_bucket_name"]
        self._target_table_path = args["target_table_path"]

        self._glue_context = context.GlueContext(
            spark_context.SparkContext.getOrCreate()
        )

    def run(self) -> None:
        dynamic_frame = self._read_json(
            self._source_bucket_name, self._source_file_path
        )
        self._write_parquet(
            dynamic_frame, self._target_bucket_name, self._target_table_path
        )

    def _read_json(self, source_bucket_name: str, source_file_path: str) -> Any:
        return self._glue_context.create_dynamic_frame.from_options(
            connection_type="s3",
            connection_options={
                "paths": [f"s3://{source_bucket_name}/{source_file_path}"],
                "recurse": True,
            },
            format="json",
        )

    def _write_parquet(
        self, dynamic_frame: Any, target_bucket_name: str, target_table_path: str
    ) -> Any:
        return self._glue_context.write_dynamic_frame.from_options(
            frame=dynamic_frame,
            connection_type="s3",
            connection_options={
                "path": f"s3://{target_bucket_name}/{target_table_path}"
            },
            format="parquet",
        )


if __name__ == "__main__":
    SampleSilverJob().run()
