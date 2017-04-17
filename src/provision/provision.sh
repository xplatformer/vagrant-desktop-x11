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
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#         NOTES:  ---
#        AUTHOR:  jrbeverly
#
#==============================================================================

echo "+----------------------------------------+"
echo "| Provisioning Environment               |"
echo "+----------------------------------------+"

start="$(date +%s)"

echo "-----------------------------"
echo "Installing libraries..."
apt-get -y install cmake g++ git pkg-config libx11-dev mesa-common-dev libglu1-mesa-dev libxrandr-dev libxi-dev

echo "-----------------------------"
echo "Installing software..."
add-apt-repository ppa:eugenesan/ppa -y
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sh -c 'echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

apt-get -y update
apt-get -y install smartgithg firefox google-chrome-stable

end="$(date +%s)"
echo "-----------------------------"
echo "Provisioning complete in "$(expr $end - $start)" seconds"
echo "+---------------------------------------+"
echo "| Environment Provisioned               |"
echo "+---------------------------------------+"