#!/bin/bash

#SBATCH --job-name hello_world_mpi
#SBATCH --time 00:10:00
#SBATCH --nodes 2
#SBATCH --output hello_world_mpi_py.txt
#SBATCH --ntasks 4

module load openmpi-3.0.1/gcc-9.2.0
mpiexec -np 4 python3 hello_world_mpi.py
