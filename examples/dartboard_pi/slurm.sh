#!/bin/bash

#SBATCH --job-name pi
#SBATCH --partition short
#SBATCH --ntasks-per-node 20
#SBATCH --nodes 2
#SBATCH --ntasks 40
#SBATCH --output out.txt

module load openmpi-3.0.1/gcc-9.2.0
mpiexec -np 40 python3 pi.py 30
