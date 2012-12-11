#!/bin/bash

SCRIPT_PATH=$(dirname $(readlink -f $0))


if [ -z "$TAVERNA_HOME" ]; then
   echo "TAVERNA_HOME is not set. Must be set before execution. Exiting"
   exit 1
fi


VERSION=`head -1 $TAVERNA_HOME/release-notes.txt | sed 's/.$//' | cut -d' ' -f4`
LIB="$HOME/.taverna-$VERSION/lib"
if [ ! -d $LIB ] ; then
    mkdir -p $(dirname $LIB)
    ln -sf  $REKLAMEINGEST_HOME/workflowDependencies $LIB
fi
