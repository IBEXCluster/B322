#!/bin/bash
echo " This script is to provide Aggregate results from multiple FastQC files"
echo " This script will read the FastQC.html files from fastqc/ directory"
echo "       Please provide run accession: SRR975xxx number "
echo "        Example: SRR975552 "
mkdir -p multiqc
cd multiqc
echo "***********************************"
echo " "
read  -p '  SRR FILE to Download and press Enter key:  ' SRR

## Verify more than 1 fastqc.html 
READ1="../fastqc/${SRR}/${SRR}_1_fastqc.html"
READ2="../fastqc/${SRR}/${SRR}_2_fastqc.html"

if [[ ! -f $READ1 && ! -f $READ2 ]]; then 
  echo " More than 1 FastQC.html files doesn't exist ... either $READ1 or $READ2 "
  break ;

else ## Execute MultiQC file in $SRR directory
  mkdir -p ${SRR}
  module load multiqc/1.6/anaconda2env
  sbatch --time=00:30:00 --wrap="multiqc ../fastqc/${SRR} -o $SRR"
  echo ""
  echo " Tophat mapper will be generated the mapping file from multiqc/${SRR} directory"

fi


echo "***********************************"
