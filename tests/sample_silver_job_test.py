import sys
import unittest
from unittest import mock

import sample_silver_job


class SampleSilverJobTest(unittest.TestCase):
    _JOB_MODULE = "sample_silver_job"
    _JOB_CLASS = f"{_JOB_MODULE}.SampleSilverJob"

    @mock.patch(f"{_JOB_MODULE}.job.Job", mock.MagicMock())
    @mock.patch(f"{_JOB_MODULE}.context.GlueContext", mock.MagicMock())
    @mock.patch(
        f"{_JOB_MODULE}.spark_context.SparkContext.getOrCreate", mock.MagicMock()
    )
    @mock.patch.object(sys, "argv", ["", "--JOB_NAME", "silverJobTest"])
    def setUp(self) -> None:
        self._sample_job = sample_silver_job.SampleSilverJob()

    def test_constructor_sets_instance_attributes(self):
        attrs = self._sample_job.__dict__
        self.assertIsNotNone(attrs["_glue_context"])
        self.assertIsNotNone(attrs["_glue_job"])

    def test_constructor_initializes_glue_job(self):
        attrs = self._sample_job.__dict__
        mock_glue_job = attrs["_glue_job"]

        mock_glue_job.init.assert_called_once_with(
            "silverJobTest",
            {
                "job_bookmark_option": "job-bookmark-disable",
                "job_bookmark_from": None,
                "job_bookmark_to": None,
                "JOB_ID": None,
                "JOB_RUN_ID": None,
                "SECURITY_CONFIGURATION": None,
                "encryption_type": None,
                "enable_data_lineage": None,
                "RedshiftTempDir": None,
                "TempDir": None,
                "JOB_NAME": "silverJobTest",
            },
        )

    @mock.patch(f"{_JOB_CLASS}._read_json")
    def test_run_reads_json_and_commits_glue_job(self, mock_read_json):
        attrs = self._sample_job.__dict__
        mock_glue_job = attrs["_glue_job"]

        self._sample_job.run()

        mock_read_json.assert_called_once()
        mock_glue_job.commit.assert_called_once_with()

    def test_read_json_reads_from_s3(self):
        attrs = self._sample_job.__dict__
        mock_glue_context = attrs["_glue_context"]

        self._sample_job._read_json("s3://bucket/test.json")

        mock_glue_context.create_dynamic_frame.from_options.assert_called_once_with(
            connection_type="s3",
            connection_options={"paths": ["s3://bucket/test.json"], "recurse": True},
            format="json",
        )
