from mpi4py import MPI
import sys
import random
from decimal import *

comm = MPI.COMM_WORLD
run_time = float(sys.argv[1])
start_time = MPI.Wtime()

inside = 0
outside = 0

while MPI.Wtime() - start_time < run_time:
    for i in range(10000):
        x = random.uniform(-5.0, 5.0)
        y = random.uniform(-5.0, 5.0)
        if math.sqrt(x**2.0 + y**2.0) <= 5.0:
            inside += 1
        else:
            outside += 1

all_inside = comm.gather(inside, root=0)
all_outside = comm.gather(outside, root=0)

rank = comm.Get_rank()

if rank == 0:
    size = comm.Get_size()
    total = 0
    inside = 0
    for i in range(size):
        print(f"process {i} computed {all_outside[i] + all_inside[i]} samples")
        inside += all_inside[i]
        total += all_outside[i] + all_inside[i]
    getcontext().prec = 100
    print(f"Pi = {Decimal(inside) / Decimal(total)}")
