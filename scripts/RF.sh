#!/bin/bash

# Input Parameters
INPUT_DIR="$1"  # Directory containing assembly files
OUTPUT_DIR="$2"  # Base directory for ResFinder output
THREADS="$3"  # Number of threads for processing
LOOP_CHOICE="$4"  # 'L' for a specific condition, 'S' for another
BLAST_PATH="$5"
res_db_path="$7"
point_db_path="$8"

output_path="${OUTPUT_DIR}/RF"

# Check if ResFinder script exists
if [ ! -f "run_resfinder.py" ]; then
    echo "ResFinder script not found. Please check the path."
    exit 1
fi

# Setup output directory
mkdir -p "$output_path"

echo "Starting ResFinder analysis..."

# Conditional execution based on loop choice
if [ "$LOOP_CHOICE" == "L" ]; then
    for dir in "$INPUT_DIR"/*; do
        # Extract the sample name from the directory
        sample_name=$(basename "$dir")
        fasta_input="$dir/assembly.fasta"
        output="$output_path"/"$sample_name"

        if [[ "$sample_name" == *"EC"* ]]; then
            species="Escherichia coli"
        elif [[ "$sample_name" == *"KP"* ]]; then
            species="Klebsiella"
        elif [[ "$sample_name" == *"AB"* ]]; then
            species="Other"
        elif [[ "$sample_name" == *"PA"* ]]; then
            species="Other"
        elif [[ "$sample_name" == *"EF"* ]]; then
            species="Enterococcus faecium"
        elif [[ "$sample_name" == *"SA"* ]]; then
            species="Staphylococcus aureus"
        else
            echo "Unknown species for $sample_name, skipping RF"
            continue
        fi

        if [[ "$species" == "Other" ]]; then
            python3 run_resfinder.py -ifa "$fasta_input" -o "$output" -s "$species" -acq -c -b "$BLAST_PATH" -db_res "$res_db_path"
        else
            python3 run_resfinder.py -ifa "$fasta_input" -o "$output" -s "$species" -acq -c -b "$BLAST_PATH" -db_res "$res_db_path" -db_point "$point_db_path"
        fi

        echo "RF done for $sample_name"
    done
elif [ "$LOOP_CHOICE" == "S" ]; then
    for file in "$INPUT_DIR"/*.fasta; do
        # Extract the sample name from the file name
        sample_name=$(basename "$file" .fasta)
    
        output="$OUTPUT_DIR"/"$sample_name"

        if [[ "$sample_name" == *"EC"* ]]; then
            species="Escherichia coli"
        elif [[ "$sample_name" == *"KP"* ]]; then
            species="Klebsiella"
        elif [[ "$sample_name" == *"AB"* ]]; then
            species="Other"
        elif [[ "$sample_name" == *"PA"* ]]; then
            species="Other"
        elif [[ "$sample_name" == *"EF"* ]]; then
            species="Enterococcus faecium"
        elif [[ "$sample_name" == *"SA"* ]]; then
            species="Staphylococcus aureus"
        else
            echo "Unknown species for $sample_name, skipping RF"
            continue
        fi
    
        if [[ "$species" == "Other" ]]; then
            python3 run_resfinder.py -ifa "$file" -o "$output" -s "$species" -acq -c -b "$BLAST_PATH" -db_res "$res_db_path"
        else
            python3 run_resfinder.py -ifa "$file" -o "$output" -s "$species" -acq -c -b "$BLAST_PATH" -db_res "$res_db_path" -db_point "$point_db_path"
        fi

        echo "RF done for $sample_name"
    done

else
    echo "Invalid loop choice. Please specify 'L' or 'S'."
    exit 1
fi

echo "ResFinder pipeline execution completed."
