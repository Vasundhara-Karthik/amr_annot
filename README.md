# **amr_annot** - **Genome annotation and resistance element identification pipeline**

## **Overview**

This pipeline integrates PlasmidFinder, Prokka, ResFinder, and RGI, outputting data into designated directories for streamlined genomic analysis.

## **Installation**
Ensure dependencies for PlasmidFinder, Prokka, ResFinder, RGI are installed. Typically, this requires Conda environments or specific Python versions.Then, install the following third-party components.
- PlasmidFinder
- Prokka
- ResFinder
- CARD-RGI

## **Usage**

```sh ./master_script.sh <INPUT_DIR> <OUTPUT_DIR> <THREADS> <LOOP_CHOICE> <PF_DB> <BLAST_PATH> <res_db_path> <point_db_path>```

- INPUT_DIR: Path to input FASTA files.
- OUTPUT_DIR: Root directory for results.
- THREADS: Number of processing threads.
- LOOP_CHOICE: 'L' or 'S', L for Long-read assemblies; S for Short-read assemblies.
- PF_DB: Path to PlasmidFinder database.
- BLAST_PATH: Path to blast.
- res_db_path: Path to ResFinder database.
- point_db_path: Path to PointFinder database.

## **Output Directories**

1. output_dir/PF: PlasmidFinder results. 
2. output_dir/Prokka: Genome annotations from Prokka. 
3. output_dir/RF: ResFinder antibiotic resistance findings. 
4. output_dir/RGI: RGI resistome analyses. 
