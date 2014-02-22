#!/bin/bash

echo "export PATH=$PATH:$USER_HOME/matlab/bin" >> ~/.bashrc

# Required to use matlab and libopencv_highgui at once
cd $USER_HOME
mkdir .matlabbackup
cd matlab/bin/glnxa64
mv libtiff* ../../.matlabbackup

echo "Moved libtiff5 to ~/.matlabbackup"
