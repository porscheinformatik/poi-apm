#!/bin/bash

apm update -y --force

# if the arguments contain -c then compile, too
if [[ "$@" == *"-c"* ]]
then
    apm compile
fi

apm install
