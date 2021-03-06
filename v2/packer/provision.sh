#!/bin/bash -x

TMP=$(echo ${OS_NAME}|tr '[A-Z]' '[a-z]')
VER=(${OS_VERSION//./ })


if [ "${TMP}" ==  "centos" ] || [ "${TMP}" == "fedora" ]
  then
    if [ "${TMP}" ==  "centos" ]
      then
       sudo yum install -y epel-release
       sudo yum install -y haveged parted curl unzip wget
      else
       sudo dnf install -y haveged parted curl unzip wget
       sudo cat /etc/sysconfig/network-scripts/ifcfg-eth0
       sudo mv /etc/sysconfig/network-scripts/ifcfg-eth0 /etc/sysconfig/network-scripts/ifcfg-eth0.bak
       sudo sed '/HWADDR=*/d' /etc/sysconfig/network-scripts/ifcfg-eth0.bak >> ifcfg-eth0.new
       sudo mv ifcfg-eth0.new /etc/sysconfig/network-scripts/ifcfg-eth0
       sudo rm -rf /etc/sysconfig/network-scripts/ifcfg-eth0.bak
       sudo cat /etc/sysconfig/network-scripts/ifcfg-eth0
       sudo rm -rf /etc/udev/rules.d/70-persistent-net.rules
       #sudo chattr +i /etc/sysconfig/network-scripts/ifcfg-eth0
    fi

    if [ "$(echo ${VER})" == "6" ]
      then
        sudo chkconfig haveged on
      else
        sudo systemctl enable haveged
    fi

    sudo sed -i '/^Defaults\s*requiretty$/d'/etc/sudoers

    sudo sed -i 's|UUID=[A-Fa-f0-9-]*|/dev/vda1 |' /etc/fstab

    sudo sed -i 's|UUID=[A-Fa-f0-9-]*|/dev/vda1 |' /boot/grub/menu.lst


else
    sudo apt-get update
    sudo apt-get install -y haveged curl bzip2 unzip

fi

### Clean

sudo mv /tmp/cloud-config.yaml /etc/cloud/cloud.cfg
sudo rm -rf /home/cloud/.ssh/*
sudo service rsyslog stop
sudo rm -rf /var/log/*
sudo rm -rf /home/cloud/bash_history
sudo rm -rf /var/tmp/*
sudo rm -rf /tmp/*