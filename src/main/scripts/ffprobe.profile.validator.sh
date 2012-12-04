#!/bin/bash

SCRIPT_PATH=$(dirname $(readlink -f $0))

ENTITY=$1
XML=$2
SCHEMATRON="reklame"

NAME=`basename $0 .sh`

source $SCRIPT_PATH/common.sh

APPDIR="${REKLAMEINGEST_HOME}/components/${profile.validator}/"

CMD="$APPDIR/bin/validateXmlWithProfile.sh $ENTITY $XML $CONFIGFILE $SCHEMATRON"

OUTPUT="`execute "$PWD" "$CMD" "$NAME" "$ENTITY"`"
RETURNCODE=$?
echo "$OUTPUT"
exit "$RETURNCODE"
