#!/bin/bash
###
# Startup Script for the Sakuli headless testing container
###

# have to be added to hold all env vars correctly
# also will source $STARTUPDIR/generate_container_user
source $HOME/.bashrc

# If arg 1 is not one of the four possible Sakuli COMMANDs, execute as it is.
if [[ $1 =~ encrypt|-help|-version ]]; then SKIP=--skip ; fi

echo -e "\n\n------------------ START SAKULI CONTAINER ---------------------------"

## start UI and VNC components
$STARTUPDIR/vnc_startup.sh $SKIP
if [ -n $SKIP ]; then echo -e "\n\n------------------ VNC STARTUP finished -----------------------------" ; fi

#env
echo -e "\n\n------------------ SAKULI TEST EXECUTION start ----------------------"
echo "Executing: 'sakuli $@'"
$SAKULI_HOME/bin/sakuli "$@"
res=$?
echo "SAKULI_RETURN_VAL: $res"
exit $res