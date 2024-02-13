# AWS Glue CI/CD Blueprint

This repository contains a blueprint CI/CD pipeline for building, testing, and deploying
data processing jobs in [AWS Glue](https://aws.amazon.com/glue/). It is the companion
repository for the [Streamlining AWS Glue CI/CD — A Comprehensive
Blueprint](https://github.com/ricardolsmendes/aws-glue-ci-cd-blueprint) blog post.

[![license](https://img.shields.io/github/license/ricardolsmendes/aws-glue-ci-cd-blueprint.svg)](https://github.com/ricardolsmendes/aws-glue-ci-cd-blueprint/blob/main/LICENSE)
[![issues](https://img.shields.io/github/issues/ricardolsmendes/aws-glue-ci-cd-blueprint.svg)](https://github.com/ricardolsmendes/aws-glue-ci-cd-blueprint/issues)
[![continuous integration](https://github.com/ricardolsmendes/aws-glue-ci-cd-blueprint/actions/workflows/on-push-to-main.yaml/badge.svg)](https://github.com/ricardolsmendes/aws-glue-ci-cd-blueprint/actions/workflows/on-push-to-main.yaml)

<!-- Pytest Coverage Comment:Begin -->
<a href="https://github.com/ricardolsmendes/aws-glue-ci-cd-blueprint/blob/main/README.md"><img alt="Coverage" src="https://img.shields.io/badge/Coverage-95%25-brightgreen.svg" /></a><details><summary>Coverage Report </summary><table><tr><th>File</th><th>Stmts</th><th>Miss</th><th>Cover</th><th>Missing</th></tr><tbody><tr><td colspan="5"><b>src</b></td></tr><tr><td>&nbsp; &nbsp;<a href="https://github.com/ricardolsmendes/aws-glue-ci-cd-blueprint/blob/main/src/s3_json_to_parquet_job.py">s3_json_to_parquet_job.py</a></td><td>21</td><td>1</td><td>95%</td><td><a href="https://github.com/ricardolsmendes/aws-glue-ci-cd-blueprint/blob/main/src/s3_json_to_parquet_job.py#L72">72</a></td></tr><tr><td>&nbsp; &nbsp;<a href="https://github.com/ricardolsmendes/aws-glue-ci-cd-blueprint/blob/main/src/s3_to_s3_job.py">s3_to_s3_job.py</a></td><td>21</td><td>1</td><td>95%</td><td><a href="https://github.com/ricardolsmendes/aws-glue-ci-cd-blueprint/blob/main/src/s3_to_s3_job.py#L60">60</a></td></tr><tr><td><b>TOTAL</b></td><td><b>42</b></td><td><b>2</b></td><td><b>95%</b></td><td>&nbsp;</td></tr></tbody></table></details>
<!-- Pytest Coverage Comment:End -->

## 1. Overview

### 1.1. Continuous Integration / Continuous Delivery

- [GitHub Actions](https://github.com/ricardolsmendes/aws-glue-ci-cd-blueprint/blob/main/.github/workflows)

### 1.2. Infrastructure as Code

- [Terraform](https://github.com/ricardolsmendes/aws-glue-ci-cd-blueprint/blob/main/infrastructure)

### 1.3. Quality Assurance

- [Python unit tests: unittest + pytest](https://github.com/ricardolsmendes/aws-glue-ci-cd-blueprint/blob/main/tests)
- Python formatter: [Black](https://github.com/psf/black)
- Python linter: [Flake8](https://github.com/PyCQA/flake8)

## 2. How to contribute

Please make sure to take a moment and read the [Code of
Conduct](https://github.com/ricardolsmendes/aws-glue-ci-cd-blueprint/blob/main/.github/CODE_OF_CONDUCT.md).

### 2.1. Report issues

Please report bugs and suggest features via the [GitHub
Issues](https://github.com/ricardolsmendes/aws-glue-ci-cd-blueprint/issues).

Before opening an issue, search the tracker for possible duplicates. If you find a
duplicate, please add a comment saying that you encountered the problem as well.

### 2.2. Contribute code

Please make sure to read the [Contributing
Guide](https://github.com/ricardolsmendes/aws-glue-ci-cd-blueprint/blob/main/.github/CONTRIBUTING.md)
before making a pull request.
