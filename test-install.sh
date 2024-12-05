#!/bin/bash

echo "NOTE: You MUST be running this on an allocation that has multiple cores, NOT on a login node!"
echo $'\n--> Proceed? Press the letter "y" to run the test, or anything else to cancel.'
read pie
if [[ $pie == y ]]; then
    python test_mpi_sim.py
    echo "--> Test completed successfully!"
else
    echo "--> Not running test. Exiting."
fi
