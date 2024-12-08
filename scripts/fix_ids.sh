#!/bin/bash

PLINK_DIR="$(dirname "$0")/../data/plink_results/"
mkdir -p "$PLINK_DIR"

# Loop through all chromosomes (1 to 22) and fix missing IDs
for chr in {1..22}; do
    plink \
        --bfile "${PLINK_DIR}chr${chr}" \
        --set-missing-var-ids "@:#:\$1:\$2" \
        --make-bed \
        --out "${PLINK_DIR}chr${chr}_fixed"
done
