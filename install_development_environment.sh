#! /bin/bash

set -eu

sudo apt-get update
sudo cp ./etc/cfclient.desktop /usr/share/applications
sudo cp ./etc/cfclient.png /usr/share/icons
sudo cp ./etc/vncserver /etc/init.d/
[ -d ~/.vnc ] || mkdir ~/.vnc
cp ./etc/xstartup ~/.vnc/
sudo update-rc.d -f vncserver defaults
sudo apt-get install -y python2.7 python-usb python-pygame python-qt4 mercurial qtcreator cmake qt4-qmake tightvncserver gnome-session-fallback

sudo service vncserver start

[ -d /tmp/install ] || mkdir /tmp/install
cd /tmp/install

echo "Installing crazyflie client"
hg clone https://bitbucket.org/bitcraze/crazyflie-pc-client/src
cd src
sudo chmod a+x ./setup.sh
sudo sh ./setup.sh
echo "Crazyflie client installed"

cd ../../
sudo rm -r install

echo "Setting up ros workspace"
source /opt/ros/hydro/setup.bash # If the user didn't source .bashrc after kitrokopter installation.
mkdir -p ~/ros_ws/src
cd ~/ros_ws/src
catkin_init_workspace
git clone https://github.com/KITrokopter/Quadcopter-Application quadcopter_application
git clone https://github.com/KITrokopter/Camera-Application camera_application
git clone https://github.com/KITrokopter/API-Application api_application
git clone https://github.com/KITrokopter/Control-Application control_application
git clone https://github.com/KITrokopter/GUI-Application gui_application
cd ..
# Initial build is necessary to create the devel directory.
catkin_make
catkin_make install # Do this so that packages can be run directly after installation.
echo "Workspace was successfully set up"

echo "source ~/ros_ws/devel/setup.bash" >> ~/.bashrc

# Finished
echo
echo "    There is a VNC server running at :5"
echo
echo "    $(tput setaf 2)Installation finished.$(tput sgr0) You should $(tput setaf 4)restart$(tput sgr0) your terminal now $(tput setaf 4)or execute$(tput sgr0):"
echo "        source ~/.bashrc"
echo
