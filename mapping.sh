#!/bin/bash

# Set paths to folders
fastq_folder="fastqfiles"
reference_folder="Reference"
bam_folder="bam"

# Set reference genome
reference="${reference_folder}/genome.fa"

# List of sample prefixes
sample_prefixes=("sample1" "sample2" "sample3")

# Create output folders if they don't exist
mkdir -p "${bam_folder}"

# Index the reference genome (if not already indexed)
if [ ! -e "${reference}.bwt" ]; then
    echo "Indexing reference genome..."
    bwa index "${reference}"
fi

# Loop through each sample
for sample_prefix in "${sample_prefixes[@]}"; do

    # Set output prefix
    output_prefix="${bam_folder}/aligned_${sample_prefix}"

    # Step 2: Align forward and reverse reads
    echo "Aligning reads for ${sample_prefix}..."
    bwa mem "${reference}" "${fastq_folder}/${sample_prefix}_R1.fastq" "${fastq_folder}/${sample_prefix}_R2.fastq" > "${output_prefix}.sam"

    # Check if the SAM file is not empty
    if [ ! -s "${output_prefix}.sam" ]; then
        echo "Error: SAM file is empty for ${sample_prefix}. Alignment may have failed."
        exit 1
    fi

    # Step 3: Convert SAM to BAM
    echo "Converting SAM to BAM..."
    samtools view -bS "${output_prefix}.sam" > "${output_prefix}.bam"

    # Step 4: Sort the BAM file
    echo "Sorting BAM file..."
    samtools sort "${output_prefix}.bam" -o "${output_prefix}_sorted.bam"

    # Step 5: Index the sorted BAM file
    echo "Indexing sorted BAM file..."
    samtools index "${output_prefix}_sorted.bam"

    # Optional: Clean up intermediate files
    # rm "${output_prefix}.sam" "${output_prefix}.bam" "${output_prefix}_sorted.bam" "${output_prefix}_sorted.bam.bai"

    echo "Alignment for ${sample_prefix} completed successfully."

done

