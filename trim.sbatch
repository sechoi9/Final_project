#!/bin/bash

#SBATCH -t 1-00:01 # total requested time the job may run in D-HH:MM
#SBATCH --cpus-per-task=20 # requests 4 threads/cpus per task. You can also set ntasks, but by default it is 1
#SBATCH --mem=60Gb # specify the amount of memory to request for the job
#SBATCH --output=%x.%j.out # specify the output file name. You can specify it however you want, but this is a nice automatic way to specify output files. In this case %x = job name; %j = job id

#trim reads using trimmomatic
module load Java/21.0.2

java -jar /project/antunes/saehee/final_project/Trimmomatic-0.39/trimmomatic-0.39.jar PE -baseout SRR30633888_TRIM.fastq SRR30633888_1.fastq SRR30633888_2.fastq LEADING:3 TRAILING:3 ILLUMINACLIP:/project/antunes/saehee/final_project/barcodes.fa:2:30:10:8:TRUE MINLEN:25
