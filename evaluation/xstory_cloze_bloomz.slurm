#!/bin/bash
#SBATCH --job-name=xstory_cloze_bloomz
#SBATCH --cpus-per-task=1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=0
#SBATCH --mem=50GB
#SBATCH --gres=gpu:1
#SBATCH --output=.slurm/xstory_cloze_bloomz.out
#SBATCH --error=.slurm/xstory_cloze_bloomz.err

# activate virtual environment
source ../venv/bin/activate
export TRANSFORMERS_CACHE="/gaueko0/transformers_cache/"

# bloomz model names
model_names=(
    "bigscience/bloomz-560m"
    "bigscience/bloomz-1b1"
    "bigscience/bloomz-1b7"
    "bigscience/bloomz-3b"
    "bigscience/bloomz-7b1"
    "bigscience/bloomz-7b1-mt"
    "bigscience/bloomz-7b1-p3"
)

# dataset name
dataset_names=(
    "juletxara/xstory_cloze"
    "juletxara/xstory_cloze_mt_nllb-3B"
)

# run xstory_cloze.py for each dataset and model
for dataset_name in "${dataset_names[@]}"
do
    for model_name in "${model_names[@]}"
    do
        srun python3 xstory_cloze.py $model_name $dataset_name
    done
done
