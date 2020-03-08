#!/bin/bash
echo " This script is to download Tutorial data from the GEO accession GSE50760 "
echo " 	     Data downloaded from: https://www.ebi.ac.uk/ena/data/view/PRJNA218851"
echo "       Please provide run accession: SRR975xxx number "
echo "        Example: SRR975552 "
mkdir -p data
cd data
echo "***********************************"
echo " "
read  -p '  SRR FILE to Download and press Enter key:  ' SRR
sbatch --time=00:30:00 --wrap="wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR975/$SRR/${SRR}_1.fastq.gz" 
sbatch --time=00:30:00 --wrap="wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR975/$SRR/${SRR}_2.fastq.gz" 
echo " "
echo "Downloading ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR975/$SRR/${SRR}_1.fastq.gz"
echo "Downloading ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR975/$SRR/${SRR}_2.fastq.gz"
echo "***********************************"
