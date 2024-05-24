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
        --cpus "${task.cpus}" \\
        --ram "${task.memory.toMega()}M" \\
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