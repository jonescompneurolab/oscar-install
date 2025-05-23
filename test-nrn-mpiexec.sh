
mpiexec -np 4 nrniv -mpi -python -c 'from neuron import h; from mpi4py import MPI; \
    print(f"Hello from proc {MPI.COMM_WORLD.Get_rank()}"); \
    h.quit()'
