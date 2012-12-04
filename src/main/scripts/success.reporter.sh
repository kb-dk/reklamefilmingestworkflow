#!/bin/bash

SCRIPT_PATH=$(dirname $(readlink -f $0))

FILENAME="$1"
BITREPOURL="$2"
DOMSPID="$3"

source $SCRIPT_PATH/common.sh

report_success "$FILENAME" "$BITREPOURL" "$DOMSPID"

