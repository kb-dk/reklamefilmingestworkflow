#!/bin/bash

FILEPATH="$1"

md5sum $FILEPATH | cut -d' ' -f1
