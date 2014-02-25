#!/bin/bash

if [ "$(id -u)" == "0" ]; then
   echo "This script must not be run as root" 1>&2
   exit 1
fi

echo 'export PATH=$PATH'":$HOME/matlab/bin" >> ~/.bashrc

# Required to use matlab and libopencv_highgui at once
cd $HOME
mkdir .matlabbackup
cd matlab/bin/glnxa64
mv libtiff* ../../../.matlabbackup

echo "Moved from ~/matlab/bin/glnxa64 libtiff* to ~/.matlabbackup"
