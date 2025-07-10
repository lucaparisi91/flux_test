#!/bin/bash
#SBATCH --job-name=test_capability_job
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=128
#SBATCH --cpus-per-task=1
#SBATCH --time=00:02:0
#SBATCH --partition=standard
#SBATCH --qos=short
#SBATCH --account=z19
#SBATCH --output=slurm.log
#SBATCH --error=slurm.log
#SBATCH --exclusive
#SBATCH --hint=nomultithread

export OMP_NUM_THREADS=1
export OMP_PLACES=cores
export SRUN_CPUS_PER_TASK=$SLURM_CPUS_PER_TASK

export NNODES=${SLURM_NNODES}
export NCPUS_PER_NODE=${SLURM_CPUS_ON_NODE}
export JOBS_PER_CORE=2

echo "Start at $(date): N=${NNODES}"
mkdir -p slurm-logs
# Submit a collection of jobs on each node in the SLURM allocation. The job will create a distinct job farm on each node.

for n in $(seq 1 ${NNODES}); do
    for t in $(seq 1 ${NCPUS_PER_NODE}); do
        for it in $(seq 1 ${JOBS_PER_CORE}); do
            srun -N 1 -n 1 --cpus-per-task=1 ./spin 30 > slurm-logs/job.${n}.out.${t}.${it}log &
        done
    done
done

echo "Finished submitting at $(date)"

# Wait for all background srun jobs to finish
wait
echo "End at $(date)"