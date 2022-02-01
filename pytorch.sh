#!/bin/bash

BIN=/opt/venv/bin/

echo "PYTHON BIN" $BIN
pip=$BIN'pip'
python=$BIN'python'
read -p "is this correct?"
cd /usr/src || return

export LD_LIBRARY_PATH=/usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH

# upgrade pip



$pip install -U pip
$pip --version

# clone pyTorch repo
git clone --recursive https://github.com/pytorch/pytorch
cd pytorch  || return
# git submodule update --init
# git submodule update --init --recursive
git submodule sync
git submodule update --init --recursive --jobs 0
# install prereqs
$pip install -U setuptools
$pip install -r requirements.txt

# Develop Mode:
# $python setup.py build_deps  # This is returning invalid command...
$python setup.py develop

# Install Mode:  (substitute for Develop Mode commands)
$python setup.py install

# Verify CUDA (from python interactive terminal)
# import torch
# print(torch.__version__)
# print(torch.cuda.is_available())
# a = torch.cuda.FloatTensor(2)
# print(a)
# b = torch.randn(2).cuda()
# print(b)
# c = a + b
# print(c)

# CUDA_HOME (Linux/OS X)
#   CUDA_PATH (Windows)
#     specify where CUDA is installed; usually /usr/local/cuda or
#     /usr/local/cuda-x.y

#   REL_WITH_DEB_INFO
#     build with optimizations and -g (debug symbols)
#
#   MAX_JOBS
#     maximum number of compile jobs we should use to compile your code