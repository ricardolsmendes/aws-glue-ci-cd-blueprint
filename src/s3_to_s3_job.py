import sys

import boto3
from awsglue import utils


class S3ToS3Job:
    """
    Copies a file from a given S3 bucket into another one.

    Job parameters:
      source-bucket-name: The source bucket name.
      source-file-path: The source file path.
      target-bucket-name: The target bucket name.
      target-file-path: The target file path.
    """

    def __init__(self):
        args = utils.getResolvedOptions(
            sys.argv,
            [
                "source-bucket-name",
                "source-file-path",
                "target-bucket-name",
                "target-file-path",
            ],
        )

        self._source_bucket_name = args["source_bucket_name"]
        self._source_file_path = args["source_file_path"]
        self._target_bucket_name = args["target_bucket_name"]
        self._target_file_path = args["target_file_path"]

    def run(self) -> None:
        self._copy_file(
            self._source_bucket_name,
            self._source_file_path,
            self._target_bucket_name,
            self._target_file_path,
        )

    @classmethod
    def _copy_file(
        cls,
        source_bucket_name: str,
        source_file_path: str,
        target_bucket_name: str,
        target_file_path: str,
    ) -> None:
        session = boto3.Session()
        s3 = session.resource("s3")

        source = {"Bucket": source_bucket_name, "Key": source_file_path}
        target_bucket = s3.Bucket(target_bucket_name)

        target_bucket.copy(source, target_file_path)


if __name__ == "__main__":
    S3ToS3Job().run()
