#!/bin/bash
#=============================================================================
#
#          FILE:  provision.sh
#
#         USAGE:  ./provision.sh
#
#   DESCRIPTION: The primary provisioning script for the linux desktop 
#       environment.  It setups the desktop to use have the necessary 
#       components for a good user experience.  
#       
#              
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#         NOTES:  ---
#        AUTHOR:  jrbeverly
#
#==============================================================================
# Functions
#

#==============================================================================

echo "+----------------------------------------+"
echo "| Provisioning Linux Desktop Environment |"
echo "+----------------------------------------+"

start="$(date +%s)"

echo "-----------------------------"
echo "Checking for external network connection..."
ONLINE=$(nc -z 8.8.8.8 53  >/dev/null 2>&1)
if [[ $ONLINE -eq $zero ]]; then 
    echo "External network connection established, updating packages."
else
    echo "No external network available. Provisioning is halted."
    exit 1
fi

echo "-----------------------------"
echo "Setting timezone..."
apt-get -y install python-pip
pip install -U tzupdate
tzupdate

echo "-----------------------------"
echo "Updating..."
apt-get -y update && apt-get -y upgrade && apt-get -y autoremove

echo "-----------------------------"
echo "Installing $ENVIRONMENT environment" 
if [ "$ENVIRONMENT" == "lubuntu" ]; then
    apt-get -y install --no-install-recommends lubuntu-desktop
elif [ "$ENVIRONMENT" == "lubuntu-full" ]; then
    apt-get -y install --install-recommends lubuntu-desktop 
elif [ "$ENVIRONMENT" == "ubuntu" ]; then
    apt-get -y install --no-install-recommends ubuntu-desktop 
    apt-get -y install --install-recommends unity indicator-session
    apt-get -y install gnome-terminal
elif [ "$ENVIRONMENT" == "ubuntu-full" ]; then
    apt-get -y install ubuntu-desktop 
fi

#elif [ "$ENVIRONMENT" == "kubuntu" ]; then
#    apt install -y kubuntu-desktop
#elif [ "$ENVIRONMENT" == "lxde" ]; then
#    apt install -y lxde
#elif [ "$ENVIRONMENT" == "cinnamon" ]; then
#    add-apt-repository ppa:embrosyn/cinnamon -y
#    apt-get -y update
#    apt-get -y install cinnamon blueberry

echo "-----------------------------"
apt-get install -y virtualbox-guest-utils virtualbox-guest-x11 virtualbox-guest-dkms

echo "-----------------------------"
echo “LANG=en_US.UTF-8” >> /etc/environment
echo “LANGUAGE=en_US.UTF-8” >> /etc/environment
echo “LC_ALL=en_US.UTF-8” >> /etc/environment
echo “LC_CTYPE=en_US.UTF-8” >> /etc/environment

end="$(date +%s)"
echo "-----------------------------"
echo "Provisioning complete in "$(expr $end_seconds - $start_seconds)" seconds"
echo "+---------------------------------------+"
echo "| Linux Desktop Environment Provisioned |"
echo "+---------------------------------------+"