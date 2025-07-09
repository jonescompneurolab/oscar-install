# Make sure to `source <file>` this file, NOT execute it!

CONDA_ENV_NAME=hnn-core-conda-custom-source-env

module load hpcx-mpi/4.1.5rc2-mts-ukpby4i

# This loads miniconda
# Below is from top of https://docs.ccv.brown.edu/oscar/software/miniconda as of 2024-12-03:
module load miniconda3/23.11.0s
source /oscar/runtime/software/external/miniconda3/23.11.0/etc/profile.d/conda.sh

conda activate $CONDA_ENV_NAME

