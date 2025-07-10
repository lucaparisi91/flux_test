#!/usr/bin/bash
# Starts a job farm of serial processes using Flux on a single node

echo "Start at $(date)"

flux resource list

echo "Hostname: $(hostname) "
LOG_DIR=logs/$(hostname) 
mkdir -p $LOG_DIR

for i in $(seq 1 ${JOBS_PER_CORE}); do
    flux submit --wait -n1 --output="$LOG_DIR/{{id}}.out.log" --error="$LOG_DIR/{{id}}.err.log" --cc=1-${NCPUS_PER_NODE} ./spin 30
done
flux jobs -a

echo "End at $(date)"