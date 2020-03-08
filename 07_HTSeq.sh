#!/bin/bash
echo " This script is to Analysing high-throughput sequencing data"
echo " HTSeq software and Homo_sapiens.GRCh38.99.gtf file used as a ANNOTATION"
echo "      This script will read the file from mapped/ directories" 
echo "       Please provide run accession: SRR975xxx number "
echo "        Example: SRR975552 "

mkdir -p analysis
cd analysis

## READ the SRR file

echo "***********************************"
echo " "
read  -p '  SRR FILE to Download and press Enter key:  ' SRR

echo " "

RAW_HITS="../mapped/${SRR}_RAW_FASTQ/accepted_hits.bam"
TRIMMED_HITS="../mapped/${SRR}_TRIMMED_FASTQ/accepted_hits.bam"


## Analysing high-throughput from RAW Mapped file 

if [ ! -f ${RAW_HITS} ]; then 
 echo " ${RAW_HITS} file doesn't exist "
 break ;
else ## Execute Trimming on the Fastq files. 
 module load htseq/0.11.1
 echo "Analysing high-throughput sequencing data from RAW mapping read file"
 ANNOTATION=/ibex/reference/KSL/hg38/Gene_annotation/Homo_sapiens.GRCh38.99.gtf
 sbatch --time=04:00:00 --mem=16GB --wrap="htseq-count -f bam -s yes -i gene_id \
	${RAW_HITS} \
	$ANNOTATION \
	> ${SRR}_RawMapped_Genes_count.txt"
echo " $SRR_RawMapped_Genes_count.txt will be generated at analysis/ directory"
fi


## Analysing high-throughput from Trimmed Mapped file 
if [ ! -f ${TRIMMED_HITS} ]; then                 
 echo " ${TRIMMED_HITS} file doesn't exist "
 break ;
else ## Execute Trimming on the Fastq files. 
 module load htseq/0.11.1
 echo "Analysing high-throughput sequencing data from TRIMMED mapping read file"
 ANNOTATION=/ibex/reference/KSL/hg38/Gene_annotation/Homo_sapiens.GRCh38.99.gtf
 sbatch --time=04:00:00 --mem=16GB --wrap="htseq-count -f bam -s yes -i gene_id \
        ${TRIMMED_HITS} \
        $ANNOTATION \
        > ${SRR}_TrimmedMapped_Genes_count.txt"
echo " $SRR_TrimmedMapped_Genes_count.txt will be generated at analysis/ directory"
fi

echo "***********************************"
