#!/bin/bash

# Slurm job options (job-name, compute nodes, job time)
#SBATCH --job-name=Example_MPI_Job
#SBATCH --time=03:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --cpus-per-task=1

#SBATCH --partition=serial
#SBATCH --qos=serial

# Propagate the cpus-per-task setting from script to srun commands
#    By default, Slurm does not propagate this setting from the sbatch
#    options to srun commands in the job script. If this is not done,
#    process/thread pinning may be incorrect leading to poor performance

export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK

module use /mnt/lustre/a2fs-work4/work/y07/shared/archer2-lmod/others/dev
module load spack
spack -ddd -vvv install -j 8 flux-sched%gcc

spack repo add repos
