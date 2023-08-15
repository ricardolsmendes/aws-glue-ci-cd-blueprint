import unittest

from myspark import sample_spark_job


class SampleSparkJobTest(unittest.TestCase):
    def setUp(self):
        self._job = sample_spark_job.SampleSparkJob()

    def test_constructor_sets_instance_attributes(self):
        attrs = self._job.__dict__
        self.assertIsNotNone(attrs["_glue_job"])
