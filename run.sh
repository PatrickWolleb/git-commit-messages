#!/bin/bash

LAST_DEPLOYMENT_COMMIT_HASH_FILE="$WERCKER_CACHE_DIR/last_deployed_$WERCKER_GIT_BRANCH"

if [ -f "$LAST_DEPLOYMENT_COMMIT_HASH_FILE" ]; then
    LAST_DEPLOYMENT_COMMIT_HASH=$(<$LAST_DEPLOYMENT_COMMIT_HASH_FILE) 
    WERCKER_GIT_DIFF_MESSAGES=$(git log --abbrev-commit --pretty=oneline $LAST_DEPLOYMENT_COMMIT_HASH...HEAD)
else
    WERCKER_GIT_DIFF_MESSAGES="First Run: No last commit hash to log against."  
fi

echo $WERCKER_GIT_COMMIT > $LAST_DEPLOYMENT_COMMIT_HASH_FILE