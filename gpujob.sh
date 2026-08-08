#!/bin/bash
#SBATCH --job-name=neuro_tune_job
#SBATCH --output=nt_output_%j.log
#SBATCH --error=nt_error_%j.log
#SBATCH --partition=gpu
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=16

cd $SLURM_SUBMIT_DIR
module load anaconda3-2024
eval "$(conda shell.bash hook)"
conda activate my_env

# Install nbconvert to run notebooks
pip install nbconvert -q

echo "====== Starting Job on: $(hostname) ======"
nvidia-smi

# Step 1: Preprocessing
echo "====== Running Preprocessing_for_Size_Animacy_Classification ======"
jupyter nbconvert --to notebook --execute Preprocessing_for_Size_Animacy_Classification.ipynb \
    --output Preprocessing_for_Size_Animacy_Classification_output.ipynb \
    --ExecutePreprocessor.kernel_name=my_env
echo "====== Preprocessing Done ======"

# Step 2: EEGConformer Classification
echo "====== Running EEGConformer_Size_Animacy_Classification ======"
jupyter nbconvert --to notebook --execute EEGConformer_Size_Animacy_Classification.ipynb \
    --output EEGConformer_Size_Animacy_Classification_output.ipynb \
    --ExecutePreprocessor.kernel_name=my_env
echo "====== EEGConformer Done ======"

echo "====== Job Completed ======"


