# Dragonflye Nextflow Pipeline

![Dragonflye Nextflow Pipeline](https://www.google.com/url?sa=i&url=https%3A%2F%2Fgithub.com%2Fnf-corepsig=AOvVaw33KDGNJPbcTbrn64V2tfnM&ust=1716623482200000&source=images&cd=vfe&opi=89978449ved=0CBIQjRxqFwoTCJiYp_jmpYYDFQAAAAAdAAAAABAE)


This repository contains a Nextflow pipeline to run Dragonflye for Hybrid-genome assembly using Nanopore and Illumina reads.

## Requirements

To run this pipeline, you need the following installed on your system:
- [Docker](https://www.docker.com/)
- [Nextflow](https://www.nextflow.io/)

## Inputs

The pipeline requires the following inputs:
- A folder containing Nanopore reads (e.g., `--nanopore_reads_dir /path/to/nanopore_reads`)
- A folder containing Illumina reads (e.g., `--illumina_reads_dir /path/to/illumina_reads`)
- A text file with sample IDs (e.g., `--sample_ids /path/to/sample_ids.txt`)
- An output folder name (e.g., `--output_folder /path/to/output_folder`)

## Building the Docker Image

Before running the pipeline, you need to build the Docker image:

1. Clone this repository:
    ```bash
    git clone https://github.com/your-username/dragonflye_nextflow_pipeline.git
    cd dragonflye_nextflow_pipeline
    ```

2. Build the Docker image:
    ```bash
    docker build -t dragonflye-assembly-pipeline .
    ```

## Running the Pipeline with Docker

1. Run the Docker container with Nextflow pipeline:
    ```bash
    docker run -v /path/to/data:/workspace/data \
      dragonflye-assembly-pipeline \
      --illumina_reads_dir /workspace/data/illumina_reads \
      --nanopore_reads_dir /workspace/data/nanopore_reads \
      --sample_ids /workspace/data/sample_ids.txt \
      --output_folder /workspace/data/output
    ```

2. Example command to customize default parameters:
    ```bash
    docker run -v /path/to/data:/workspace/data \
      dragonflye-assembly-pipeline \
      --illumina_reads_dir /workspace/data/illumina_reads \
      --nanopore_reads_dir /workspace/data/nanopore_reads \
      --sample_ids /workspace/data/sample_ids.txt \
      --output_folder /workspace/data/output \
      --cpus 16 --ram 64 --gsize '6M'
    ```

## Default Parameters

The default parameters used in the pipeline are:
- CPUs: 32
- RAM: 120 GB
- Genome size: 5.5M
- Racon polish steps: 1
- Medaka polish steps: 1
- Medaka model: r941_min_sup_g507
- Polypolish steps: 1
- Pilon steps: 0

## Customizing the Pipeline

If you need to change any default parameters, you can do so by editing the `main.nf` file directly or by passing them as command-line arguments when running the pipeline.

## Example Command with Nextflow

If you prefer to run the pipeline using Nextflow directly (without Docker), use the following command:

```bash
nextflow run main.nf --nanopore_reads_dir /path/to/nanopore_reads --illumina_reads_dir /path/to/illumina_reads --sample_ids /path/to/sample_ids.txt --output_folder /path/to/output_folder --cpus 16 --ram 64 --gsize '6M'
```


## Credits 
This pipeline is based on the original Dragonflye pipeline developed by Robert A Petit III (https://github.com/rpetit3/dragonflye/)