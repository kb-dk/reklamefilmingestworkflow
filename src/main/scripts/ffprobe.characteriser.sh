#!/bin/bash


SCRIPT_PATH=$(dirname $(readlink -f $0))

ENTITY=$1
LOCALFILE=$2

NAME=`basename $0 .sh`

source $SCRIPT_PATH/common.sh

CMD="${REKLAMEINGEST_HOME}/components/${ffprobe.characteriser}/bin/ffprobeCharacterise.sh $LOCALFILE $CONFIGFILE"

OUTPUT="`execute "$PWD" "$CMD" "$NAME" "$ENTITY"`"
RETURNCODE=$?
echo "$OUTPUT"
exit "$RETURNCODE"

