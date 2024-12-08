#!/bin/bash

PLINK_DIR="$(dirname "$0")/../data/plink_results/"
BATCH_DIR="${PLINK_DIR}/batches/"
MERGED_DIR="${PLINK_DIR}/merged/"
FINAL_DIR="${PLINK_DIR}/final/"
mkdir -p "$BATCH_DIR" "$MERGED_DIR" "$FINAL_DIR"

# Step 1: Create and Merge Batches
# Define batches manually for flexibility (adjust as needed)
batches=(
    "1 2 3 4 5 6"     # Batch 1: Chromosomes 1–6
    "7 8 9 10 11 12"  # Batch 2: Chromosomes 7–12
    "13 14 15 16 17 18" # Batch 3: Chromosomes 13–18
    "19 20 21 22"     # Batch 4: Chromosomes 19–22
)

batch_num=1
for batch in "${batches[@]}"; do
    echo "Processing Batch $batch_num: $batch"

    # Create merge list for the batch
    merge_list="${BATCH_DIR}batch${batch_num}_list.txt"
    > "$merge_list"
    first_chr=""

    for chr in $batch; do
        if [[ -z "$first_chr" ]]; then
            # First chromosome is the base file
            first_chr="${PLINK_DIR}chr${chr}"
        else
            # Add remaining chromosomes to the merge list
            echo "${PLINK_DIR}chr${chr}" >> "$merge_list"
        fi
    done

    # Perform the merge for the batch
    plink --bfile "$first_chr" \
          --merge-list "$merge_list" \
          --make-bed \
          --memory 57000 \
          --out "${BATCH_DIR}/batch${batch_num}"

    echo "Batch $batch_num merged successfully."
    ((batch_num++))
done

# Step 2: Merge All Batches
# Create merge list for all batches
final_merge_list="${MERGED_DIR}final_merge_list.txt"
> "$final_merge_list"
for i in {2..4}; do
    echo "${BATCH_DIR}/batch${i}" >> "$final_merge_list"
done

# Merge all batches
plink --bfile "${BATCH_DIR}/batch1" \
      --merge-list "$final_merge_list" \
      --make-bed \
      --memory 57000 \
      --out "${FINAL_DIR}/merged_all"

echo "Final chromosome merging complete!"
