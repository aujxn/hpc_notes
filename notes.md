# High Performance Computing with NGSolve

## Types of hardware for HPC
- multiple CPU systems
- GPUs

## Working in the PSU [research computing environment](https://sites.google.com/pdx.edu/research-computing) (Coeus Cluster)
- installing stuff on the cluster is pain
   - I blame cmake
- Coeus Cluster consists of many 'nodes' (110 TFLOPs)
   - 2 login and 2 management nodes
   - 1 data transfer node
   - 2 nodes for data storage
   - 128 general compute nodes
   - 12 Intel Phi nodes
   - 2 large memory nodes
- each node is its own computing environment and has multiple cores
- nodes are divided into different partitions
   - short, one hour
   - medium, default partition, 4 days
   - long, 20 days
   - interactive, 2 days
   - himem, for the high memory nodes, 20 days
   - phi, for the intel Phi nodes, 20 days
- resources are obviously all shared in a multi-user environment
   - any work must be submitted to the [Slurm workload manager](https://slurm.schedmd.com/)
   - [OIT example of simple Slurm usage](https://sites.google.com/pdx.edu/research-computing/getting-started/coeus-hpc-cluster)
   - [Slurm Tutorials](https://slurm.schedmd.com/tutorials.html)
   - [Slurm Quickstart](https://slurm.schedmd.com/quickstart.html)

## Two primary techniques for utilizing multiple cores
- concurrency
   - run multiple different tasks concurrently
   - doesn't need multiple CPUs or cores
   - many paradigms for concurrent programming
      - async/await
      - coroutines
      - subroutines
      - threads and tasks
      - generators (semicoroutines)
      - event loops
      - iterators
      - lazy evaluation of infinite lists
      - many more
   - can often be managed by state machines or DAGs
- parallelism
   - many tasks or a single task is processed simultaneously
   - usually a single task is broken into smaller parts so it can be distributed to multiple CPUs/cores
   - most matrix operations are fundamentally parallel in nature

## Primary models/frameworks for concurrent and parallel computing
- shared memory model
   - many programming primitives available...
      - lowest level: mutexes, atomic condition variables, and semaphores
      - more advanced data structures can be built on top
         - ring buffers
         - readers-writer (RW) locks
         - read-copy-update (RCU) structures
      - important to consider the space-time tradeoff of any primitives you are using
   - this model is hard to use, especially when building complicated systems
   - many types of bugs to watch out for
      - data races
      - dead locks
   - on the compute cluster, shared memory is only possible *within* a node
- message passing model
   - again many programming primitives available
   - Message Passing Interface (MPI) standard offers many abstractions
      - ubiquitous among scientific computing environments
      - multiple open implementations of this standard exist
         - [Open MPI API reference](https://www.open-mpi.org/doc/current/)
         - [MPICH user guide](https://www.mpich.org/static/downloads/3.4.2/mpich-3.4.2-userguide.pdf)
         - [mpi4py python bindings docs](https://mpi4py.readthedocs.io/en/stable/)
         - [ipyparallel for ipython](https://ipyparallel.readthedocs.io/en/latest/reference/mpi.html)
            - note: if using ipython/jupyter incorrectly you will be running on the login node only
            - ipyparallel does have SLURM integration so you can jupyter on the cluster interactively
      - MPI primary concepts:
         - communicator
         - point to point communication
         - collective operations
         - generalized data types
- note Amdahl's law
   - maximum theoretical speedup is a linear function of:
      - what portion of the computation can be parallelized
      - number of CPUs available

## NGSolve philosophy on using MPI
- only gives access to basic MPI functionality natively
   - use mpi4py for more advanced tasks
- native functionality includes:
   - distributing meshes and finite element spaces
      - built in data structures to manage shared DOFs
   - distributing weak formulations and assemblies
   - distributed solvers and preconditioners
      - not all solvers included in NGSolve work with MPI
         - use PETSc

## Notable APIs, standards, libraries
- Basic Linear Algebra Subprograms (BLAS)
   - standard for basic vector and matrix operations
   - many implementations optimized for your environment
- Linear Algebra Package (LAPACK)
   - makes calls to underlying BLAS to do more sophisticated operations
- CUDA/OpenCL/OpenGL toolkits
   - APIs for interacting with GPU resources
   - many implementations again

## More libraries?... PETSc/TAO
- Portable, Extensible Toolkit for Scientific Computing [documentation](https://petsc.org/release/docs/) and Toolkit for Advanced Optimization
   - "suite of data structures and routines for the scalable (parallel) solution of scientific applications modeled by partial differential equations."
      - parallel vector and matrix construction and operations
      - primitives for indexing and ordering data
      - linear system solvers
         - direct solvers and factorizations
         - preconditioners
         - Krylov methods (20+)
      - nonlinear solvers
      - time series ODE solvers
      - optimization solvers
      - multigrid methods and tools
      - FEM tools
      - profiling tools
   - can integrate MPI and GPU toolkits simultaneously
