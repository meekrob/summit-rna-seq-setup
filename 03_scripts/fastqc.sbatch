#!/usr/bin/env bash
#SBATCH --nodes=1  # access with $SLURM_NNODES in the script
#SBATCH --ntasks=2  # access with $SLURM_NTASKS in the script
#SBATCH --time=0:10:00
#SBATCH --qos=testing # change to "normal" when done testing
#SBATCH --partition=shas-testing # remove "-testing" when done testing
#SBATCH --output=slurm-%j.out # %j is the assigned job number
# log the command line
echo "[$0] $SLURM_JOB_NAME $@" 
# set temp directories to the scratch space
export TMPDIR=$SLURM_SCRATCH
export TMP=$TMPDIR
date # timestamp

# set up your environment, PATH variable, modules
source activate.bashrc

# run the program here
fastq=$1 # pass the fastq file as the 1st argument
outdir=$2 # pass the output directory as the 2nd argument
# fastqc will crash with usage message if the above two are not set
fastqc -t $SLURM_NTASKS -d $TMP -o $outdir $fastq
