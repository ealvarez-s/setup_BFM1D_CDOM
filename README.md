# setup_BFM1D_CDOM
Setup to run GOTM-FABM-BFM at BOUSSOLE and ParSAC configuration files to run optimization of parameters

setups/boussole_for3D_carbon/

Working directory to run GOTM-FABM-BFM (executable=gotm) at the BOUSSOLE site.
It contains the gotm.yaml file that configures the simulation start and end time, depth discretization (grid), forcing and initialization files, and output desired.
It contains the fabm.yaml file that describes at runtime the structure of the BFM, and gives values to parameter and state variables initialization.
It includes atmospheric forcing (GOTM_OASIM, meteo, precip), and T/S (temp_dyfamed, salt_dyfamed) and BGC variables (N1p,N3n,N5s,O2o,O3c,O3h,TAlk,TCO2) initialization and restoring files. 


observations/

Observations at BOUSSOLE site in GOTM-profile (real date and climatologies) and GOTM-timeseries (real date satellite) formats.


parsac/

Files (.xml) to configure the optimization experiment done in ParSAC for (Álvarez et al. 2023), and example job script (slurm) to launch the calibration.

https://doi.org/10.5281/zenodo.10067424
