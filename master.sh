#!/bin/bash

# Define global input parameters
INPUT_DIR="$1"  # Directory containing input files
OUTPUT_DIR="$2"  # Base directory for pipeline output
THREADS="$3"     # Number of threads for processing
LOOP_CHOICE="$4" # Loop choice for conditional execution in scripts that support it

# Specific parameters for individual scripts
# Assuming PF.sh and RF.sh require additional parameters not specified in the master script call
PF_DB="$5"
BLAST_PATH="$6"
DB_PATH="$7" # Placeholder for any database path parameter required by PF.sh or RF.sh
res_db_path="$7"
point_db_path="$8"

# Run PF.sh (PlasmidFinder)
echo "Running PlasmidFinder..."
bash PF.sh "$INPUT_DIR" "$OUTPUT_DIR" "$THREADS" "$LOOP_CHOICE" "$PF_DB" "$BLAST_PATH"

# Run prokka.sh
echo "Running Prokka..."
bash prokka.sh "$INPUT_DIR" "$OUTPUT_DIR"

# Run RF.sh (ResFinder)
echo "Running ResFinder..."
bash RF.sh "$INPUT_DIR" "$OUTPUT_DIR" "$THREADS" "$LOOP_CHOICE" "$BLAST_PATH" "$res_db_path" "$point_db_path"

# Run RGI.sh
echo "Running RGI..."
bash RGI.sh "$INPUT_DIR" "$OUTPUT_DIR" "$THREADS" "$LOOP_CHOICE"

echo "Pipeline execution completed."
