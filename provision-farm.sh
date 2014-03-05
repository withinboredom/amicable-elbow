#!/bin/bash

ID=$1
USER=$2
PASSWORD=$3
AUTH=$4:$5
REPO=$6
URL=$7
CLOUD=$8
IMAGE=$9
VMSIZE=${10}
AVAIL=${11}

if [[ $# < 11 ]]
then
    echo "Too few arguments, usage:"
    echo "./provision-farm.sh {server id} {azure server user} {azure server password} {github user} {github password} {github repository} {deployment url} {azure cloud services} {azure image} {vm-size} {availability set}"
    echo
    echo "Example:"
    echo "./provision-farm.sh 2 azureuser mypass withinboredom myotherpass WickedMonkeySoftware/appti2ude http://appti2ude.com appti2ude appti2ude1 extrasmall appti2ude"
    exit 1
fi

azure vm create --connect $CLOUD $IMAGE $USER $PASSWORD --ssh 222$ID --availability-set $AVAIL --vm-size $VMSIZE
azure vm endpoint create $CLOUD-$ID 900$ID 9001
azure vm endpoint create-multiple $CLOUD-$ID 80:80:tcp:false:HTTP:http

echo "Servers are online, initiating deployment system"
DEPLOYMENT=`curl -u $AUTH https://api.github.com/repos/$REPO/hooks | underscore filter "value.config.url is '$URL:900$ID'" --coffee | underscore pluck id | underscore reduce ""`

if [[ -z $DEPLOYMENT ]]
then
    echo "NO deployment found, creating deployment hooks"
    curl -u $AUTH -X POST --data "{\"name\":\"web\", \"config\": {\"url\": \"$URL:900$ID\"}, \"events\": [\"push\"]}" https://api.github.com/repos/$REPO/hooks
else
    echo "hook already created ... nothing to do"
fi