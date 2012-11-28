#!/bin/bash

WD=$PWD
cd $(dirname $(readlink -f $0))



ENTITY=$1
XML=$2
CHANNELID=$3

NAME=`basename $0 .sh`

source env.sh

APPDIR="$VHSINGEST_COMPONENTS/${profile.validator}/"

CMD="$APPDIR/bin/validateXmlWithProfile.sh $WD/$XML $CONFIGFILE"

OUTPUT="`execute "$PWD" "$CMD" "$NAME" "$ENTITY"`"
RETURNCODE=$?
echo "$OUTPUT"
exit "$RETURNCODE"
