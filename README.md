# Final_project
Final project repo for 4324BIOL Bioinformatics

Data for the project was found on NCBI SRA. Added to the collection named Final Project.
https://www.ncbi.nlm.nih.gov/sites/myncbi/sae hee.choi.1/collections/64607176/public/

Log of methods tried and done

## Download files using SRA toolkit
### codes used to download the files onto opuntia in working directory
1. module load sratoolkit/3.0.7
2. vdb-config --prefetch-to-cwd
3. prefetch SRR30633885
4. fasterq-dump SRR30633885 --split-files

## Install necessary programs
### Install trinity through singularity (for opuntia cluster)
1. singularity pull --dir /project/stuckert/sechoi2/final_project trinity.sif docker://trinityrnaseq/trinityrnaseq:latest
2. singularity run -B /project/stuckert/sechoi2/final_project trinity.sif

### *** ran into some issues with trinity (no storage space on opuntia cluster)
Decided to run using my local machine. Needed to reinstall singularity, and trinity to run transcriptome assembly

### Installed Trinity locally using command line
1. Installed go
2. Installed singularity
3. Installed Trinity

### Install trimmomatic (tried on opuntia)
1. wget https://github.com/usadellab/Trimmomatic/files/5854859/Trimmomatic-0.39.zip
2. unzip Trimmomatic-0.39.zip
3. cd Trimmomatic-0.39/
4. #test:
java -jar /project/stuckert/sechoi2/Trimmomatic-0.39/trimmomatic-0.39.jar


## Prepare files
### Trim reads using trimmomatic (was able to do this on carya cluster)
1. java -jar /project/antunes/saehee/final_project/Trimmomatic-0.39/trimmomatic-0.39.jar PE -threads 5 -baseout SRR30633886_TRIM.fastq SRR30633886_1.fastq SRR30633886_2.fastq LEADING:3 TRAILING:3 ILLUMINACLIP:/project/antunes/saehee/final_project/barcodes.fa:2:30:10:8:TRUE MINLEN:25
2. Continue for all samples of the transcriptome
3. For some files, this took too long to run successfully using the compute node so I used the trim.sbatch script and submitted it as a job on the carya cluster.

### Run FastQC on samples
1. Installed fastQC locally using: sudo apt-get fastqc
2. ran code in primary directory: fastqc -o PM_fastqc_output_dir *1P.fastq *2P.fastq
3. ran code in metastasis directory: fastqc -o MT_fastqc_output_dir *1P.fastq *2P.fastq
4. Output saved in repo in PM_fastqc_output_dir and MT_fastqc_output_dir

## Run Transcriptome Assembly
### Used codes to try in carya cluster (did not have permissions)
     1. singularity run -B /project/antunes/saehee/final_project/primary /home/sechoi2/final_project/trinity.sif
Trinity --SS_lib_type RF --no_version_check --seqType fq --output trinity/ --max_memory 60G --left /project/antunes/saehee/final_project/primary/SRR30633886_TRIM_1P.fastq,/project/antunes/saehee/final_project/primary/SRR30633887_TRIM_1P.fastq,/project/antunes/saehee/final_project/primary/SRR30633889_TRIM_1P.fastq  --right /project/antunes/saehee/final_project/primary/SRR30633886_TRIM_2P.fastq,/project/antunes/saehee/final_project/primary/SRR30633887_TRIM_2P.fastq,/project/antunes/saehee/final_project/primary/SRR30633889_TRIM_2P.fastq  --CPU 20 --inchworm_cpu 20 --full_cleanup --no_bowtie

### Used codes to try locally (ran out of disk space)
1. Changed code to run with local paths
2. Need to change file name in the script for each one before running
3. Running 2 transcriptome assemblies one for primary and one for metastasis
4. Tried running one with 3 samples per transcriptome, but was unsuccessful due to lack of storage. (file over 200GB for 1 unfinished assembly)
   
### Used codes to re-run with 1 sample per transcriptome locally (error- no  output files generated)
### Re-ran again with 2 samples per transcriptome assembly on cluster when space was added! (ran out of compute time)
     1. singularity run -B /project/stuckert/sechoi2 trinity.sif
     2. $TRINITY_HOME/util/trinity.sif --seqType fq --left "/project/stuckert/sechoi2/final_project/metastasis/mt_SRR30633885_TRIM_1P.fastq,/project/stuckert/sechoi2/final_project/metastasis/mt_SRR30633888_TRIM_1P.fastq,/project/stuckert/sechoi2/final_project/primary/pm_SRR30633887_TRIM_1P.fastq,/project/stuckert/sechoi2/final_project/primary/pm_SRR30633889_TRIM_1P.fastq" \
   --right "/project/stuckert/sechoi2/final_project/metastasis/mt_SRR30633885_TRIM_2P.fastq,/project/stuckert/sechoi2/final_project/metastasis/mt_SRR30633888_TRIM_2P.fastq,/project/stuckert/sechoi2/final_project/primary/pm_SRR30633887_TRIM_2P.fastq,/project/stuckert/sechoi2/final_project/primary/pm_SRR30633889_TRIM_2P.fastq" \
   --CPU 20 --max_memory 60G --trinity_complete --full_cleanup
### Tried re-running with 1 sample per transcriptome locally 
#### WORKED (used codes in TRINITY_locally file in repo)

### Used codes in TRINITY_locally to generate counts and a matrix

### Used codes script merge_matrix.sh to merge the primary and metastasis so they can be compared to each other


