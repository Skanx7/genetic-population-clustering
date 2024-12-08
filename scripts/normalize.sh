#!/bin/bash

DATA_DIR="$(dirname "$0")/../data/1000G/"
PROCESSED_DIR="$(dirname "$0")/../data/processed_vcfs/"
mkdir -p "$PROCESSED_DIR"

for chr in {1..22}; do
    input_vcf="${DATA_DIR}ALL.chr${chr}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz"
    norm_vcf="${PROCESSED_DIR}chr${chr}_norm.vcf.gz"
    fixed_vcf="${PROCESSED_DIR}chr${chr}_fixed.vcf.gz"

    if [[ -f "$input_vcf" ]]; then
        echo "Normalizing chromosome $chr..."
        bcftools norm -m -any "$input_vcf" -Oz -o "$norm_vcf"
        bcftools annotate --set-id '%CHROM\_%POS\_%REF\_%ALT' "$norm_vcf" -Oz -o "$fixed_vcf"

        echo "Chromosome $chr processed successfully."
    else
        echo "File $input_vcf not found. Skipping chromosome $chr."
    fi
done

echo "Normalization and ID fixing complete!"
