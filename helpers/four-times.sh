#!/bin/bash

TARGET=document

if [ "$1" != "" ]; then
    TARGET="$1"
fi

make $TARGET && \
    make $TARGET && \
    make $TARGET && \
    make $TARGET

RET=$?

if [ $RET -eq 0 ]; then
    notify-send "$TARGET compiled"
else
    notify-send --urgency=critical "$TARGET failed to compile"
fi

