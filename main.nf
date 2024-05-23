#!/usr/bin/env nextflow

// Define parameters with placeholders to be provided by the user
params.illumina_reads_dir = ''
params.nanopore_reads_dir = ''
params.sample_ids = ''
params.output_folder = ''
params.cpus = 32
params.ram = 120
params.gsize = '5.5M'
params.Racon_polish_steps = 1
params.Medaka_polish_steps = 1
params.Medaka_model = 'r941_min_sup_g507'
params.Polypolish_steps = 1
params.Pilon_steps = 0

process runDragonflye {

    input:
    val id
    path nanopore_fastq
    path forward_fastq
    path reverse_fastq

    output:
    path "${id}/*", emit: output

    script:
    """
    mkdir -p ${id}
    dragonflye \\
        --gsize "${params.gsize}" \\
        --R1 "${forward_fastq}" \\
        --R2 "${reverse_fastq}" \\
        --reads "${nanopore_fastq}" \\
        --cpus "${params.cpus}" \\
        --ram "${params.ram}" \\
        --prefix "${id}" \\
        --racon "${params.Racon_polish_steps}" \\
        --medaka "${params.Medaka_polish_steps}" \\
        --model "${params.Medaka_model}" \\
        --polypolish "${params.Polypolish_steps}" \\
        --pilon "${params.Pilon_steps}" \\
        --outdir "${id}" \\
        --force
    """
}

workflow {

    // Create a channel for sample IDs
    sample_ids_ch = Channel.fromPath(params.sample_ids).splitText()
    
    // Create channels for nanopore and illumina reads
    nanopore_reads_ch = Channel.fromFilePairs("${params.nanopore_reads_dir}/*.fastq.gz", flat: true)
    illumina_reads_ch = Channel.fromFilePairs("${params.illumina_reads_dir}/*_{1,2}.fastq.gz")

    // Combine channels and run Dragonflye for each sample
    sample_ids_ch.combine(nanopore_reads_ch, illumina_reads_ch)
                 .map { id, nanopore, illumina -> 
                     def (forward_fastq, reverse_fastq) = illumina
                     return [id, nanopore, forward_fastq, reverse_fastq] 
                 }
                 .set { samples }

    // Run Dragonflye process
    samples | runDragonflye

    // Save output to the specified output folder
    runDragonflye.out.output.publishDir(params.output_folder, mode: 'copy')
}