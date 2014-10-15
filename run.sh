#!/bin/bash

LAST_DEPLOYMENT_COMMIT_HASH_FILE="$WERCKER_CACHE_DIR/last_deployed_$WERCKER_GIT_BRANCH"

if [ -n "$WERCKER_GIT_COMMIT_MESSAGES_DEBUG" ]
then
    warn "Debug mode turned on in git commit messages"
    cd $WERCKER_CACHE_DIR
    ls
    cd ..
    debug $LAST_DEPLOYMENT_COMMIT_HASH_FILE

fi



if [ -f "$LAST_DEPLOYMENT_COMMIT_HASH_FILE" ]; then
    LAST_DEPLOYMENT_COMMIT_HASH=$(<$LAST_DEPLOYMENT_COMMIT_HASH_FILE)
    WERCKER_GIT_DIFF_MESSAGES=$(git log --abbrev-commit --pretty=oneline $LAST_DEPLOYMENT_COMMIT_HASH...HEAD)
    if [ -n "$WERCKER_GIT_COMMIT_MESSAGES_DEBUG" ]; then
        debug "Pulled commit hash"
        debug $LAST_DEPLOYMENT_COMMIT_HASH
        debug "Created messages"
        debug $WERCKER_GIT_DIFF_MESSAGES
    fi
else
    WERCKER_GIT_DIFF_MESSAGES="First Run: No last commit hash to log against."
fi

echo $WERCKER_GIT_COMMIT > $LAST_DEPLOYMENT_COMMIT_HASH_FILE


if [ -n "$WERCKER_GIT_COMMIT_MESSAGES_DEBUG" ]; then
    debug "New cached commit hash"
    debug $(<$LAST_DEPLOYMENT_COMMIT_HASH_FILE)
    debug "Output messages"
    debug $WERCKER_GIT_DIFF_MESSAGES
fi
