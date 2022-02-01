#! /bin/bash
cd /usr/src || return

wget http://www.airspayce.com/mikem/bcm2835/bcm2835-1.68.tar.gz
tar zxvf bcm2835-1.68.tar.gz
cd bcm2835-1.68/ || return
sudo ./configure
sudo make
sudo make check
sudo make install