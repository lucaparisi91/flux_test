#!/usr/bin/bash 

flux resource list

echo "Start at $(date): N=${NNODES}"

# Submit a collection of jobs on each node in the SLURM allocation. The job will create a distinct job farm on each node.
for i in $(seq 1 ${NNODES}); do
    flux batch --nslots=${NCPUS_PER_NODE} --cores-per-slot=1 --nodes=1 --output=flux.out.${i}.log --error=flux.err.${i}.log ./flux_job_node.sh
done

echo "Finished submitting at $(date)"

# Show all jobs
flux jobs -a


# Wait until all jobs in the queue are completed
flux queue drain


echo "End at $(date)"
