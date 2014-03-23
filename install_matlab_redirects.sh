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
mv libtiff* $HOME/.matlabbackup

echo "Moved from ~/matlab/bin/glnxa64 libtiff* to ~/.matlabbackup"

echo "Downloading amcctoolbox revision 49..."
cd ~
svn checkout -r49 http://amcctoolbox.googlecode.com/svn/trunk/ amcctoolbox

echo "TODO: add amcctoolbox to matlab path"
