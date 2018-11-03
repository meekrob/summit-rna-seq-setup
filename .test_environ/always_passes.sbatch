#!/usr/bin/env bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=0:01:00
#SBATCH --qos=testing
#SBATCH --output=summit_env.txt

env
