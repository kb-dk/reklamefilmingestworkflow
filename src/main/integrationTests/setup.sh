#!/bin/bash

SCRIPT_PATH=$(dirname $(readlink -f $0))

echo "Running setup"
HOSTSETUP="$SCRIPT_PATH/$(hostname)Env.sh"
echo "HOSTSETUP= $HOSTSETUP"
if [ -r $HOSTSETUP ]; then
    echo "Running setup for $(hostname)"
    source $HOSTSETUP
fi

echo "setup: REKLAMEINGEST_LOGS=$REKLAMEINGEST_LOGS"
echo "setup: REKLAMEINGEST_HOME=$REKLAMEINGEST_HOME"

$REKLAMEINGEST_HOME/bin/setupTaverna.sh
echo "Setup done"

