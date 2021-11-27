#!/bin/bash

#SBATCH --job-name hello_world_mpi
#SBATCH --time 00:10:00
#SBATCH --ntasks-per-node 20
#SBATCH --nodes 10
#SBATCH --ntasks 200
#SBATCH --output out.txt

module load openmpi-3.0.1/gcc-9.2.0
mpiexec -np 200 python3 hello_world_mpi.py 15
