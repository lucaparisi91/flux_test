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

# Start a flux instance for the allocation and submit ./test once per SLURM task

export NNODES=${SLURM_NNODES}
export NCPUS_PER_NODE=${SLURM_CPUS_ON_NODE}
export JOBS_PER_CORE=2

echo "Start at $(date): N=${NNODES}"

# Start timer
start_time=$(date +%s)

srun -N ${SLURM_NNODES} -n ${SLURM_NNODES}  --mpi=pmi2  flux start ./flux_farm.sh


# End timer and print wall time
end_time=$(date +%s)
elapsed=$((end_time - start_time))
echo "Total wall time: ${elapsed} seconds"

# Print the Slurm job ID
echo "SLURM Job ID: $SLURM_JOB_ID"

echo "End at $(date)"