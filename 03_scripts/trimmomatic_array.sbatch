#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=6
#SBATCH --time=0:04:00
#SBATCH --qos=normal
#SBATCH --partition=shas
#SBATCH --output=trimmomatic-%A-%a.out
#SBATCH --array=0-11
# this script will be invoked 12 times, 
# each with a different value assigned to 
# SLURM_ARRAY_TASK_ID 
# within the range 0-11 (inclusive).
echo "[$0] $SLURM_JOB_NAME $@" # log the command line
date # timestamp
source activate.bashrc
#
# Run a single trimmomatic job in an array setting
# Usage: 
# sbatch 03_scripts/trimmomatic.sbatch 
#
files=(SRR3567551_1.fastq SRR3567552_1.fastq SRR3567554_1.fastq SRR3567555_1.fastq SRR3567637_1.fastq SRR3567638_1.fastq SRR3567639_1.fastq SRR3567657_1.fastq SRR3567674_1.fastq SRR3567676_1.fastq SRR3567677_1.fastq SRR3567679_1.fastq)

# this time, the choice of file will be determined by the value of SLURM_ARRAY_ID in the range we set above
# we will use that value to dereference our files array.
infile=01_input/${files[$SLURM_ARRAY_TASK_ID]}
outdir=02_output/02_trimmomatic

in1=$infile
# make the mate pair filename by replacing _1 with _2
in2=${infile/_1.fastq/_2.fastq}

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
