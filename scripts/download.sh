#!/bin/bash

# Define the data directory relative to the script location
DATA_DIR="$(dirname "$0")/../data/1000G/"
mkdir -p "$DATA_DIR"

# Base URL for the 1000 Genomes Project
BASE_URL="ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502"

# Loop through chromosomes 1 to 22
for CHR in {1..22}; do
    echo "Downloading chromosome $CHR data..."

    # Download the VCF file
    wget -P $DATA_DIR "$BASE_URL/ALL.chr${CHR}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz"

    # Download the corresponding index file (TBI)
    wget -P $DATA_DIR "$BASE_URL/ALL.chr${CHR}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi"
done

echo "Download completed for chromosomes 1 to 22."

wget -P $DATA_DIR ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/integrated_call_samples_v3.20130502.ALL.panel
echo "Download completed for sample panel."