#!/bin/bash
DATA_DIR="$(dirname "$0")/../data/1000G/"
PLINK_DIR="$(dirname "$0")/../data/plink_results/"

mkdir -p "$PLINK_DIR"

# Loop over chromosomes 1 to 22
for chr in {1..22}
do
    echo "Processing chromosome $chr..."

    # Define input and output filenames
    input_vcf="${DATA_DIR}ALL.chr${chr}.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz"
    output_prefix="${PLINK_DIR}chr${chr}"

    # Check if the VCF file exists
    if [[ -f "$input_vcf" ]]; then
        # Convert VCF to PLINK binary format
        plink --vcf "$input_vcf" --make-bed --out "$output_prefix"
    else
        echo "File $input_vcf not found. Skipping chromosome $chr."
    fi
done

echo "Conversion complete!"
