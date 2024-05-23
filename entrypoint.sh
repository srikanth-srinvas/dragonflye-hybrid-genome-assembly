#!/bin/bash

# Check if Nextflow is installed
if ! command -v nextflow &>/dev/null; then
    echo "Nextflow could not be found"
    exit
fi

# Run the Nextflow pipeline with the provided arguments
nextflow run main.nf -profile docker "$@"
