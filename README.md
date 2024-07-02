# Reference-Genome-mapping-Pippline
# FASTQ Alignment Pipeline

This repository contains a bash script to align paired-end FASTQ files to a reference genome using BWA and process the alignment files with SAMtools. The pipeline includes steps for aligning reads, converting SAM to BAM, sorting BAM files, and indexing the sorted BAM files.

## Features

- Aligns paired-end FASTQ files to a reference genome using BWA.
- Converts SAM files to BAM format using SAMtools.
- Sorts BAM files.
- Indexes sorted BAM files.

## Requirements

Ensure the following tools are installed and available in your PATH:

- BWA
- SAMtools
