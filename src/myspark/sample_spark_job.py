import sys

from awsglue import context, job, utils
from pyspark import context as spark_context


class SampleSparkJob:
    def __init__(self):
        # @params: [JOB_NAME]
        args = utils.getResolvedOptions(sys.argv, ["JOB_NAME"])

        sc = spark_context.SparkContext()
        self._glue_job = job.Job(context.GlueContext(sc))
        self._glue_job.init(args["JOB_NAME"], args)

    def run(self):
        self._glue_job.commit()


if __name__ == "__main__":
    SampleSparkJob().run()
