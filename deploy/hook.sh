#!/bin/bash

cd /var/www/$5
echo "Fetching code changes"
git fetch
echo "Reseting local changes"
git reset HEAD --hard
echo "Deploying"
git merge origin/master
echo "Updating dependencies"
./composer.phar update
echo "Updating external links"
source provision.sh