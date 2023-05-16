#!/bin/bash
#SBATCH --job-name=save_power
#SBATCH --partition=super
#SBATCH --nodes=4
#SBATCH --ntasks=100
#SBATCH --time=4-0:00:00
#SBATCH --output=save_power.%j.out
#SBATCH --error=save_power.%j.err


# load module and run
module load matlab/2019b
# path to your matlab wrapper script
srun sh /project/TIBIR/Lega_lab/shared/lega_ansir/LH_code/basic_scripts/matlabWrapper_save_power.sh
