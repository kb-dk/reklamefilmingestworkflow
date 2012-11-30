#!/bin/bash

WD=$PWD
cd $(dirname $(readlink -f $0))

ENTITY=$1
XML=$2

NAME=`basename $0 .sh`

source common.sh

APPDIR="${REKLAMEINGEST_HOME}/components/${profile.validator}/"

CMD="$APPDIR/bin/validateXmlWithProfile.sh $WD/$XML $CONFIGFILE"

OUTPUT="`execute "$PWD" "$CMD" "$NAME" "$ENTITY"`"
RETURNCODE=$?
echo "$OUTPUT"
exit "$RETURNCODE"
