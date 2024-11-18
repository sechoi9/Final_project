# Final_project
Final project repo for 4324BIOL Bioinformatics

Data for the project was found on NCBI SRA. Added to the collection named Final Project.

## Download the files using SRA toolkit
### codes used to download the files onto opuntia in working directory
  module load sratoolkit/3.0.7
  vdb-config --prefetch-to-cwd
  prefetch SRR30633885
  fasterq-dump SRR30633885 --split-files

