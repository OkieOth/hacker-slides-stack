#!/bin/bash

scriptPos=${0%/*}

source $scriptPos/stackConf.sh

composeFile="$STACK_NAME.yml"

docker-compose -p "$STACK_NAME" -f $scriptPos/../docker/$STACK_NAME.yml down
