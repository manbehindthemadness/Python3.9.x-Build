#! /bin/bash
apt-get install libnetpbm10-dev
git clone https://git.kernel.org/pub/scm/linux/kernel/git/geert/fbtest.git
cd fbtest || return
# fb.c - remove #include <asm/page.h>
make
./fbtest --fbdev /dev/fb1
