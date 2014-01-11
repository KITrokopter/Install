#! /bin/bash
sudo cp ./etc/51-kinect.rules /etc/udev/rules.d/51-kinect.rules
sudo cp ./etc/lib64.conf /etc/ld.so.conf.d/
sudo service udev restart
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu precise main" > /etc/apt/sources.list.d/ros-latest.list'
wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install libgtk2.0-dev subversion git-core cmake freeglut3-dev pkg-config build-essential libxmu-dev libxi-dev libusb-1.0-0-dev ros-hydro-desktop libopencv-dev libopencv-core-dev libopencv-highgui-dev libopencv-features2d-dev libopencv-calib3d-dev libopencv-objdetect-dev
mkdir /tmp/install
cd /tmp/install

# cvblob
svn checkout http://cvblob.googlecode.com/svn/trunk/ cvblob
cd cvblob
cmake .
make
sudo make install
cd ..

# libfreenect
git clone git://github.com/OpenKinect/libfreenect.git
git checkout c55f3c94c422afc9f4c3c34327da9526b44f32a2 # use correct version, so that our fix doesn't destroy anything.
cd libfreenect
mkdir build
cd build
cmake ..
make
sudo make install

sudo ldconfig /usr/local/lib64/
sudo adduser $USER video
glview
sudo rm -r /tmp/install
sudo rosdep init
rosdep update
echo "source /opt/ros/hydro/setup.bash" >> ~/.bashrc
#source /opt/ros/hydro/setup.bash # needed for catkin_init_workspace
source ~/.bashrc

# add symbolic links to fix different directory structures
sudo ln /usr/local/include/libfreenect/libfreenect.h /usr/local/include/libfreenect.h
sudo ln -s -T /usr/include/opencv2 /usr/include/opencv
sudo ln /usr/include/opencv2/core/core_c.h /usr/include/opencv2/cv.h
