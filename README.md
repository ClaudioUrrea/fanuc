<<<<<<< HEAD
# Fatigue-Aware Sub-Second Combinatorial Auctions for Dynamic Cycle Allocation in Human–Robot Collaborative Assembly

This repository contains all scripts, raw and processed data, and figures used in:
**“Fatigue-Aware Sub-Second Combinatorial Auctions for Dynamic Cycle Allocation in Human–Robot Collaboration Assembly”**, submitted to *Mathematics* (MDPI). The accompanying code and data are also available via FigShare (DOI: [https://doi.org/10.6084/m9.figshare.29431700](https://doi.org/10.6084/m9.figshare.29431700)).

## Structure

* `LICENSE`
* `LICENSE-data.txt`
* `CITATION.cff` / `CITATION.bib`
* `CONTRIBUTING.md`
* `requirements.txt` / `environment.yml`
* `install_dependencies.sh`
* `/scripts/`

  * `generate_synthetic_dataset_Fanuc.m`
  * `generate_fanuc_sensitivity_results.m`
  * `Figure_8_Fanuc.m` … `Figure_12_Fanuc.m`
  * `README_scripts.md`
* `/data/raw/`

  * `HRC_Simulation_Log_Episodes.txt`
  * `HRC_TaskLevel_Results_Fanuc.csv`
* `/data/processed/`

  * `HRC_Simulation_Results_Fanuc.csv`
  * `HRC_Simulation_Aggregated_Fanuc.csv`
  * `Sensitivity_Results_Fanuc.csv`
  * `HRC_Synthetic_Dataset_Fanuc.parquet`
* `/figures/`

  * `Figure_8_Fatigue_Curves_Fanuc.png` … `Figure_12_Sensitivity_Fanuc.png`
* `data_dictionary.md`
* `figure_captions.md`
* `CHANGELOG.md`
* `ARCHITECTURE.md`

## Licenses

* **Code** is licensed under [MIT License](LICENSE).
* **Data** and **figures** are licensed under [CC BY 4.0](LICENSE-data.txt).

## Workflow

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

=======
# fanuc
Code &amp; data for “Fatigue-Aware Sub-Second Combinatorial Auctions for Dy-namic Cycle Allocation in Human–Robot Collaborative Assembly”
>>>>>>> b25f48ffbc3356f0973fb47dbf5b86700c24449f
