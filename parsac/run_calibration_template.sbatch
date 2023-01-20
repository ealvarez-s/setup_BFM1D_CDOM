#!/bin/bash
#SBATCH --account=OGS21_PRACE_P
###SBATCH --account=tra21_seamless
###SBATCH --account=IscrB_3DSBM
#SBATCH --partition=g100_usr_prod
#SBATCH --nodes=2
#SBATCH --ntasks-per-node 1
#SBATCH --cpus-per-task 48
#SBATCH --time=24:00:00
#SBATCH --output=%j.out
#SBATCH --error=%j.err

conda activate seamless-bb-r
export PYTHONUNBUFFERED=TRUE
export LD_LIBRARY_PATH=/g100/home/userexternal/ealvarez/.conda/envs/seamless-bb-r/lib:$LD_LIBRARY_PATH

MODEL=BFM
SITE='BOUSSOLE'
WRKDIR=$CINECA_SCRATCH/${SITE}_CALIBRATION/
#WRKDIR=/g100_work/IscrC_MEDIVOT_0/TEST_CALIBRATION/ 
xml_file=${SITE}_calibration.xml
echo xmlfile $xml_file
rm -rf $WRKDIR/???????????????
rm -rf $WRKDIR/????????????????

# Generate secret for Parallel Python authentication between server and client
secret=`cat /dev/urandom | tr -cd 'a-f0-9' | head -c 32`

# Pick IP port for Parallel Python communication (IANA: use 49152 to 65535 for dynamic/private ports)
port=`python -c 'import random; print(random.randint(49152,65535))'`

# run the servers
echo Starting ppserver on $SLURM_JOB_NODELIST:$port
srun --output %j-%3t.out --error %j-%3t.err ppserver -w $SLURM_CPUS_PER_TASK -t 3600 -s $secret -p $port -r &

hostnames=`scontrol show hostnames $SLURM_JOB_NODELIST | sed -z 's/\n/:'"$port"',/g'`
echo Host names provided to parsac: $hostnames

# launch the parsac job
echo Starting parsac
parsac calibration run --ppservers $hostnames --ncpus 0 --secret=$secret --tempdir $WRKDIR --maxiter 100 $xml_file
#parsac calibration run -m fmin -r 86400 --tempdir $WRKDIR --maxiter 50 $xml_file
echo Done
