# Test and benchmark flux on Archer2

## Testing

You can build flux using 

```bash
sbatch submit_build.sh
```

To test the task farm compile the spin executable

```bash
CC spin.cpp -O spin
```

To run the task farm

```bash
sbatch submit_task_flux_farm.sh
```