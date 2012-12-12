#!/bin/bash

cd $(dirname $(readlink -f $0))

source $REKLAMEINGEST_CONFIG/workflow/combinedProperties.sh
source $REKLAMEINGEST_CONFIG/workflow/componentLoggingConfig.sh

source loggingEntity.sh
mkdir -p $LOGDIR

CONFIGNAME="$NAME"
CONFIGNAME="${CONFIGNAME//[\- _]/}"
CONFIGNAME=`echo $CONFIGNAME | tr '[A-Z]' '[a-z]'`
#CONFIGNAME="${CONFIGNAME,,}"
CONFIGNAME="${CONFIGNAME}Config"
CONFIGFILE="${!CONFIGNAME}"


function report_failure() {
    local COMPONENT="$1"
    local ENTITY="$2"
    local OUTPUTFILE="${REKLAMEINGEST_OUTPUT}/${COMPONENT}.failed"
    echo "$ENTITY" >> "$OUTPUTFILE"
}

function report_success() {
    local ENTITY="$1"
    local URL="$2"
    local PID="$3"
    local OUTPUTFILE="$REKLAMEINGEST_OUTPUT/succeded-files"
    echo "$ENTITY $URL $PID" >> "$OUTPUTFILE"
}

function execute() {
    local WORKINGDIR="$1"
    local CMD="$2"
    local NAME="$3"
    local ENTITY="$4"

    if [ -n "$ENTITY" ]; then
        debug "$ENTITY" "$NAME started:  $CMD"
    fi
    pushd "$WORKINGDIR" > /dev/null

    local tempfile="`mktemp`"
    chmod +r "$tempfile"
    local OUTPUT
    local RETURNCODE
    OUTPUT=$($CMD 2> "$tempfile")
    RETURNCODE="$?"
    popd > /dev/null

    local MESSAGE=""
    MESSAGE="std out: \n '$OUTPUT' \n std err: \n '"`cat "$tempfile"`"'"
    cat "$tempfile" >&2
    rm "$tempfile"
    echo "$OUTPUT"


    if [ -n "$ENTITY" ]; then
        if [ "$RETURNCODE" -eq "0" ]; then
            debug "$ENTITY" "$NAME completed $ENTITY: \n $MESSAGE"
        else
            error "$ENTITY" "$NAME failed $ENTITY: \n $MESSAGE"
            report_failure "$NAME" "$ENTITY" 
        fi
    fi
    return "$RETURNCODE"
}

