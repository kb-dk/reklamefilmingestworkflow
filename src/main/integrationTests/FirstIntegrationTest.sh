#!/bin/bash

SCRIPT_PATH=$(dirname $(readlink -f $0))


echo "Running the first integration test."
echo "This attempts to process the list of files found in integrationTestInputFilelist"
                                             
echo "firstIntegrationTest: REKLAMEINGEST_LOGS=$REKLAMEINGEST_LOGS"

cd $SCRIPT_PATH/..

# Sadly so, much of the variables below are 'bound' / defined as available on canopus server
INPUT_FILELIST="$SCRIPT_PATH/integrationTestInputFilelist"
INPUT_METADATA_DIR="$HOME/reklamefilm-testdata/reklamedata"
INPUT_DATA_DIR="/net/halley/data0003/reklame/reklame_tv2/splits/1999/199901"
OUTPUTDIR="$HOME/var/reklameingest-output"

if [ -d "$OUTPUTDIR" ]; then
    rm -rf "$OUTPUTDIR"
fi
         
if [ -d "$REKLAMEINGEST_LOGS" ]; then
    rm -r "$REKLAMEINGEST_LOGS"
fi

$REKLAMEINGEST_HOME/bin/runWorkflow.sh "$INPUT_FILELIST" "$INPUT_DATA_DIR" "$INPUT_METADATA_DIR" "$OUTPUTDIR"
RETURNCODE=$?
if [ "$RETURNCODE" -ne "0" ]; then
    exit $RETURNCODE
fi

#RESULTDIR=$(cd $REKLAMEINGEST_LOGS && ls -1rtd | tail -1)

COUNT=$(ls -1 "$REKLAMEINGEST_LOGS/Workflow1_output/reklame_workflow_result/" | grep -v \.error | wc -l)
#echo $COUNT;
if [ "$COUNT" -gt "0" ]; then
    exit 0
else
    exit 1;
fi
