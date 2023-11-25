import sys
import unittest
from unittest import mock

import sample_bronze_job


class SampleBronzeJobTest(unittest.TestCase):
    _JOB_MODULE = "sample_bronze_job"
    _JOB_CLASS = f"{_JOB_MODULE}.SampleBronzeJob"

    @mock.patch.object(
        sys,
        "argv",
        [
            "",
            "--source-bucket-name",
            "source-bucket-test",
            "--source-file-path",
            "source-file.json",
            "--target-bucket-name",
            "target-bucket-test",
            "--target-file-path",
            "bronze/target-file.json",
        ],
    )
    def setUp(self) -> None:
        self._sample_job = sample_bronze_job.SampleBronzeJob()

    def test_constructor_sets_instance_attributes(self):
        attrs = self._sample_job.__dict__
        self.assertEqual("source-bucket-test", attrs["_source_bucket_name"])
        self.assertEqual("source-file.json", attrs["_source_file_path"])
        self.assertEqual("target-bucket-test", attrs["_target_bucket_name"])
        self.assertEqual("bronze/target-file.json", attrs["_target_file_path"])

    @mock.patch(f"{_JOB_CLASS}._copy_file")
    def test_run_triggers_file_copying(self, mock_copy_file):
        self._sample_job.run()

        mock_copy_file.assert_called_once_with(
            "source-bucket-test",
            "source-file.json",
            "target-bucket-test",
            "bronze/target-file.json",
        )

    @mock.patch(f"{_JOB_MODULE}.boto3.Session")
    def test_copy_file_copies_between_buckets(self, mock_session):
        self._sample_job._copy_file(
            "source-bucket-test",
            "source-file.json",
            "target-bucket-test",
            "bronze/target-file.json",
        )

        s3 = mock_session.return_value.resource.return_value
        target_bucket = s3.Bucket.return_value

        mock_session.assert_called_once_with()
        s3.Bucket.assert_called_once_with("target-bucket-test")
        target_bucket.copy.assert_called_once_with(
            {"Bucket": "source-bucket-test", "Key": "source-file.json"},
            "bronze/target-file.json",
        )
