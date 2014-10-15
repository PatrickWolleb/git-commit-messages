#!/bin/bash

# Test file run LOCAL=true ./test.sh

rm -rf test
rm -rf cache

mkdir test
cd test/

mkdir cache/

git init


# it should show inital commit message and create a cahe file 

touch f1le1
git add --all
git commit -m 'First commit'

if [ -n "$LOCAL" ]; then
	WERCKER_GIT_COMMIT=`git rev-parse HEAD` WERCKER_CACHE_DIR=cache WERCKER_GIT_BRANCH=master ../run.sh 
	echo $WERCKER_GIT_DIFF_MESSAGES
fi


# it should show message with two commits in it

touch f1le2
git add --all
git commit -m 'Second commit'

touch f1le3
git add --all
git commit -m 'Third commit'

if [ -n "$LOCAL" ]; then
	WERCKER_CACHE_DIR=cache WERCKER_GIT_BRANCH=master ../run.sh 
	echo $WERCKER_GIT_DIFF_MESSAGES
fi