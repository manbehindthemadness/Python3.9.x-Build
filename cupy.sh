#! /bin/bash

BIN=/opt/venv/bin/

echo "PYTHON BIN" $BIN
pip=$BIN'pip'
read -p "is this correct?"

cd /usr/src || return
git clone https://github.com/cupy/cupy.git
export CUDA_PATH=/usr/local/cuda-10.2
export LD_LIBRARY_PATH=$CUDA_PATH/lib64:$LD_LIBRARY_PATH
cd cupy || return
source venv/bin/activate
$pip install -U setuptools wheel pip numpy scipy
$pip install cupy
