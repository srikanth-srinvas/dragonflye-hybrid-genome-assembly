# Dragonflye Nextflow Pipeline

This repository contains a Nextflow pipeline to run Dragonflye for genome assembly using Nanopore and Illumina reads. The pipeline is built following the nf-core framework standards and Dockerized for reproducibility and ease of use.

## Requirements

To run this pipeline, you need the following installed on your system:
- [Nextflow](https://www.nextflow.io/)
- [Docker](https://www.docker.com/)
- [Conda](https://docs.conda.io/en/latest/)

## Inputs

The pipeline requires the following inputs:
- A folder containing Nanopore reads (e.g., `--nanopore_reads_dir /path/to/nanopore_reads`)
- A folder containing Illumina reads (e.g., `--illumina_reads_dir /path/to/illumina_reads`)
- A text file with sample IDs (e.g., `--sample_ids /path/to/sample_ids.txt`)
- An output folder name (e.g., `--output_folder /path/to/output_folder`)

## Running the Pipeline

1. Clone this repository:
    ```bash
    git clone https://github.com/your-username/dragonflye_nfcore_pipeline.git
    cd dragonflye_nfcore_pipeline
    ```

2. Build the Docker image:
    ```bash
    docker build -t dragonflye_nfcore_pipeline .
    ```

3. Run the pipeline using Nextflow with Docker:
    ```bash
    nextflow run workflows/main.nf --nanopore_reads_dir /path/to/nanopore_reads --illumina_reads_dir /path/to/illumina_reads --sample_ids /path/to/sample_ids.txt --output_folder /path/to/output_folder -profile docker
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

If you need to change any default parameters, you can do so by editing the `nextflow.config` file directly or by passing them as command-line arguments when running the pipeline.

## Example Command

```bash
nextflow run workflows/main.nf --nanopore_reads_dir /path/to/nanopore_reads --illumina_reads_dir /path/to/illumina_reads --sample_ids /path/to/sample_ids.txt --output_folder /path/to/output_folder --cpus 16 --ram 64 --gsize '6M' -profile docker
```

## Credits 
This pipeline extends the Dragonflye pipeline by [Robert A. Petit III](https://github.com/rpetit3/dragonflye/) and leverages best practices from the [nf-core framework](https://nf-co.re/).
