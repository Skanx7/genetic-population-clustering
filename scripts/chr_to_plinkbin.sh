#!/bin/bash

PROCESSED_DIR="$(dirname "$0")/../data/processed_vcfs/"
PLINK_DIR="$(dirname "$0")/../data/plink_results/"
mkdir -p "$PLINK_DIR"

for chr in {1..22}; do
    fixed_vcf="${PROCESSED_DIR}chr${chr}_fixed.vcf.gz"
    output_prefix="${PLINK_DIR}chr${chr}"

    if [[ -f "$fixed_vcf" ]]; then
        echo "Converting chromosome $chr to PLINK format..."
        plink --vcf "$fixed_vcf" \
              --make-bed \
              --out "$output_prefix" \
              --vcf-idspace-to _ \
              --const-fid \
              --allow-extra-chr
    else
        echo "File $fixed_vcf not found. Skipping chromosome $chr."
    fi
done

echo "PLINK conversion complete!"
