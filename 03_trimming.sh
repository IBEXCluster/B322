#!/bin/bash
echo " This script is to Trim the Fastq file using TRIMMOMATIC"
echo "      This script will read the fastq.gz file from data/ directory" 
echo "       Please provide run accession: SRR975xxx number "
echo "        Example: SRR975552 "

## READ the SRR file
mkdir -p trimmed
echo "***********************************"
echo " "
read  -p '  SRR FILE to Download and press Enter key:  ' SRR

echo " "
module load trimmomatic/0.38
cd trimmed

## Verify both READ1 and READ2 are available 
READ1="../data/${SRR}_1.fastq.gz"
READ2="../data/${SRR}_2.fastq.gz"
if [[ ! -f $READ1 && ! -f $READ2 ]]; then 
 echo " SRR file doesn't exist either $READ1 or $READ2 "
 break ;
else
## Execute Trimming on the Fastq files. 

 sbatch --time=01:00:00 --mem=16GB --cpus-per-task=16 --wrap="java -jar $TRIMMOMATIC_JAR PE -threads 16 -phred33 \
	$READ1 \
	$READ2 \
	${SRR}_1.paired.fastq.gz \
	${SRR}_1.unpaired.fastq.gz \
	${SRR}_2.paired.fastq.gz \
	${SRR}_2.unpaired.fastq.gz \
	LEADING:3 TRAILING:3 SLIDINGWINDOW:4:25 MINLEN:75"
fi

echo " Trimmed files will be generated in trimmed/ directory"
echo "***********************************"
