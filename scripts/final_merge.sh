
PLINK_DIR="$(dirname "$0")/../data/plink_results/"
BATCH_DIR="${PLINK_DIR}/batches/"
MERGED_DIR="${PLINK_DIR}/merged/"
FINAL_DIR="${PLINK_DIR}/final/"


final_merge_list="${MERGED_DIR}final_merge_list.txt"
> "$final_merge_list"
for i in {2..4}; do
    echo "${BATCH_DIR}/batch${i}" >> "$final_merge_list"
done

# Merge all batches
plink --bfile "${BATCH_DIR}/batch1" \
      --merge-list "$final_merge_list" \
      --make-bed \
      --memory 60000 \
      --out "${FINAL_DIR}/merged_all"

echo "Final chromosome merging complete!"
