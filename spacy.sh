#!/bin/bash


BIN=/opt/venv/bin/

echo "PYTHON BIN" $BIN
pip=$BIN'pip'
python=$BIN'python'
read -p "is this correct?"
cd /usr/src || return

apt-get install apt-utils cmake build-essential pkg-config libgoogle-perftools-dev
git clone https://github.com/google/sentencepiece.git
cd sentencepiece || return
mkdir build
cd build || return
cmake ..
make -j $(nproc)
make install
ldconfig -v
cd ../python || return
$python setup.py build
$python setup.py install

cd /usr/src || return
git clone https://github.com/explosion/spaCy
cd spaCy/ || return
export PYTHONPATH=`pwd`
export BLIS_ARCH=generic
$pip install -r requirements.txt
$python setup.py build_ext --inplace

read -p "setup.cfg needs to have cupy-cuda102 changed to: cuda102 = cupy>=9.2.0,<10.0.0"

# $python setup.py install  --no-build-isolation --editable .[lookups,cuda102]
$python setup.py install
$python -m spacy download en_core_web_sm

$python -m spacy validate

# import spacy

# spacy.prefer_gpu()
# nlp = spacy.load("en_core_web_sm")