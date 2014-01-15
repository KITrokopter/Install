#! /bin/bash

set -eu

# vim
sudo apt-get install vim
sudo apt-get install vim-gnome

# github, mercurial
sudo apt-get install git
sudo apt-get install mercurial

# crazyflie
hg clone https://bitbucket.org/bitcraze/crazyflie-pc-client
sudo apt-get install python2.7 python-usb python-pygame python-qt4
sudo setup.sh

# Setting udev permissions
# https://bitbucket.org/bitcraze/crazyflie-pc-client 
# The following steps ... use the USB Radio without being root... 


# Get ubuntu release information
. /etc/lsb-release

sudo cp ./etc/51-kinect.rules /etc/udev/rules.d/51-kinect.rules
sudo cp ./etc/lib64.conf /etc/ld.so.conf.d/
sudo service udev restart
sudo sh -c "echo 'deb http://packages.ros.org/ros/ubuntu $DISTRIB_CODENAME main' > /etc/apt/sources.list.d/ros-latest.list"
wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install libgtk2.0-dev subversion git-core cmake freeglut3-dev pkg-config build-essential libxmu-dev libxi-dev libusb-1.0-0-dev ros-hydro-desktop python-dev python-numpy libavcodec-dev libavformat-dev libswscale-dev libjpeg-dev libpng-dev

mkdir /tmp/install
cd /tmp/install

# opencv

git clone https://github.com/Itseez/opencv
cd opencv
git checkout 2.4.8
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local ..
make
sudo make install
cd ../..

# cvblob
svn checkout -r 400 http://cvblob.googlecode.com/svn/trunk/ cvblob
cd cvblob
cmake .
make
sudo make install
cd ..

# libfreenect
git clone git://github.com/OpenKinect/libfreenect.git
cd libfreenect
git checkout c55f3c94c422afc9f4c3c34327da9526b44f32a2 # use correct version, so that our fix doesn't destroy anything.
mkdir build
cd build
cmake ..
make
sudo make install

sudo ln /usr/local/include/libfreenect/libfreenect.h /usr/local/include/libfreenect.h

sudo ldconfig /usr/local/lib64/
sudo adduser $USER video
glview
sudo rm -r /tmp/install
sudo rosdep init
rosdep update
echo "source /opt/ros/hydro/setup.bash" >> ~/.bashrc
#source /opt/ros/hydro/setup.bash # needed for catkin_init_workspace
source ~/.bashrc

