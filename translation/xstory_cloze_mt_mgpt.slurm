#!/bin/bash
#SBATCH --job-name=xstory_cloze_mt_mgpt
#SBATCH --cpus-per-task=1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=0
#SBATCH --mem=50GB
#SBATCH --gres=gpu:1
#SBATCH --output=.slurm/xstory_cloze_mt_mgpt.out
#SBATCH --error=.slurm/xstory_cloze_mt_mgpt.err

# activate virtual environment
source ../venv/bin/activate
export TRANSFORMERS_CACHE="/gaueko0/transformers_cache/"

# mgpt model names
mgpt_model_names=(
    "sberbank-ai/mGPT"
)

# run xstory_cloze_mt_clm.py for each model
for model_name in "${mgpt_model_names[@]}"
do
    srun python3 xstory_cloze_mt_clm.py $model_name
done