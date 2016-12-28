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

echo "-----------------------------"
echo "Checking for external network connection..."
ONLINE=$(nc -z 8.8.8.8 53  >/dev/null 2>&1)
if [ $ONLINE -eq 0 ]; then
    echo "External network connection established, updating packages."
else
    echo "No external network available. Provisioning is halted."
    exit 1
fi

#
# Add your code here:
#

end="$(date +%s)"
echo "-----------------------------"
echo "Provisioning complete in "$(expr $end_seconds - $start_seconds)" seconds"
echo "+---------------------------------------+"
echo "| Linux Development Provisioned |"
echo "+---------------------------------------+"