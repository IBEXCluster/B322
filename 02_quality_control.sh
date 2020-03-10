#!/bin/bash
echo " This script is to run quality control tool for high throughput sequence data using FastQC"
echo "      This script will read the fastq.gz file from data/ directory" 
echo "       Please provide run accession: SRR975xxx number "
echo "        Example: SRR975552 "

mkdir -p fastqc
cd fastqc

## READ the SRR file

echo "***********************************"
echo " "
read  -p '  SRR FILE to Download and press Enter key:  ' SRR

echo " "
module load fastqc/0.11.8


## Read1 FASTQC

READ1="../data/${SRR}_1.fastq.gz"
if [ ! -f $READ1 ]; then 
 echo " SRR file doesn't exist in $READ1 "
 break ;
else
 mkdir -p $SRR
 sbatch --time=00:30:00 --mem=16GB --cpus-per-task=16 --wrap="fastqc --threads 16 -o $SRR $READ1"
fi


## Read2 FASTQC

READ2="../data/${SRR}_2.fastq.gz"
if [ ! -f $READ2 ]; then
 echo " SRR file doesn't exist in $READ2 "
 break ;
else
 mkdir -p $SRR
 sbatch --time=00:30:00 -A ibex-cs --mem=16GB --cpus-per-task=16 --wrap="fastqc --threads 16 -o $SRR $READ2"
 echo " "
 echo " quality control results will be generated in fastqc/$SRR directory"
fi

echo "***********************************"
