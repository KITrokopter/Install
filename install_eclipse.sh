#! /bin/bash
sudo apt-get update
sudo apt-get install default-jre
sudo cp ./etc/eclipse.desktop /usr/share/applications
sudo cp ./etc/eclipse /usr/bin
mkdir /tmp/install
cd /tmp/install
wget http://ftp.halifax.rwth-aachen.de/eclipse//technology/epp/downloads/release/kepler/SR1/eclipse-cpp-kepler-SR1-linux-gtk-x86_64.tar.gz -O eclipse.tar.gz
tar -xf eclipse.tar.gz
sudo mv eclipse /opt/eclipse
cd ../
rm -r install
cd /opt
sudo chown -R root:root eclipse
sudo chmod -R +r eclipse
sudo chmod +x eclipse/eclipse
sudo chmod 755 /usr/bin/eclipse