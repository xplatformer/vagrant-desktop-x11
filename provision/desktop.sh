#!/bin/bash
#
# desktop.sh
#
# This file is specified in the Vagrantfile and is loaded by Vagrant as the
# primary provisioning script on the first `vagrant up` or subsequent 'up' with
# the '--provision' flag; also when `vagrant provision`, or `vagrant reload --provision`
# are used. It provides all of the default packages and configurations included
# with Vagrant's Ubuntu 12.04 Desktop Environment for Windows. You can also bring up your
# environment and explicitly not run provisioners by specifying '--no-provision'.

# By storing the date now, we can calculate the duration of provisioning at the
# end of this script.
start_seconds="$(date +%s)"

# Capture a basic ping result to Google's primary DNS server to determine if
# outside access is available to us. If this does not reply after 2 attempts,
# we try one of Level3's DNS servers as well. If neither IP replies to a ping,
# then we'll skip a few things further in provisioning rather than creating a
# bunch of errors.
ping_result="$(ping -c 2 8.8.4.4 2>&1)"
if [[ $ping_result != *bytes?from* ]]; then
        ping_result="$(ping -c 2 4.2.2.2 2>&1)"
fi

apt-get -y update && apt-get -y upgrade && apt-get -y autoremove

# Setting encoding
echo "-----------------------------"
echo “LANG=en_US.UTF-8” >> /etc/environment
echo “LANGUAGE=en_US.UTF-8” >> /etc/environment
echo “LC_ALL=en_US.UTF-8” >> /etc/environment
echo “LC_CTYPE=en_US.UTF-8” >> /etc/environment

echo "-----------------------------"
echo "Installing virtualbox guest"
apt-get --no-install-recommends install -y virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11
sed -i 's/allowed_users=.*$/allowed_users=anybody/' /etc/X11/Xwrapper.config

echo "-----------------------------"
echo "Installing graphic desktop manager"
apt-get install gdm
dpkg-reconfigure gdm

echo "-----------------------------"
echo "Installing desktop environment"
ENVIRONMENT=$@
echo "Argument is passed " $ENVIRONMENT
if [ "$ENVIRONMENT" == "lubuntu" ]; then
    apt-get --no-install-recommends install -y lubuntu-desktop
elif [ "$ENVIRONMENT" == "ubuntu" ]; then
    apt-get --no-install-recommends install -y ubuntu-desktop
else
    apt-get --no-install-recommends install -y ubuntu-desktop
    apt-get install -y software-center*
fi

echo "-----------------------------"
echo "Installing essentials"
apt-get install -y gnome-terminal

end_seconds="$(date +%s)"
echo "-----------------------------"
echo "Desktop provisioning complete in "$(expr $end_seconds - $start_seconds)" seconds"
if [[ $ping_result == *bytes?from* ]]; then
        echo "External network connection established, packages up to date."
else
        echo "No external network available. Package installation and maintenance skipped."
fi