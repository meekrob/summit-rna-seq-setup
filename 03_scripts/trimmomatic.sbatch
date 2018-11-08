#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --time=0:02:00
#SBATCH --qos=testing
#SBATCH --partition=shas-testing
#SBATCH --output=trimmomatic-%j.out
echo "[$0] $SLURM_JOB_NAME $@" # log the command line
date # timestamp
source activate.bashrc
#
# Run a single trimmomatic job 
# Usage: 
# sbatch 03_scripts/trimmomatic.sbatch file_1.fastq 
#
infile=$1 # like 01_input/SRR1234567_1.fastq
outdir=02_output/02_trimmomatic

in1=$infile
# make the mate pair filename by replacing _1 with _2
in2=${infile/_1.fastq/_2.fastq}

# strip the input directory with 'basename'
basename1=$(basename $in1)
basename2=$(basename $in2)
# make all the file output names
out1paired=${basename1/.fastq/.trimmed.fastq}    # makes: SRR1234567_1.trimmed.fastq
out1unpaired=${basename1/.fastq/.unpaired.fastq} # makes: SRR1234567_1.unpaired.fastq
out2paired=${basename2/.fastq/.trimmed.fastq}    # makes: SRR1234567_2.trimmed.fastq
out2unpaired=${basename2/.fastq/.unpaired.fastq} # makes: SRR1234567_2.unpaired.fastq

# This large chunk of params comes from the website demo, but...
# notice the Trimmomatic-0.36/adapters/TruSeq3-PE.fa path given to ILLUMINACLIP
trim="ILLUMINACLIP:Trimmomatic-0.36/adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36"

# build the command
trimmomatic_command="java -jar Trimmomatic-0.36/trimmomatic-0.36.jar PE -threads $SLURM_NTASKS -phred33 $in1 $in2 $outdir/$out1paired $outdir/$out1unpaired $outdir/$out2paired $outdir/$out2unpaired $trim"
echo $trimmomatic_command
time eval $trimmomatic_command
