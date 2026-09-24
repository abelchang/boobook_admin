#!/bin/bash

case $1 in
    "")
        CMD="run"
        ENV="local"
        ;;
    "pre")
        CMD="run"
        ENV="production"
        ;;
    "release")
        CMD="run --release"
        ENV="production"
        ;;
    "dev")
        CMD="run"
        ENV="staging"
        ;;
    "profile")
        CMD="run --profile"
        ENV="local"
        ;;
    "webdev")
        CMD="run -d chrome"
        ENV="local"
        ;;
    "web")
        CMD="run -d chrome"
        ENV="production"
        ;;
    *)
        echo "not support this arg ${1}"
        exit 1
        ;;
esac

VARS=( $(cut -d ' ' -f1 .env.${ENV}) )
DART_DEFINES=""
for (( i = 0; i < ${#VARS[@]}; i++ )); do
    DART_DEFINES+=" --dart-define=${VARS[i]}"
done
echo "CMD: ${CMD}"
echo "ENV: ${ENV}"
echo "DART_DEFINES: ${DART_DEFINES}"

flutter $CMD $DART_DEFINES
