#!/bin/bash

# Define input and output directories and additional parameters
ASSEMBLY_DIR="$1"  # Directory containing assembly files
OUTPUT_DIR="$2"    # Base directory for pipeline output
THREADS="$3"       # Number of threads for processing
LOOP_CHOICE="$4"   # L for the first loop, S for the second loop
PF_DB="$5"        # Path to the PlasmidFinder database
BLAST_PATH="$6"   # Path to Blast


# Check if PlasmidFinder is installed
if ! command -v plasmidfinder.py &> /dev/null; then
    echo "PlasmidFinder is not installed. Please install it before continuing."
    exit 1
fi

# Directory setup
PLASMIDFINDER_OUTPUT_DIR="${OUTPUT_DIR}/PF"
mkdir -p "${PLASMIDFINDER_OUTPUT_DIR}"

echo "Starting PlasmidFinder analysis..."

if [ "$LOOP_CHOICE" == "L" ]; then
    # Iterate over assembly files and run PlasmidFinder for "L" choice
    for assembly in "${ASSEMBLY_DIR}"/*.fasta; do
        if [ -f "$assembly" ]; then
            assembly_name=$(basename "$assembly" .fasta)
            echo "Running PlasmidFinder for $assembly_name"
            
            # Output directory for this assembly
            pf_output="${PLASMIDFINDER_OUTPUT_DIR}/${assembly_name}"
            mkdir -p "$pf_output"
            
            # Run PlasmidFinder
            plasmidfinder.py -i "$assembly" -o "$pf_output" -x -p "$PF_DB" -mp "$BLAST_PATH"
            
            echo "PlasmidFinder analysis completed for $assembly_name"
            echo
        fi
    done
elif [ "$LOOP_CHOICE" == "S" ]; then
    # Iterate over the assemblies in the specified directory for "S" choice
    for unic in "${ASSEMBLY_DIR}"/*; do
        if [ -d "$unic" ]; then
            assembly_name=$(basename "$unic")
            echo "Running PlasmidFinder for $assembly_name"

            # Define the output directory for PlasmidFinder
            pf_output="${PLASMIDFINDER_OUTPUT_DIR}/${assembly_name}"
            mkdir -p "$pf_output"
        
            # Run PlasmidFinder on the current assembly
            plasmidfinder.py -i "${unic}/assembly.fasta" -o "$pf_output" -x -p "$PF_DB" -mp "$BLAST_PATH"
            
            echo "Plasmids found for $assembly_name"
            echo
        fi
    done
else
    echo "Invalid loop choice. Please specify 'L' for the first loop or 'S' for the second loop."
    exit 1
fi

echo "PlasmidFinder pipeline execution completed."

