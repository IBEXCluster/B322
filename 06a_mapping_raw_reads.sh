#!/bin/bash
echo " This script is to do mapper for RNA-Seq reads using Homo_sapiens GRCh38 reference"
echo "      This script will read the fastq.gz file from data/ directories" 
echo "       Please provide run accession: SRR975xxx number "
echo "        Example: SRR975552 "

mkdir -p mapped
cd mapped

## READ the SRR file

echo "***********************************"
echo " "
read  -p '  SRR FILE to Download and press Enter key:  ' SRR

echo " "
module load tophat2/2.1.1


## Verify both READ1 and READ2 are available - Mapping without trimming
READ1="../data/${SRR}_1.fastq.gz"
READ2="../data/${SRR}_2.fastq.gz"
if [[ ! -f $READ1 && ! -f $READ2 ]]; then 
 echo " SRR file doesn't exist either $READ1 or $READ2 "
 break ;
else
## Execute Trimming on the Fastq files. 

OUTPUT=${SRR}_RAW_FASTQ
ANNOTATION=/ibex/reference/KSL/hg38/Gene_annotation/Homo_sapiens.GRCh38.99.gtf
HG38=/ibex/reference/KSL/hg38/Gene_annotation/hg38

 sbatch --time=04:00:00 --mem=16GB --cpus-per-task=16 --wrap="tophat -G $ANNOTATION --num-threads 16 -o $OUTPUT $HG38 \
	$READ1 \
	$READ2 
 "
fi

echo " Tophat mapper will be generated the mapping file from mapped/$OUTPUT directory"
echo "***********************************"
