#!/bin/bash
# Last updated: December 2024

VENV_NAME=hnn-core
VENVS_LOCN=$HOME/venvs

echo $'\n--> This will create a Python virtual environment with HNN installed for you called:'
echo ""
echo "    '$VENV_NAME'"
echo ""
echo "    to be located at:"
echo ""
echo "    '$VENVS_LOCN'"
echo ""
echo "    If the above location does not exist, it will attempt to be created."
echo "    If you want to change either the name or location of this environment,
    you can exit this script, then edit the appropriate environment variables in
    this script, then re-run this script."
echo $'\n--> Proceed? Press the letter "y" to create the environment, or
    anything else to cancel. This will take approximately 5 minutes to run.'
read pie
if [[ $pie == y ]]; then
    # We are NOT using python3.11, instead using the default 3.9
    echo "--> Purging current modules..."
    module purge

    ##############################################################
    # Next, let's load our modules carefully!
    # # This version is updated from mid-2024 and does NOT install correctly!
    # module load hpcx-mpi/4.1.5rc2s-yflad4v
    # Instead, we want to use this version (courtesy of Darcy Diesburg)
    echo "--> Loading MPI module..."
    module load hpcx-mpi/4.1.5rc2-mts-ukpby4i

    echo "--> Moving to $VENVS_LOCN..."
    mkdir -p $VENVS_LOCN
    cd $VENVS_LOCN

    echo "--> Creating empty venv with the name $VENV_NAME ..."
    python -m venv $VENV_NAME

    echo "--> Entering $VENV_NAME ..."
    source $VENVS_LOCN/$VENV_NAME/bin/activate

    echo "--> Upgrading pip..."
    pip install --upgrade pip

    echo "--> Installing mpi4py..."
    pip install mpi4py

    echo "--> Installing the latest pre-release of HNN-Core with parallel support..."
    pip install --pre "hnn_core[parallel]"

    echo "--> Finally, installing other helpful packages..."
    pip install bycycle jupyter mne pyvista

    echo "--> DONE: Environment successfully created!"
    echo ""
    echo "--> This script has successfully created the environment. Everything
    below this line is simply information that you may find helpful."
    echo ""

    echo "--> If you want to re-activate this environment and its MPI modules,
    then you must type run the following commands in your Terminal (the order
    doesn't matter):"
    echo ""
    echo "    module load hpcx-mpi/4.1.5rc2-mts-ukpby4i"
    echo "    source $VENVS_LOCN/$VENV_NAME/bin/activate"
    echo ""

    echo "--> If you so desire, there is also a 'convenience script' included
    with these files that can enable easier loading of everything. If you are
    ever in a new Terminal or new session and want to load everything, you can
    'source' this file using the following command:"
    echo ""
    echo "    source activate-$VENV_NAME-venv-modules.sh"
    echo ""

    echo "--> Similarly, if you want this convenience-script to be accessible
    anywhere, you can make a symlink to it by running the following command in
    this Terminal:"
    echo ""
    echo "    ln -s "'$PWD'"/activate-$VENV_NAME-venv-modules.sh "'$HOME'"/bin"

    echo ""

    echo "--> To exit this environment and switch back to the system Python
    installation, all you have to do is run the following command. This is
    useful if aren't sure which environment you're in, or something weird is
    going on with your python environment:"
    echo ""
    echo "    deactivate"
    echo ""
else
    echo "--> Not creating environment. Exiting."
fi
