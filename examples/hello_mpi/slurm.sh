#!/bin/bash

#SBATCH --job-name hello_world_mpi
#SBATCH --partition short
#SBATCH --nodes 2
#SBATCH --output out.txt 
#SBATCH --ntasks 4

module load openmpi-3.0.1/gcc-9.2.0
mpiexec -np 4 python3 hello_world_mpi.py
