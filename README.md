# High Performance Computing with NGSolve on the Coeus cluster at PSU
This repo contains information about how to get set up on the Coeus computing cluster and some simple examples of using MPI and PETSc on the cluster.

Contents:
- [installation instructions on Coeus cluster](#installing-ngsolve)
- [general notes](notes.md) about HPC and NGSolve I created for this resource
- [examples index](examples/README.md) with a list of examples included

## Installing NGSolve
- get your Research Computing accout from OIT
- ssh into one of the login nodes on the cluster
```bash
ssh <odin_id>@login1.coeus.rc.pdx.edu
```
- note: that you must be on the PSU network to ssh into the login node. You need to set up the PSU full tunnel VPN if you want to access computing resources from outside the network.
- run the install script to build and install NGSolve and its dependencies
```bash
tmux
wget https://raw.githubusercontent.com/aujxn/hpc_notes/main/install_ngsolve.sh
chmod +x install_ngsolve.sh
. install_ngsolve.sh
```
- hopefully this works I don't really know how to make robust shell scripts but it takes a long time
  - we do this inside tmux just in case you disconnect it won't stop building
  - to reattach to your tmux session, login to the cluster and run: `tmux attach -t 0`
- if everything worked you should be able to run `which netgen` and `which ngs` with no error. If these work then add some lines to `~/.bashrc` and `~/.profile` so everything is good to go next time you log in
   - Add the following to the end of your `~/.profile`. If it doesn't exist then create one.
   ```bash
   NGSOLVE="$HOME/ngsuite/ngsolve-install"
   OCC="$HOME/ngsuite/occ-install"
   export PATH="$NGSOLVE/bin:$OCC/bin:$PATH"
   export LD_LIBRARY_PATH=$NGSOLVE/lib:$OCC/lib:$LD_LIBRARY_PATH
   export PYTHONPATH=$NGSOLVE/lib64/python3.6/site-packages
   ```
   - Add the following to the end of you `~/.bashrc`. (one should exist that sources `/etc/bashrc`)
   ```bash
   module load openmpi-3.0.1/gcc-9.2.0
   module load Utils/lapack/3.8.0/gcc-8.2.0
   ```
