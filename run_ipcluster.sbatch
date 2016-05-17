#!/bin/sh
#SBATCH --part=westmere
#SBATCH --reservation=energy
#SBATCH --ntasks=60
#SBATCH -t 04:00:00             # max runtime is 4 hours
#SBATCH -J  ipcluster    # name
#SBATCH -o log/ipc-%J.out
rm -r ~/.ipython/profile_job*

module load python

profile=job_${SLURM_JOB_ID}

echo "Creating profile ${profile}"
ipython profile create ${profile}
sleep 1

echo "Launching controller"
ipcontroller --ip="*" --profile=${profile} &
sleep 10

echo "Launching engines"
srun ipengine --profile=${profile} --location=$(hostname) 
