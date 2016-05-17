#!/bin/sh
#SBATCH --part=westmere
#SBATCH --reservation=energy
#SBATCH --ntasks=1
#SBATCH -t 04:00:00             # max runtime is 4 hours
#SBATCH -J  ipy_server    # name
#SBATCH -o log/ipy-%J.out

let ipnport=($UID-6025)%65274
echo ipnport=$ipnport

ipnip=$(hostname -i)
echo ipnip=$ipnip

module load python
ipython notebook --ip=$ipnip --port=$ipnport --no-browser

