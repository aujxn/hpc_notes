# High Performance Computing with NGSolve on the Coeus cluster at PSU
This repo contains information about how to get set up on the Coeus computing cluster and some simple examples of using MPI and PETSc on the cluster.

## Getting Started / Installing NGSolve
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
- if everything worked you should be able to run `which netgen` and `which ngs` with no error

## MPI examples
TODO

## PETSc examples
TODO
