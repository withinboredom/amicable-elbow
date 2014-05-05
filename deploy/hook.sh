#!/bin/bash

cd /var/www/appti2ude
echo "Fetching code changes"
git fetch
echo "Reseting local changes"
git reset HEAD --hard
echo "Deploying"
git merge origin/master
echo "Updating dependencies"
./composer.phar update
echo "Updating external links"
cp /var/www/appti2ude/vendor/kalenjordan/jquery-cookie/jquery.cookie.js /var/www/appti2ude/components/