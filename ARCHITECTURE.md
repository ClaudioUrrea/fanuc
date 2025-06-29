# Project Architecture

This document describes the folder structure and workflow for the Fanuc HRC simulation project.

```
fanuc/
├── LICENSE
├── LICENSE-data.txt
├── CITATION.cff / CITATION.bib
├── README.md
├── CITATION.bib
├── CONTRIBUTING.md
├── requirements.txt
├── environment.yml
├── install_dependencies.sh
├── data_dictionary.md
├── figure_captions.md
├── CHANGELOG.md
├── ARCHITECTURE.md
├── scripts/
│   ├── generate_synthetic_dataset_Fanuc.m
│   ├── generate_fanuc_sensitivity_results.m
│   └── Figure_8_Fanuc.m … Figure_12_Fanuc.m
├── data/
│   ├── raw/
│   │   ├── HRC_Simulation_Log_Episodes.txt
│   │   └── HRC_TaskLevel_Results_Fanuc.csv
│   └── processed/
│       ├── HRC_Simulation_Results_Fanuc.csv
│       ├── HRC_Simulation_Aggregated_Fanuc.csv
│       ├── Sensitivity_Results_Fanuc.csv
│       └── HRC_Synthetic_Dataset_Fanuc.parquet
└── figures/
    ├── Figure_8_Fatigue_Curves_Fanuc.png … Figure_12_Sensitivity_Fanuc.png
    └── source/
        ├── Figure_8_Fanuc.m
        └── … Figure_12_Fanuc.m
```

**Workflow**

1. **Clone** the repository:

   ```bash
   git clone https://github.com/ClaudioUrrea/hrc-simulation.git
   cd hrc-simulation/fanuc
   ```
2. **Install** dependencies:

   ```bash
   ./install_dependencies.sh
   ```
3. **Generate** synthetic data:

   ```matlab
   cd scripts
   run generate_synthetic_dataset_Fanuc.m
   ```
4. **Perform** sensitivity runs:

   ```matlab
   run generate_fanuc_sensitivity_results.m
   ```
5. **Produce** publication figures:

   ```matlab
   run Figure_8_Fanuc.m
   …
   run Figure_12_Fanuc.m
   ```
6. **Commit** any updates to scripts or data, and **tag** new releases in `CHANGELOG.md`.







