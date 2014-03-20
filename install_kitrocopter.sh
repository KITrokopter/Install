#! /bin/bash

# Terminate on error
set -eu

# Get ubuntu release name
. /etc/lsb-release

# Setting udev permissions
sudo cp ./etc/51-kinect.rules /etc/udev/rules.d/51-kinect.rules
# Adding /usr/local/lib64 as library path
sudo cp ./etc/lib64.conf /etc/ld.so.conf.d/
sudo service udev restart
sudo sh -c "echo 'deb http://packages.ros.org/ros/ubuntu $DISTRIB_CODENAME main' > /etc/apt/sources.list.d/ros-latest.list"
wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install libgtk2.0-dev python2.7 python-usb python-pygame python-qt4 mercurial vim vim-gnome subversion git-core cmake freeglut3-dev csh pkg-config build-essential libxmu-dev libxi-dev libusb-1.0-0-dev ros-hydro-desktop python-dev python-numpy libavcodec-dev libavformat-dev libswscale-dev libjpeg-dev libpng-dev libboost-chrono-dev ssh

[ -d /tmp/install ] && rm -rf /tmp/install

mkdir /tmp/install
cd /tmp/install

# crazyflie
hg clone https://bitbucket.org/bitcraze/crazyflie-pc-client
cd crazyflie-pc-client
echo "Running crazyflie setup"
sudo chmod u+x setup.sh
sudo ./setup.sh
echo "Crazyflie setup complete"
cd ..

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
sudo rm -r /tmp/install
sudo rosdep init
rosdep update
echo "source /opt/ros/hydro/setup.bash" >> ~/.bashrc

# Finished
echo
echo "    $(tput setaf 2)Installation finished.$(tput sgr0) You should $(tput setaf 4)restart$(tput sgr0) your terminal now $(tput setaf 4)or execute$(tput sgr0):"
echo "        source ~/.bashrc"
echo
echo "    Hint: If you are a developer, you might also want to run install_development_environment.sh"
