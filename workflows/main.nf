#!/usr/bin/env nextflow

nextflow.enable.dsl=2

include { runDragonflye } from '../modules/local/dragonflye'

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
