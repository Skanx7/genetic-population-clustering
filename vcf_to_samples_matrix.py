from pysam import VariantFile
import numpy as np
from sklearn import decomposition
import pandas as pd


vcf_filename = "data/1000G/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5b.20130502.genotypes.vcf.gz"
panel_filename = "data/1000G/integrated_call_samples_v3.20130502.ALL.panel"



genotypes = []
samples = []
variant_ids = []
with VariantFile(vcf_filename) as vcf_reader:
    counter = 0
    for record in vcf_reader:
        counter += 1
        if counter % 100 == 0:
            alleles = [record.samples[x].allele_indices for x in record.samples]
            samples = [sample for sample in record.samples]
            genotypes.append(alleles)
            variant_ids.append(record.id)
        if counter % 4943 == 0:
            print(counter)
            print(f'{round(100 * counter / 494328)}%')
        # if counter >= 10000:
        #     break

with open(panel_filename) as panel_file:
    labels = {}  # {sample_id: population_code}
    for line in panel_file:
        line = line.strip().split('\t')
        labels[line[0]] = line[1]


print(variant_ids)
genotypes = np.array(genotypes)
print(genotypes.shape)

matrix = np.count_nonzero(genotypes, axis=2)

matrix = matrix.T
print(matrix.shape)

pca = decomposition.PCA(n_components=2)
pca.fit(matrix)
print(pca.singular_values_)
to_plot = pca.transform(matrix)
print(to_plot.shape)

df = pd.DataFrame(matrix, columns=variant_ids, index=samples)
df['samples pop'] = df.index.map(labels)
df.to_csv("matrix.csv")

