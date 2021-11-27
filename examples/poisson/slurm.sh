#!/bin/bash

#SBATCH --job-name poisson
#SBATCH --partition short
#SBATCH --nodes 2
#SBATCH --ntasks 4
#SBATCH --output out.txt

module load openmpi-3.0.1/gcc-9.2.0
mpiexec -np 4 python3 poisson_mpi.py
