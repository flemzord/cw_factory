#! /bin/bash -x


echo ${OS_NAME}

echo ${OS_VERSION}



TMP=$(echo ${OS_NAME}|tr '[A-Z]' '[a-z]')

if [ "${TMP}" ==  "centos" ] || [ "${TMP}" == "fedora" ]
then

  if [ "${TMP}" ==  "centos" ]
  then
  sudo rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-$(bc <<< "scale=0;${OS_VERSION}/1").noarch.rpm
  fi

sudo sed -i '/^Defaults\s*requiretty$/d'/etc/sudoers

sudo sed -i 's|^UUID=.*|/dev/vda1|' /etc/fstab

sudo sed -i 's|^UUID=.*|/dev/vda1|' /boot/grub/menu.lst

sudo yum install -y haveged parted

elif [ "${TMP}" ==  "centos" ] || [ "${TMP}" == "fedora" ]

then
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