#!/bin/bash

WD=$(pwd)
cd $(dirname $(readlink -f $0))

ENTITY=$1
REMOTEURL=$2
CHECKSUM=$3
FFPROBEPROFILE_LOCATION=$4
VHSMETADATA_LOCATION=$5

NAME=`basename $0 .sh`

source common.sh

APPDIR="${REKLAMEINGEST_HOME}/components/${vhsingest.doms.ingester}"

cd $WD

#CMD="echo {\"domsPid\": \"uuid:9dabe130-f1d9-11e1-aff1-0800200c9a66\"}"
CMD="$JAVA_HOME/bin/java -cp $APPDIR/bin/*:$APPDIR/external-products/*:`dirname $CONFIGFILE` \
 dk.statsbiblioteket.doms.vhs.VHSIngesterCLI \
 -filename $ENTITY \
 -url $REMOTEURL \
 -ffprobe $FFPROBEPROFILE_LOCATION \
 -metadata $VHSMETADATA_LOCATION \
 -config $CONFIGFILE "

OUTPUT="`execute "$PWD" "$CMD" "$NAME" "$ENTITY"`"
RETURNCODE=$?
echo "$OUTPUT"
exit "$RETURNCODE"

