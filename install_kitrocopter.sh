#! /bin/bash
sudo cp ./etc/51-kinect.rules /etc/udev/rules.d/51-kinect.rules
sudo service udev restart
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu precise main" > /etc/apt/sources.list.d/ros-latest.list'
wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get install libopencv-dev libopencv-core-dev libgtk2.0-dev libopencv-highgui-dev libopencv-features2d-dev libopencv-calib3d-dev subversion libopencv-objdetect-dev git-core cmake freeglut3-dev pkg-config build-essential libxmu-dev libxi-dev libusb-1.0-0-dev subversion ros-hydro-desktop-full
mkdir /tmp/install
cd /tmp/install
svn checkout http://cvblob.googlecode.com/svn/trunk/ cvblob
cd cvblob
cmake .
make
sudo make install
cd ..
git clone git://github.com/OpenKinect/libfreenect.git
cd libfreenect
mkdir build
cd build
cmake ..
make
sudo make install
sudo ldconfig /usr/local/lib64/
sudo glview
sudo adduser $USER video
sudo rm -r /tmp/install
sudo rosdep init
rosdep update
echo "source /opt/ros/hydro/setup.bash" >> ~/.bashrc
source /opt/ros/hydro/setup.bash # needed for catkin_init_workspace
source ~/.bashrc

