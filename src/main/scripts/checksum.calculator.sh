#!/bin/bash

FILE="$1"
DIR="$2"

FILEPATH="$DIR/$FILE"

md5sum $FILEPATH | cut -d' ' -f1
