# sparseHiC

Tools for chromosome translocation calling from low-coverage HiC data utilizing a diploid reference HiC map. Use with output files from cooler/cooltools; example code below. 


#pairtools dedup -o Sample_1_g1kv37.dedup.pairs Sample_1_g1kv37.pairs

#cooler cload pairs --chrom1 2 --pos1 3 --chrom2 4 --pos2 5  grch37.chrom.sizes.reduced.nochr:1000000 Sample_1_g1kv37.dedup.pairs Sample_1_g1kv37.cool

#for i in {1..22..1}; do my_variable=SX; my_var1=S; my_var1+=$i; cooler dump --table pixels --range X --range2 $i --header --matrix --join --one-based-ids --one-based-starts Sample_1_g1kv37.cool > $my_variable.$my_var1.out.Sample_1_g1kv37.balanced.cool.range.txt

#for i in {1..22..1}; do my_variable=S; my_variable+=$i; my_var1=SX; cooler dump --table pixels --range $i --range2 X --header --matrix --join --one-based-ids --one-based-starts Sample_1_g1kv37.cool > $my_variable.$my_var1.out.Sample_1_g1kv37.balanced.cool.range.txt

#cooltools compute-expected -t cis -o "Sample_1_g1kv37.cool_cis_exp.txt" Sample_1_g1kv37.cool

