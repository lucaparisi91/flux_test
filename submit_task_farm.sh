#!/bin/bash
#SBATCH --job-name=test_capability_job
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=128
#SBATCH --time=00:02:0
#SBATCH --partition=standard
#SBATCH --qos=short
#SBATCH --account=z19
#SBATCH --output=flux.log
#SBATCH --error=flux.log
#SBATCH --exclusive
#SBATCH --hint=nomultithread

export OMP_NUM_THREADS=1
export OMP_PLACES=cores
export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK

module use /mnt/lustre/a2fs-work4/work/y07/shared/archer2-lmod/others/dev
module load spack
spack load flux-core
spack load flux-sched

sed -ie "s:hosts =.*:hosts ='${SLURM_NODELIST}':g" resource.toml 
# Start a flux instance for the allocation and submit ./test once per SLURM task

srun -N ${SLURM_NNODES} -n ${SLURM_NNODES}  --mpi=pmi2  flux start ./flux_farm.sh 