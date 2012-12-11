#!/bin/bash

SCRIPT_PATH=$(dirname $(readlink -f $0))

FILENAME="$1"
FILEPATH="$2"
CHECKSUM="$3"
LOCALFILEURL="file://${FILEPATH}"
FILESIZE=$(stat -c%s $FILEPATH)

NAME=`basename $0 .sh`

source $SCRIPT_PATH/common.sh

APPDIR="${REKLAMEINGEST_HOME}/components/${reklameingest.bitrepository.ingester}"

#dk.statsbiblioteket.medieplatform.bitrepository.ingester.Ingester \
CMD="$JAVA_HOME/bin/java -cp $APPDIR/bin/*:$APPDIR/external-products/* \
dk.statsbiblioteket.medieplatform.bitrepository.ingester.TheMockClient \
$CONFIGFILE $LOCALFILEURL $FILENAME $CHECKSUM $FILESIZE"

OUTPUT="`execute "$APPDIR" "$CMD" "$NAME" "$FILENAME"`"
RETURNCODE=$?
echo "$OUTPUT"
exit "$RETURNCODE"




