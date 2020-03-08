#!/bin/bash
echo " This script is to run quality control tool for high throughput sequence data using FastQC"
echo "      This script will read the fastq.gz file from trimmed/ directory" 
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


## FASTQC for READ1_paired
READ="../trimmed/${SRR}_1.paired.fastq.gz"
if [ ! -f $READ ]; then 
 echo " SRR file doesn't exist in $READ "
 break ;
else
 mkdir -p $SRR
 sbatch --time=00:30:00 --mem=16GB --cpus-per-task=16 --wrap="fastqc --threads 16 -o $SRR $READ"
fi

## FASTQC for READ2_paired
READ="../trimmed/${SRR}_2.paired.fastq.gz"
if [ ! -f $READ ]; then 
 echo " SRR file doesn't exist in $READ "
 break ;
else
 mkdir -p $SRR
 sbatch --time=00:30:00 --mem=16GB --cpus-per-task=16 --wrap="fastqc --threads 16 -o $SRR $READ"
fi


## FASTQC for READ1_unpaired
READ="../trimmed/${SRR}_1.unpaired.fastq.gz"
if [ ! -f $READ ]; then 
 echo " SRR file doesn't exist in $READ "
 break ;
else
 mkdir -p $SRR
 sbatch --time=00:30:00 --mem=16GB --cpus-per-task=16 --wrap="fastqc --threads 16 -o $SRR $READ"
fi


## FASTQC for READ2_unpaired
READ="../trimmed/${SRR}_2.unpaired.fastq.gz"
if [ ! -f $READ ]; then 
 echo " SRR file doesn't exist in $READ "
 break ;
else
 mkdir -p $SRR
 sbatch --time=00:30:00 --mem=16GB --cpus-per-task=16 --wrap="fastqc --threads 16 -o $SRR $READ"
fi


echo " quality control results will be generated in fastqc/$SRR directory"
echo "***********************************"
