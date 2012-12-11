#!/bin/bash
#We need this to be a shell script rather than something we can source once :(
export REKLAMEINGEST_HOME="$HOME/reklame-ingest-workflow/services/workflow"
export REKLAMEINGEST_CONFIG="$HOME/reklamefilm-config"
export REKLAMEINGEST_LOGS="$HOME/logs/reklame/$(date +%Y-%m-%d)"
export REKLAMEINGEST_LOCKS="$HOME/var/locks"
export TAVERNA_HOME=~/taverna/taverna-workbench-2.4.0/
export JAVA_HOME=/usr/java/jdk1.6.0_32/
