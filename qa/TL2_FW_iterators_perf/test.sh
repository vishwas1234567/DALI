#!/bin/bash -e
# used pip packages
pip_packages="tensorflow-gpu torchvision mxnet-cu{cuda_v} torch paddle"
target_dir=./dali/test/python
one_config_only=true

do_once() {
    NUM_GPUS=$(nvidia-smi -L | wc -l)
}

test_body() {
    for fw in "mxnet" "pytorch" "tf" "paddle"; do
        python test_RN50_data_fw_iterators.py --framework ${fw} --gpus ${NUM_GPUS} -b 13 \
            --workers 3 --prefetch 2 --epochs 3
    done
}

pushd ../..
source ./qa/test_template.sh
popd
