#!/usr/bin/bash 

flux resource list
flux getattr resource.R

echo "Start at $(date)"

for i in $(seq 1 256); do
    flux batch --nslots=1 --cores-per-slot=1 --nodes=1 --output=flux.out.${i}.log --error=flux.err.${i}.log ./flux_job.sh
done
echo "Finished submitting at $(date)"

flux jobs -a

# Wait until all jobs in the queue are completed
flux queue drain
echo "End at $(date)"
