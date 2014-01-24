#!/bin/bash

[ whoami = "root" ] && echo "Don't run me as root!" && exit

USER_HOME=$HOME

[ -d /tmp/install ] && rm -rf /tmp/install
mkdir -p /tmp/install
cd /tmp/install


echo "$USER_HOME/matlab/bin/glnxa64/" > matlab.conf
sudo cp matlab.conf /etc/ld.so.conf.d/

echo "PATH=$PATH:$USER_HOME/matlab/bin" >> ~/.bashrc
