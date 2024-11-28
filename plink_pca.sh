DATA_DIR="data/1000G/"
GENOTYPE_FILE="ALL.chr22.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz"

# Convert VCF file to PLINK binary format
plink --vcf ${DATA_DIR}${GENOTYPE_FILE} --make-bed --out ${DATA_DIR}chr22_plink

# Filter for biallelic SNPs with MAF > 0.05
plink --bfile ${DATA_DIR}chr22_plink --maf 0.05 --geno 0.05 --hwe 1e-6 --make-bed --out ${DATA_DIR}chr22_filtered

# LD pruning to reduce correlated SNPs
plink --bfile ${DATA_DIR}chr22_filtered --indep-pairwise 50 5 0.2 --out ${DATA_DIR}chr22_pruned

# Create a dataset with pruned variants
plink --bfile ${DATA_DIR}chr22_filtered --extract ${DATA_DIR}chr22_pruned.prune.in --make-bed --out ${DATA_DIR}chr22_final


# Perform PCA on the pruned dataset
plink --bfile ${DATA_DIR}chr22_final --pca --out ${DATA_DIR}chr22_pca