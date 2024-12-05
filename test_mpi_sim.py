#!/usr/bin/env python

from hnn_core import jones_2009_model, MPIBackend, simulate_dipole

net = jones_2009_model()

########################################################################
# from https://jonescompneurolab.github.io/hnn-core/stable/auto_examples/workflows/plot_simulate_alpha.html#sphx-glr-auto-examples-workflows-plot-simulate-alpha-py
location = 'proximal'
burst_std = 20
# GD mentioned these are too low, and don't produce any spikes
# weights_ampa_p = {'L2_pyramidal': 5.4e-5, 'L5_pyramidal': 5.4e-5}
weights_ampa_p = {'L2_pyramidal': 1.0, 'L5_pyramidal': 1.0}
syn_delays_p = {'L2_pyramidal': 0.1, 'L5_pyramidal': 1.}

net.add_bursty_drive(
    'alpha_prox', tstart=50., burst_rate=10, burst_std=burst_std, numspikes=2,
    spike_isi=10, n_drive_cells=10, location=location,
    weights_ampa=weights_ampa_p, synaptic_delays=syn_delays_p, event_seed=284)

with MPIBackend(n_procs=2, mpi_cmd='mpiexec'):
    dpl = simulate_dipole(net, tstop=20., n_trials=1)


