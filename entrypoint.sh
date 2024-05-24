#!/bin/bash
set -e

source activate bio_env
nextflow run "$@"
