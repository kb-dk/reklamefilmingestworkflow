#!/bin/bash

SCRIPT_PATH=$(dirname $(readlink -f $0))

echo "Running the suite of integration tests"

for test in *Test.sh; do
   echo ""
   source $SCRIPT_PATH/setup.sh
   echo "runIntegrationTest: REKLAMEINGEST_LOGS=$REKLAMEINGEST_LOGS"
   $SCRIPT_PATH/$test
   RETURNCODE="$?"
   $SCRIPT_PATH/teardown.sh
   if [ "$RETURNCODE" -ne "0" ]; then
       exit "$RETURNCODE"
   fi
   echo ""
done

echo "Tests complete, none failed"

