#!/usr/bin/env bash
#SBATCH --nodes=1  # access with $SLURM_NNODES in the script
#SBATCH --ntasks=1  # access with $SLURM_NTASKS in the script
#SBATCH --time=0:01:00
#SBATCH --qos=testing # change to "normal" when done testing
#SBATCH --partition=shas-testing # remove "-testing" when done testing
# log the command line
echo "[$0] $SLURM_JOB_NAME $@" 
# set temp directories to the scratch space
export TMPDIR=$SLURM_SCRATCH
export TMP=$TMPDIR
date # timestamp

# set up your environment, PATH variable, modules
source activate.bashrc

# run the program here
