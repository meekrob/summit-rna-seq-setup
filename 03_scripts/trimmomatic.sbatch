#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH --time=0:05:00
#SBATCH --qos=normal
#SBATCH --partition=shas
#SBATCH --output=trimmomatic-%j.out
echo "[$0] $SLURM_JOB_NAME $@" # log the command line
date # timestamp
#
# Run a single trimmomatic job 
# Usage: 
# sbatch trimmomatic.sbatch file_1.fastq file_2.fastq outdir
#
in1=$1 # like 01_input/SRR1234567_1.fastq
in2=$2 # like 01_input/SRR1234567_2.fastq
outdir=${3:=.} # like 03_output/02_trimmomatic. Defaults to current directory

# make all the file output names, strip the input directory with 'basename'
out1paired=$(basename ${in1/.fastq/.trimmed.fastq})    # makes: SRR1234567_1.trimmed.fastq
out1unpaired=$(basename ${in1/.fastq/.unpaired.fastq}) # makes: SRR1234567_1.unpaired.fastq
out2paired=$(basename ${in2/.fastq/.trimmed.fastq})    # makes: SRR1234567_2.trimmed.fastq
out2unpaired=$(basename ${in2/.fastq/.unpaired.fastq}) # makes: SRR1234567_2.unpaired.fastq

# This large chunk of params comes from the website demo, but...
# notice the Trimmomatic-0.36/adapters/TruSeq3-PE.fa path given to ILLUMINACLIP
trim="ILLUMINACLIP:Trimmomatic-0.36/adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36"

# build the command
trimmomatic_command="java -jar Trimmomatic-0.36/trimmomatic-0.36.jar PE -threads $SLURM_NTASKS -phred33 $in1 $in2 $outdir/$out1paired $outdir/$out1unpaired $outdir/$out2paired $outdir/$out2unpaired $trim"
echo $trimmomatic_command
time eval $trimmomatic_command
