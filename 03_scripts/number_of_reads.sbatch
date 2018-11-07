#!/usr/bin/env bash
#SBATCH --nodes=1  # access with $SLURM_NNODES in the script
#SBATCH --ntasks=1  # access with $SLURM_NTASKS in the script
#SBATCH --time=0:01:00
#SBATCH --qos=testing # change to "normal" when done testing
#SBATCH --partition=shas-testing # remove "-testing" when done testing
#SBATCH --output=numreads-%j.out

# 4 lines per read in FASTQ format
numreads=$(( $(wc -l $1) / 4 ))
echo "$1 has $numreads reads."
