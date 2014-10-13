#!/bin/bash

LAST_DEPLOYMENT_COMMIT_HASH_FILE="$WERCKER_CACHE_DIR/last_deployed_$WERCKER_GIT_BRANCH"

cd $WERCKER_CACHE_DIR
ls
echo "$(cat $WERCKER_CACHE_DIR/last_deployed_$WERCKER_GIT_BRANCH)"
cd $WERCKER_SOURCE_DIR

if  test -d "$LAST_DEPLOYMENT_COMMIT_HASH_FILE"; then
		echo "HERE"
    LAST_DEPLOYMENT_COMMIT_HASH=$(<$LAST_DEPLOYMENT_COMMIT_HASH_FILE) 
    WERCKER_GIT_DIFF_MESSAGES=$(git log --abbrev-commit --pretty=oneline $LAST_DEPLOYMENT_COMMIT_HASH...HEAD)
else
		echo "THERE"
    WERCKER_GIT_DIFF_MESSAGES="First Run: No last commit hash to log against."  
fi

echo "DEBUG" $LAST_DEPLOYMENT_COMMIT_HASH_FILE 
cd $WERCKER_CACHE_DIR
ls
echo "$(cat $WERCKER_CACHE_DIR/last_deployed_$WERCKER_GIT_BRANCH)"
cd $WERCKER_SOURCE_DIR

echo $WERCKER_GIT_COMMIT > $LAST_DEPLOYMENT_COMMIT_HASH_FILE