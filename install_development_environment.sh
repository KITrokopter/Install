#! /bin/bash

set -eu

sudo apt-get update
sudo cp ./etc/cfclient.desktop /usr/share/applications
sudo cp ./etc/cfclient.png /usr/share/icons
sudo apt-get install -y python2.7 python-usb python-pygame python-qt4 mercurial qtcreator cmake qt4-qmake

[ -d /tmp/install ] || mkdir /tmp/install
cd /tmp/install
hg clone https://bitbucket.org/bitcraze/crazyflie-pc-client/src

cd src
sudo chmod a+x ./setup.sh
sudo sh ./setup.sh

cd ../../
sudo rm -r install

source /opt/ros/hydro/setup.bash # Should be necessary
mkdir -p ~/ros_ws/src
cd ~/ros_ws/src
catkin_init_workspace
git clone https://github.com/KITrokopter/Quadcopter-Application quadcopter_application
git clone https://github.com/KITrokopter/Camera-Application camera_application
git clone https://github.com/KITrokopter/API-Application api_application
git clone https://github.com/KITrokopter/Control-Application control_application

cd ..
# Initial build is necessary to create the devel directory.
catkin_make
source devel/setup.bash
echo "source ~/ros_ws/devel/setup.bash" >> ~/.bashrc
