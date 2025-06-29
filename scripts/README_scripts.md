# Scripts Overview

## generate_synthetic_dataset_Fanuc.m
- **Input:** none (uses hard-coded parameters)
- **Output:**  
  - `HRC_Simulation_Results_Fanuc.csv`  
  - `HRC_Synthetic_Dataset_Fanuc.parquet`  
- **Description:** Generates per-cycle synthetic HRC data.

## generate_fanuc_sensitivity_results.m
- **Input:** `HRC_Simulation_Results_Fanuc.csv`  
- **Output:** `Sensitivity_Results_Fanuc.csv`  
- **Description:** Varies fatigue rate and bid weights by ±10 % to produce sensitivity metrics.

## Figure_8_Fanuc.m … Figure_12_Fanuc.m
- **Input:** processed CSVs  
- **Output:** PNG figures in `/figures/`  
- **Description:** Each script reads the appropriate table, computes statistics or plots, and saves a high-resolution PNG.
