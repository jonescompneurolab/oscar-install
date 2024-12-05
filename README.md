# oscar-install
Helpful guidance for installing and using HNN-Core on the OSCAR supercomputer

# Step 1: Download this repository

For any newer students joining the lab who want or need to use HNN-Core on the OSCAR supercomputing environment, this repository should have everything they need to get started. The first step is to download this 'repository'. The easiest way to download this (probably) is to, from a Terminal on Oscar, run 

```
git clone https://github.com/jonescompneurolab/oscar-install
```

This will create a folder name `oscar-install` in their current directory. That folder contains these files.

# Step 2: Create the `hnn-core` Python virtual environment

For the general (non-`PFC_new`) HNN-Core installation, there are two easy-to-use files in this directory:

1. `create-hnn-core-venv.sh`:
    - This is the only file needed to actually create the environment (called `hnn-core`), load the modules, and install the right packages.
    - To actually perform the installation, all you need to do is execute this file. If you have used the `git clone...` command above, then all you need to do is run the following two commands, and press `y` in response to the prompt that appears:

```
cd oscar-install
./create-hnn-core-venv.sh
```

2. `activate-hnn-core-venv-modules.sh`:
    - After you have successfully completed creation of the venv using the first script, you may optionally want to use this one when you want to re-enter the correct environment in the future. To use this script, all you have to do is run the following:

```
source activate-hnn-core-venv-modules.sh
```

Note that you need to `source` this script, NOT execute it. (Technically: If you execute it, it sets up the environment in a subshell, NOT your current shell). The creation script prints guidelines for symlinking this to your `$HOME/bin` folder for easier accessibility.

Note that if you want to customize where your venvs are installed, or the name of the venv, it is very obvious how to change that in the scripts. If you do so, and want to use the convenience script, make sure you update the locations and names there too!

# Step 3: Create the `hnn-core-pfc` Python virtual environment

These files do almost the exact same thing as above, except that they create an environment called `hnn-core-pfc` which is an install of Darcy's custom version of HNN-Core using a branch called `PFC_new` from here: https://github.com/darcywaller/hnn-core/tree/PFC_new

1. `create-hnn-core-pfc-venv.sh`
    - Install script like above. Run this by simply:
```
./create-hnn-core-pfc-venv.sh
```

2. `activate-hnn-core-pfc-venv-modules.sh`
    - Convenience script like above. Re-load your modules and venv by simply:
```
source activate-hnn-core-pfc-venv-modules.sh
```

# Testing

If you want to test `MPIBackend` support for your installed HNN-Core environment, first get an allocation with multiple cores, then execute this file also included in this repo:

```
./test-install.sh
```
