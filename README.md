# oscar-install

For any newer students joining the lab who want or need to use HNN-Core on the OSCAR supercomputing environment, this repository should have everything they need to get started.

# Step 0: Register for an OSCAR account

First, go to this page on our lab's Notion to find out how to sign up for an OSCAR account: https://www.notion.so/jonescompneurolab/OSCAR-Guide-651fd55a117a41fc998b7c9a62f302b2 .

# Step 1: Setup your Github config on Oscar

OSCAR prefers that you interact with Github through SSH authentication, which requires a little bit of setup.

First, follow the "Git Configuration" setup of https://docs.ccv.brown.edu/oscar/managing-files/version-control#git-configuration and run the following commands, **making sure to use your Github account's email**. If you don't have a Github account, make one, and use the corresponding email here:

```
git config --global user.name "John Smith“
git config --global user.email john@example.com
```

Next, create an SSH key using the instructions at https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?platform=linux . Use your Github email. Continuing our example above, you can do this by the following command:

```
ssh-keygen -t ed25519 -C "john@example.com"
```

Make sure you use a passphrase, and make sure to write it down. When you run future git commands that interact with Github (such as `git clone` or `git pull`), you will need to provide your passphrase.

# Step 2: Download this repository

Next, login to OSCAR and, from OSCAR, download this 'repository'. The easiest way to download this is to, once you are inside an SSH session to Oscar (or, via a Desktop session using OpenOnDemand, open the program at the bottom that says "Terminal Emulator"), run the following command:

```
git clone git@github.com:jonescompneurolab/oscar-install
```

This will create a folder name `oscar-install` in their current directory. That folder contains these files.

# Step 3: Create the `hnn-core` Python virtual environment

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

# Step 4: Create the `hnn-core-pfc` Python virtual environment

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
