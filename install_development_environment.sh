#! /bin/bash

set -eu

sudo apt-get update
sudo cp ./etc/cfclient.desktop /usr/share/applications
sudo cp ./etc/cfclient.png /usr/share/icons
sudo apt-get install -y python2.7 python-usb python-pygame python-qt4 mercurial qtcreator cmake qt4-qmake

mkdir /tmp/install
cd /tmp/install
hg clone https://bitbucket.org/bitcraze/crazyflie-pc-client/src

cd src
sudo sh ./setup.sh

cd ../../
sudo rm -r install
mkdir -p ~/ros_ws/src

cd ~/ros_ws/src
catkin_init_workspace
git clone https://github.com/KITrokopter/Quadcopter-Application
git clone https://github.com/KITrokopter/Camera-Application
git clone https://github.com/KITrokopter/API-Application
git clone https://github.com/KITrokopter/Control-Application
source ../devel/setup.bash
echo "source ~/ros_ws/devel/setup.bash" >> ~/.bashrc
