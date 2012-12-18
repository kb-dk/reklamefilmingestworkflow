#!/bin/bash

SCRIPT_PATH=$(dirname $(readlink -f $0))

FILELIST="$1"
DATADIR="$2"
METADATADIR="$3"
OUTPUTDIR="$4"

if [ -z "$REKLAMEINGEST_HOME" ]; then
   echo "REKLAMEINGEST_HOME is not set. Must be set before execution. Exiting"
   exit 1
fi


if [ -z "$TAVERNA_HOME" ]; then
   echo "TAVERNA_HOME is not set. Must be set before execution. Exiting"
   exit 1
fi

if [ -z "$JAVA_HOME" ]; then
   echo "JAVA_HOME is not set. Must be set before execution. Exiting"
   exit 1
fi

if [ -z "$REKLAMEINGEST_CONFIG" ]; then
   echo "REKLAMEINGEST_CONFIG is not set. Must be set before execution. Exiting"
   exit 1
fi

if [ -e $OUTPUTDIR ]; then
   echo "OUTPUTDIR ($OUTPUTDIR) already exists, this is not allowed"
   exit 2
fi 

mkdir "$OUTPUTDIR"
export REKLAMEINGEST_OUTPUT=$OUTPUTDIR
mkdir -p "$REKLAMEINGEST_LOGS"
mkdir -p "$REKLAMEINGEST_LOCKS"

if [ "$(ps -ef | grep [\ ]$REKLAMEINGEST_HOME/taverna/reklamefilm_workflow.t2flow)" != "" ] ; then
    echo "executeworkflow.sh was running, exiting!"
    exit 1 
fi


#TODO probably remove this, as it does not actually do anything after the logrotater was added
#TAVERNA_OUT_DIR=$(mktemp -d -u --tmpdir="$REKLAMEINGEST_LOGS" "$1-runNr-XXX")


mkdir -p $HOME/tmp/taverna
#TODO where should this be
cleanup () {
   rm -rf "$TAVERNA_TEMP_DIR"
}
trap cleanup 0 3 15
TAVERNA_TEMP_DIR=$(mktemp -d --tmpdir="$HOME/tmp/taverna")
chmod a+r "$TAVERNA_TEMP_DIR"

# place damn tarverna logs the right place
cd $REKLAMEINGEST_LOGS

export TMPDIR="$TAVERNA_TEMP_DIR"
export TEMPDIR="$TAVERNA_TEMP_DIR"
export TMP="$TAVERNA_TEMP_DIR"
export TEMP="$TAVERNA_TEMP_DIR"
export _JAVA_OPTIONS="-Djava.io.tmpdir=$TAVERNA_TEMP_DIR"

$TAVERNA_HOME/executeworkflow.sh \
-inmemory \
-inputvalue filelist "$FILELIST"  \
-inputvalue dataDir "$DATADIR" \
-inputvalue metadataDir "$METADATADIR" \
"$REKLAMEINGEST_HOME/taverna/reklamefilm_workflow.t2flow" #\
#-outputdir "$TAVERNA_OUT_DIR"
