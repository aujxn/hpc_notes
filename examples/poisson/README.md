# Parallel Poisson
This example shows how to distribute a mesh and solve a finite element system in parallel using NGSolve. The solution on each process is serialized in parallel using pickle and the solution can be visualized using the `draw_solution` jupyter notebook.

To use a jupyter notebook on the cluster you need to port forward your ssh session. This can be done by logging in with:
```
ssh -L 8888:127.0.0.1:8888 <odin_id>@login1.coeus.rc.pdx.edu
```
