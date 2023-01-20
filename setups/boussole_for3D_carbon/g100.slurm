#!/bin/bash

#SBATCH --job-name=Boussole
#SBATCH -N 1 -n 1
#SBATCH --time=01:00:00
#SBATCH --mem=10gb
#SBATCH --account=OGS21_PRACE_P
###SBATCH --account=tra21_seamless
###SBATCH --account=IscrB_3DSBM
#SBATCH --partition=g100_usr_prod
##SBATCH --qos=g100_qos_dbg
##SBATCH --nodes=2


cd $SLURM_SUBMIT_DIR

####conda activate seamless-bb
export LD_LIBRARY_PATH=/g100/home/userexternal/ealvarez/.conda/envs/seamless-bb-r/lib:$LD_LIBRARY_PATH

date
./gotm.xx 
date
