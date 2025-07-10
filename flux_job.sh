#!/usr/bin/bash

echo "Start at $(date)"

flux run -N 1 -n 1 ./test 60

echo "End at $(date)"