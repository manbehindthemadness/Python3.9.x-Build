#! /bin/bash
# https://itheo.nl/install-python-3-9-on-raspberry-pi
cd /usr/src  || return
rm -fdr Python-3.9.5
sudo apt -y install libssl-dev libnss3-dev
sudo apt -y install libncurses5-dev
sudo apt -y install libsqlite3-dev
sudo apt -y install libreadline-dev
sudo apt -y install libtk8.6
sudo apt -y install libgdm-dev
sudo apt -y install libdb4o-cil-dev
sudo apt -y install libpcap-dev
sudo apt -y install zlib1g-dev libbz2-dev
sudo apt -y install libffi-dev
sudo apt -y install build-essential
sudo apt -y install python-dev python-setuptools python-pip python-smbus
# Pillow
sudo apt -y install libtiff-dev libjpeg-dev libopenjp2-7-dev zlib1g-dev \
    libfreetype6-dev liblcms2-dev libwebp-dev tcl8.6-dev tk8.6-dev python3-tk \
    libharfbuzz-dev libfribidi-dev libxcb1-dev
# tkinter # https://stackoverflow.com/questions/32156691/running-a-program-with-gui-without-displaying-in-ubuntu/32156776
sudo apt -y install xorg* x11-xkb-utils xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic x11-apps xvkb x11-xserver-utils
# Rust and docker https://github.com/docker/compose/issues/8105 (optional)
# sudo apt -y install rust cargo ruby ca-certificates
# Enable tk
sudo apt -y install python-tk3
wget https://www.python.org/ftp/python/3.9.5/Python-3.9.5.tar.xz
tar xf Python-3.9.5.tar.xz
cd Python-3.9.5  || return
./configure --prefix=/usr/local/opt/python-3.9.5 --enable-optimizations
make -j 4
make altinstall

ln -s /usr/local/opt/python-3.9.5/bin/python3.9 /usr/bin/python3.9
ln -s /usr/local/opt/python-3.9.5/bin/pip3.9 /usr/bin/pip3.9

sudo apt-get -y autoremove

pip3.9 install virtualenv

ln -s /usr/local/opt/python-3.9.5/bin/virtualenv /usr/bin/virtualenv
cd /opt || return
virtualenv --system-site-packages venv
source venv/bin/activate

echo python setup complete!