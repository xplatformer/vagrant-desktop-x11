#!/bin/bash
#=============================================================================
#
#          FILE:  bootstrap.sh
#
#         USAGE:  ./bootstrap.sh
#
#   DESCRIPTION: A template for bootstrap.sh
#       
#              
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#         NOTES:  ---
#        AUTHOR:  ---
#
#==============================================================================

start="$(date +%s)"

echo "+-----------------------------+"
echo "| X11 Development Environment |"
echo "+-----------------------------+"

echo "-----------------------------"
echo "Checking for external network connection..."
ONLINE=$(nc -z 8.8.8.8 53  >/dev/null 2>&1)
if [ $ONLINE -eq 0 ]; then
    echo "External network connection established, updating packages."
else
    echo "No external network available. Provisioning is halted."
    exit 1
fi

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
echo "+-----------------------------+"
echo "| X11 Development Provisioned |"
echo "+-----------------------------+"