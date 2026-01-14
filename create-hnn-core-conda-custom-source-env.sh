# Make sure to `source <file>` this file, NOT execute it!

module purge

CONDA_ENV_NAME=hnn-core-conda-custom-source-env

# Load MPI:
# This version is updated from mid-2024 and does NOT install correctly!
# module load hpcx-mpi/4.1.5rc2s-yflad4v
# Instead, we want to use this version (courtesy of Darcy Diesburg)
# module load hpcx-mpi/4.1.5rc2-mts-ukpby4i
# Changes after 2026-January update
module load hpcx-mpi/2.25.1s-le4f

# Load miniconda:
# Below is from top of https://docs.ccv.brown.edu/oscar/software/miniconda as of 2024-12-03:
# module load miniconda3/23.11.0s
# source /oscar/runtime/software/external/miniconda3/23.11.0/etc/profile.d/conda.sh
# After 2026-January update
module load miniforge3/25.3.0-3-a6hh
# there's no similarly named "conda.sh" file anymore, so maybe we no longer need a secondary script

# Create our environment
# conda create -y -q -n $CONDA_ENV_NAME python=3.11
# After 2026-January update
conda create -y -q -n $CONDA_ENV_NAME python=3.12

# Move into our environment
conda activate $CONDA_ENV_NAME

# Necessary step for using our own MPI libraries
# see https://github.com/mpi4py/mpi4py/issues/335#issuecomment-1486366039
rm -f $CONDA_PREFIX/compiler_compat/ld

# Install MPI Python compatilibity package we need, including building a custom wheel
pip install --no-cache-dir mpi4py
# Install some jupyter stuff too
pip install jupyterlab notebook

# THIS is where you need to customize the script so that it downloads your
# personal fork.
git clone git@github.com:YOUR_GITHUB_USERNAME/hnn-core hnn-core
cd hnn-core

# Finally, install HNN
pip install -e ".[gui,opt,parallel]"
