# oscar-install

For any students/researchers who need to use HNN-Core on Brown's Oscar supercomputing environment, this repository should have everything they need to get started.

# Step 0: Register for an Oscar account

First, go to this page on our lab's Notion to find out how to sign up for an Oscar account: <https://www.notion.so/jonescompneurolab/Oscar-Guide-651fd55a117a41fc998b7c9a62f302b2> .

# Step 1: Connect to Oscar

All the below commands should be run from the "command line" using Oscar, not on your local computer. The easiest way to connect is either through an SSH session ([Oscar instructions here](https://docs.ccv.brown.edu/oscar/connecting-to-oscar/ssh)) or going to [Oscar's "OpenOnDemand" portal here](https://ood.ccv.brown.edu/pun/sys/dashboard) and launching a "Desktop" session. If you do a Desktop session, you can click the "Terminal Emulator" program at the bottom of the screen to start a terminal; that's where you should enter the commands. See [this guide](https://docs.ccv.brown.edu/oscar/connecting-to-oscar/open-ondemand/desktop-app-vnc) for more details on using the "Desktop" app, including how to enable copying and pasting.

# Step 2: Setup your Github config on Oscar

Oscar prefers that you interact with Github through SSH authentication, which requires a little bit of setup.

First, follow the "Git Configuration" setup of <https://docs.ccv.brown.edu/oscar/managing-files/version-control#git-configuration> and run the following commands, **making sure to change them to use your Github account's email**. If you don't have a Github account, make one, and use the corresponding email here:

```
git config --global user.name "Jane Smith“
git config --global user.email jane@example.com
```

Next, create an SSH key using the instructions at <https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent?platform=linux> . Use your Github email. Continuing our example above, you can do this by the following command:

```
ssh-keygen -t ed25519 -C "jane@example.com"
```

Make sure you use a passphrase, and make sure to write it down. When you run future git commands that interact with Github (such as `git clone` or `git pull`), you will need to provide your passphrase.

# Step 3: Download this repository

Now that you've setup Github access from inside Oscar, you need to download the scripts in this repository. Run the following command, which will move to your "home" directory and create a folder named `oscar-install` there. If you want, you can download the repository anywhere, but it is recommended to put it in your home directory for reasons we'll see soon.

```
cd ~
git clone git@github.com:jonescompneurolab/oscar-install
```

Next, enter this new directory you've downloaded, by running the following command:

```
cd oscar-install
```

# Step 4: Create the `hnn-core-conda-env` Miniconda virtual environment

Let's use Miniconda (aka Anaconda) to create an environment with HNN-Core, all its features including MPI parallelism, and Jupyter notebooks/Lab. Run the following command, which will take a few minutes (make sure to `source` it, don't simply execute it):

```
source create-hnn-core-conda-env.sh
```

That's it! Now that you have created the environment, in the future, you only need to re-activate it. To re-activate the environment, run the following command:

```
source ~/oscar-install/activate-hnn-core-conda-env.sh
```

You can run that command from anywhere, and it will give you access to the environment in whatever command line you're using (SSH, Desktop app Terminal Emulator, etc.). Note that the above assumes you downloaded `oscar-install` into your home directory like in the previous step; if you downloaded it to a different location, then you need to update the path to the script accordingly.

To leave the environment, run `conda deactivate`, or simply close the window/SSH session you are using.

If you ever need to rebuild your environment, then you can delete the current one by activating the environment, running `conda deactivate`, then `conda env remove -n hnn-core-conda-env`, then starting this step over again.

# Step 5: Create the `hnn-core-conda-pfc-env` Miniconda virtual environment

Note that you ONLY need to do this step if Darcy explicitly told you to.

These commands do the same thing as above, except that they create an environment called `hnn-core-conda-pfc-env`, which includes an install of Darcy's custom version of HNN-Core using a branch called `PFC_new` from here: <https://github.com/darcywaller/hnn-core/tree/PFC_new>. Run the following to create the environment

```
source create-hnn-core-conda-pfc-env.sh
```

And run the following to re-activate it when you need to in the future.

```
source ~/oscar-install/activate-hnn-core-conda-env.sh
```

# Step 6: Using the environment(s)

This section is a work in progress.

**Warning**: From the Oscar [OpenOnDemand portal](https://ood.ccv.brown.edu/pun/sys/dashboard/), do NOT use the Desktop session setting for "6 Cores, 15GB Memory, 4 days". Other settings appear fine, but there is something wrong with that setting that prevents HNN-Core from using all the cores available.

### HNN-Core GUI

To use the the **HNN-Core GUI on Oscar** ([see example GUI tutorial here](https://dylansdaniels.github.io/website_redesign/content/05_erps/erps_in_gui.html)), the only current method is:

- Start an Oscar "Desktop" [OpenOnDemand session](https://ood.ccv.brown.edu/pun/sys/dashboard/) (anything except the "6 Cores" setting).
- Open the Terminal Emulator application like above.
- Re-activate your created environment from above.
- Run the command `hnn-gui`.
- The GUI should then open in the browser inside your Desktop session after a few seconds.
- If you are using the GUI, you can increase the "Cores" setting to `N-1` where `N` is the number of Cores you requested. This will greatly speed up your simulations.

Note that HNN-Core GUI only works in the `hnn-core-conda-env` environment, not the `hnn-core-conda-pfc-env` environment.

### Jupyter

There are many ways to use Jupyter notebooks, all of which require running a server. Oscar's documentation provides guidance on several [ways to run Jupyter here](https://docs.ccv.brown.edu/oscar/jupyter-notebooks/jupyter-notebooks-on-oscar-1), some of which are difficult.

The easiest way to run Jupyter from inside either of our environments is the following:

- Start an Oscar "Desktop" [OpenOnDemand session](https://ood.ccv.brown.edu/pun/sys/dashboard/) (anything except the "6 Cores" setting).
- Open the Terminal Emulator application like above.
- Re-activate your created environment from above.
- Run the command `jupyter lab`.
- The Jupyter Lab interface should then open in the browser inside your Desktop session after a few seconds. Get sciencing!
- If you need to stop the server, you can go to the Terminal Emulator window, then press "Control + c" twice.

If the latency (lag) of the Desktop app is too much for you, then you may get better results by changing the "Compression" and "Image Quality" sliders for the Desktop app, depending on your connection speed. If it is still too slow for your preference, then try using the "Using a Batch Job" or "In an Interactive Session" sections of [Oscar's Jupyter docs here](https://docs.ccv.brown.edu/oscar/jupyter-notebooks/jupyter-notebooks-on-oscar-1). However, you will have to modify the instructions with the appropriate lines from the `oscar-install/activate-<environment>.sh` file that you use above. Ask Austin for help if you want to set this up, it's not intuitive.

Unfortunately, the "Basic Jupyter Notebook with Anaconda" and "Jupyter Notebook for Python Environemnts" apps from [Oscar OpenOnDemand](https://ood.ccv.brown.edu/pun/sys/dashboard/) do *not* appear to work with our environments. This is currently being investigated.

# Testing

If you want to test that NEURON can talk to MPI successfully (which HNN-Core needs if you are using multiple CPU cores), run the following

```
source test-nrn-mpiexec.sh
```

Which should spit out several lines saying "Hello from proc" and then a number.

If you want to test that HNN-Core `MPIBackend` support works in your environment, first get an allocation with multiple cores, then execute this file also included in this repo:

```
./test-install.sh
```
