import sys
import unittest
from unittest import mock

import sample_silver_job


class SampleSilverJobTest(unittest.TestCase):
    _JOB_MODULE = "sample_silver_job"
    _JOB_CLASS = f"{_JOB_MODULE}.SampleSilverJob"

    @mock.patch(f"{_JOB_MODULE}.context.GlueContext")
    @mock.patch(
        f"{_JOB_MODULE}.spark_context.SparkContext.getOrCreate", mock.MagicMock()
    )
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
            "--target-table-path",
            "silver/target-table",
        ],
    )
    def setUp(self, mock_glue_context) -> None:
        self._mock_glue_context = mock_glue_context
        self._sample_job = sample_silver_job.SampleSilverJob()

    def test_constructor_sets_instance_attributes(self):
        attrs = self._sample_job.__dict__
        self.assertEqual("source-bucket-test", attrs["_source_bucket_name"])
        self.assertEqual("source-file.json", attrs["_source_file_path"])
        self.assertEqual("target-bucket-test", attrs["_target_bucket_name"])
        self.assertEqual("silver/target-table", attrs["_target_table_path"])

    @mock.patch(f"{_JOB_CLASS}._write_parquet")
    @mock.patch(f"{_JOB_CLASS}._read_json")
    def test_run_triggers_read_json_and_write_parquets(
        self, mock_read_json, mock_write_parquet
    ):
        self._sample_job.run()

        dynamic_frame = mock_read_json.return_value

        mock_read_json.assert_called_once_with(
            "source-bucket-test",
            "source-file.json",
        )

        mock_write_parquet.assert_called_once_with(
            dynamic_frame,
            "target-bucket-test",
            "silver/target-table",
        )

    def test_read_json_sets_json_format_when_reading_from_s3(self):
        self._sample_job._read_json(
            "source-bucket-test",
            "source-file.json",
        )

        reader = self._mock_glue_context.return_value.create_dynamic_frame.from_options

        reader.assert_called_once_with(
            connection_type="s3",
            connection_options={
                "paths": ["s3://source-bucket-test/source-file.json"],
                "recurse": True,
            },
            format="json",
        )

    def test_write_parquet_sets_parquet_format_when_writing_to_s3(self):
        self._sample_job._write_parquet(
            None,
            "target-bucket-test",
            "target-table",
        )

        writer = self._mock_glue_context.return_value.write_dynamic_frame.from_options

        writer.assert_called_once_with(
            frame=None,
            connection_type="s3",
            connection_options={"path": "s3://target-bucket-test/target-table"},
            format="parquet",
        )
