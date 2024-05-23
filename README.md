# Dragonflye Nextflow Pipeline

This repository contains a Nextflow pipeline to run Dragonflye for genome assembly using Nanopore and Illumina reads.

## Requirements

To run this pipeline, you need the following installed on your system:
- [Nextflow](https://www.nextflow.io/)
- [Conda](https://docs.conda.io/en/latest/)
- [Dragonflye](https://github.com/rpetit3/dragonflye) (Ensure you have installed Dragonflye and activated the conda environment before running the pipeline)
- [BWA](http://bio-bwa.sourceforge.net/)
- [Samtools](http://www.htslib.org/)

## Inputs

The pipeline requires the following inputs:
- A folder containing Nanopore reads (e.g., `--nanopore_reads_dir /path/to/nanopore_reads`)
- A folder containing Illumina reads (e.g., `--illumina_reads_dir /path/to/illumina_reads`)
- A text file with sample IDs (e.g., `--sample_ids /path/to/sample_ids.txt`)
- An output folder name (e.g., `--output_folder /path/to/output_folder`)

## Running the Pipeline

1. Clone this repository:
    ```bash
    git clone https://github.com/your-username/dragonflye_nextflow_pipeline.git
    cd dragonflye_nextflow_pipeline
    ```

2. Edit the `main.nf` file if you need to change any default parameters like CPUs, RAM, genome size, etc.

3. Run the pipeline using Nextflow:
    ```bash
    nextflow run main.nf --nanopore_reads_dir /path/to/nanopore_reads --illumina_reads_dir /path/to/illumina_reads --sample_ids /path/to/sample_ids.txt --output_folder /path/to/output_folder
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

## Example Command

```bash
nextflow run main.nf --nanopore_reads_dir /path/to/nanopore_reads --illumina_reads_dir /path/to/illumina_reads --sample_ids /path/to/sample_ids.txt --output_folder /path/to/output_folder --cpus 16 --ram 64 --gsize '6M'
