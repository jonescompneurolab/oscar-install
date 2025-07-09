# Make sure to `source <file>` this file, NOT execute it!

module purge

CONDA_ENV_NAME=hnn-core-conda-custom-source-env

# Load MPI:
# This version is updated from mid-2024 and does NOT install correctly!
# module load hpcx-mpi/4.1.5rc2s-yflad4v
# Instead, we want to use this version (courtesy of Darcy Diesburg)
module load hpcx-mpi/4.1.5rc2-mts-ukpby4i

# Load miniconda:
# Below is from top of https://docs.ccv.brown.edu/oscar/software/miniconda as of 2024-12-03:
module load miniconda3/23.11.0s
source /oscar/runtime/software/external/miniconda3/23.11.0/etc/profile.d/conda.sh

# Move into our environment
conda activate $CONDA_ENV_NAME

git clone git@github.com:jtajchman/hnn_tms_direct hnn-core
cd hnn-core

# Finally, install HNN
pip install -e ".[gui,opt,parallel]"
