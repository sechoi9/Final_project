# Final_project
Final project repo for 4324BIOL Bioinformatics

Data for the project was found on NCBI SRA. Added to the collection named Final Project.

## Download the files using SRA toolkit
### codes used to download the files onto opuntia in working directory
1. module load sratoolkit/3.0.7
2. vdb-config --prefetch-to-cwd
3. prefetch SRR30633885
4. fasterq-dump SRR30633885 --split-files

## Install necessary programs
### Install trinity through singularity
1. singularity pull --dir /project/stuckert/sechoi2/final_project trinity.sif docker://trinityrnaseq/trinityrnaseq:latest
2. singularity run -B /project/stuckert/sechoi2/final_project trinity.sif

### Install trimmomatic
1. wget https://github.com/usadellab/Trimmomatic/files/5854859/Trimmomatic-0.39.zip
2. unzip Trimmomatic-0.39.zip
3. cd Trimmomatic-0.39/
4. #test:
java -jar /project/stuckert/sechoi2/Trimmomatic-0.39/trimmomatic-0.39.jar


## Prepare files
### Trim reads using trimmomatic
1. java -jar /project/antunes/saehee/final_project/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads 5 -baseout SRR30633886_TRIM.fastq SRR30633886_1.fastq SRR30633886_2.fastq LEADING:3 TRAILING:3 ILLUMINACLIP:/project/antunes/saehee/final_project/barcodes.fa:2:30:10:8:TRUE MINLEN:25
2. Continue for all samples of the transcriptome
