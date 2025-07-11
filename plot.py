import pandas as pd
import matplotlib.pyplot as plt

# Read timings.txt as a dataframe
df = pd.read_csv('timings.txt', sep='|', comment='#')

# Clean up column names and strip whitespace
df.columns = [col.strip() for col in df.columns]
df = df.applymap(lambda x: x.strip() if isinstance(x, str) else x)

# Convert columns to numeric
df['N'] = pd.to_numeric(df['N'])
df['T_flux'] = pd.to_numeric(df['T_flux'])

# Plot N vs T_flux
plt.figure(figsize=(8, 5))
plt.plot(df['N'], df['T_flux'], marker='o', label='Flux Job Farm')
plt.plot(df['N'], df['T_slurm'], marker='o', label='Slurm Job Farm')

plt.xlabel('Number of Nodes (N)')
plt.ylabel('Time (seconds)')
plt.title('Job Farm Timing vs Number of Nodes')
plt.grid(True)
plt.legend()
plt.tight_layout()
plt.savefig('job_farm_timing_vs_nodes.png', dpi=300)
plt.show()
