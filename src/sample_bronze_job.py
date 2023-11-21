import sys
from typing import Any

from awsglue import context, job, utils
from pyspark import context as spark_context


class SampleBronzeJob:
    def __init__(self):
        # @params: [JOB_NAME]
        args = utils.getResolvedOptions(sys.argv, ["JOB_NAME"])

        self._glue_context = context.GlueContext(
            spark_context.SparkContext.getOrCreate()
        )
        self._glue_job = job.Job(self._glue_context)
        self._glue_job.init(args["JOB_NAME"], args)

    def run(self) -> None:
        self._read_json("TBD")  # TODO: Read S3 path from the job parameters.
        self._glue_job.commit()

    def _read_json(self, path) -> Any:
        return self._glue_context.create_dynamic_frame.from_options(
            connection_type="s3",
            connection_options={"paths": [path], "recurse": True},
            format="json",
        )


if __name__ == "__main__":
    SampleBronzeJob().run()
