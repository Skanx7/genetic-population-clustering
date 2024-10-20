#!/bin/bash
DATA_DIR="../data/1000G/"
mkdir -p $DATA_DIR

# Download the VCF file
# Print the current working directory
wget -P $DATA_DIR ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz

# Download the VCF index file (TBI)
wget -P $DATA_DIR ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz.tbi

# Download the sample panel file
wget -P $DATA_DIR ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/integrated_call_samples_v3.20130502.ALL.panel


