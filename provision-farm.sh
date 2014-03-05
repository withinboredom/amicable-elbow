#!/bin/bash

ID=$1
PASSWORD=$2

azure vm create --connect appti2ude appti2ude1 azureuser $PASSWORD --ssh 222$ID --availability-set appti2ude --vm-size extrasmall
azure vm endpoint create appti2ude-$ID 900$ID 9001
azure vm endpoint create-multiple appti2ude-$ID 80:80:tcp:false:HTTP:http
