#!/bin/bash

SCRIPT_PATH=$(dirname $(readlink -f $0))

WD=$(pwd)

ENTITY="$1"
REMOTEURL="$2"
FFPROBEPROFILE_LOCATION="$3"
FFPROBEERROR_LOCATION="$4"
REKLAMEMETADATA_LOCATION="$5"
PBCOREMETADATA_LOCATION="$6"

NAME=`basename $0 .sh`

source $SCRIPT_PATH/common.sh

APPDIR="${REKLAMEINGEST_HOME}/components/${reklameingest.doms.ingester}"

if [ -e $PBCOREMETADATA_LOCATION ]; then
    PBCORE_SWITCH="--pbcore=$PBCOREMETADATA_LOCATION"
fi

#CMD="echo {\"domsPid\": \"uuid:9dabe130-f1d9-11e1-aff1-0800200c9a66\"}"
CMD="$JAVA_HOME/bin/java -cp $APPDIR/bin/*:$APPDIR/external-products/*:`dirname $CONFIGFILE` \
 dk.statsbiblioteket.doms.reklame.ReklameIngesterCLI \
 --filename=$ENTITY \
 --url=$REMOTEURL \
 --ffprobe=$WD/$FFPROBEPROFILE_LOCATION \
 --ffprobeErrorLog=$WD/$FFPROBEERROR_LOCATION \
 --reklamemetadata=$WD/$REKLAMEMETADATA_LOCATION \
 --config=$CONFIGFILE \
 $PBCORE_SWITCH"

OUTPUT="`execute "$PWD" "$CMD" "$NAME" "$ENTITY"`"
RETURNCODE=$?
echo "$OUTPUT"
exit "$RETURNCODE"

