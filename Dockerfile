# Use an official Python runtime as a parent image
FROM continuumio/miniconda3

# Set the working directory
WORKDIR /workspace

# Install Nextflow
RUN conda install -c bioconda nextflow

# Install Dragonflye and other dependencies
RUN conda install -c bioconda dragonflye bwa samtools

# Copy the Nextflow pipeline script and the entrypoint script into the container
COPY . .

# Make the entrypoint script executable
RUN chmod +x entrypoint.sh

# Set the entrypoint script as the container's entry point
ENTRYPOINT ["/workspace/entrypoint.sh"]
