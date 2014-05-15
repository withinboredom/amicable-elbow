#!/bin/bash

#usage deploy.sh USER PASS SERVER PORT GITUSER GITREPO
#                 $1   $2    $3    $4 

#This deploys deployment scripts to the server
sshpass -p $2 scp -v -P $4 -r deploy $1@$3:~/

sshpass -p $2 ssh -p $4 $1@$3 'bash -s' < deploy/provision.sh