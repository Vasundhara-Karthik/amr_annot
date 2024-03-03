#!/bin/bash

# Input Parameters
INPUT_DIR="$1"  # Directory containing assembly files
OUTPUT_DIR="$2"  # Base directory for RGI output
THREADS=$3
LOOP_CHOICE="$4"  # 'L' or 'S' for specific processing paths

output_path="${OUTPUT_DIR}/RGI"

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

echo "Starting RGI analysis..."

# Conditional execution based on loop choice
if [ "$LOOP_CHOICE" == "L" ]; then
    # Loop L logic for processing '.fasta' files in the INPUT_DIR
    for file in "$INPUT_DIR"/*.fasta; do
        sample_name=$(basename "$file" .fasta)
        output="${output_path}/${sample_name}"
        rgi main --input_sequence "$file" --output_file "$output" --local --clean --exclude_nudge --num_threads "$THREADS" --split_prodigal_jobs
        echo "RGI analysis completed for $sample_name"
    done
elif [ "$LOOP_CHOICE" == "S" ]; then
    for dir in "$INPUT_DIR"/*; do
        # Extract the sample name from the assembly directory
        sample_name=$(basename "$dir")
        fasta_input="$dir/assembly.fasta"
        output="${output_path}/${sample_name}"
        rgi main --input_sequence "$fasta_input" --output_file "$output" --local --clean --low_quality --exclude_nudge --num_threads "$THREADS" --split_prodigal_jobs
        echo "RGI analysis completed for $sample_name"
    done

else
    echo "Invalid loop choice. Please specify 'L' or 'S'."
    exit 1
fi

echo "RGI pipeline execution completed."
