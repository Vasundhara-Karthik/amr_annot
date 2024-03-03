#!/bin/bash

# Define input directories, output directory, number of threads, and loop choice
ASSEMBLY_DIR="$1"
OUTPUT_DIR="$2"
THREADS="$3"
LOOP_CHOICE="$4" # 'L' for the first choice, 'S' for the second

# Check if Prokka is installed
if ! command -v prokka &> /dev/null; then
    echo "Prokka is not installed. Please install it before continuing."
    exit 1
fi

# Setup output directory
PROKKA_OUTPUT_DIR="${OUTPUT_DIR}/Prokka"
mkdir -p "${PROKKA_OUTPUT_DIR}"

echo "Starting Prokka annotation..."

# Conditional execution based on loop choice
if [ "$LOOP_CHOICE" == "L" ]; then
    # Loop L logic here
    for assembly in "${ASSEMBLY_DIR}"/*.fasta; do
        if [ -f "$assembly" ]; then
            sample_name=$(basename "$assembly" .fasta)
            prokka_output="${PROKKA_OUTPUT_DIR}/${sample_name}"
            mkdir -p "$prokka_output_dir"
            prokka --outdir "$prokka_output" --prefix "$sample_name" --addgenes "$assembly" --cpus $THREADS
            echo "Prokka annotation completed for $sample_name"
        fi
    done
elif [ "$LOOP_CHOICE" == "S" ]; then
    # Loop S logic here, adjust as necessary for your specific needs
    for unic in "{ASSEMBLY_DIR}"/*; do
    sample_name=$(basename "$assembly_dir")
    prokka_output="${PROKKA_OUTPUT_DIR}/${sample_name}"
    
    prokka --outdir "$prokka_output" --prefix "$sample_name" --addgenes "$assembly_dir/assembly.fasta" --cpus $THREADS
done

else
    echo "Invalid loop choice. Please specify 'L' or 'S'."
    exit 1
fi

echo "Prokka annotation pipeline execution completed."
