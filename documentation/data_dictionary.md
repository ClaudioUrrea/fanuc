# Data Dictionary

## HRC_Simulation_Results_Fanuc.csv
- `Episode` (int): 1–1000 simulation run index.
- `Cycle` (int): 1–2500 auction cycle index per episode.
- `Fatigue` (double): fatigue level [0,1] at end of cycle.
- `Skill` (int): {0=novice,1=intermediate,2=expert}.
- `RobotTime` (double): simulated cycle execution time (s).
- `CollisionFlag` (bool): true if collision detected in this cycle.
- `Method` (string): “Auction” or “RuleBased”.
- `Action` (string): “Human” or “Robot”.

## HRC_Simulation_Aggregated_Fanuc.csv
- `Episode` (int)
- `Throughput` (double): active cycles·min⁻¹
- `Workload` (double): avg fatigue units·cycle⁻¹
- `Safety` (double): fraction of collision-free cycles

## Sensitivity_Results_Fanuc.csv
- `Parameter` (string): e.g. “FatigueRate”, “W1”, “AuctionFrequency”
- `Value` (double): parameter multiplier (0.9–1.1)
- `Throughput`, `Fatigue`, `Safety`: metric values.

## HRC_Synthetic_Dataset_Fanuc.parquet
Same schema as `HRC_Simulation_Results_Fanuc.csv`.

