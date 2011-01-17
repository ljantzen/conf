#!/bin/bash
pushd .
cd ~/apps
startopenmq.sh &
gnome-terminal --geometry=80x24+1200+0 -e "mule/bin/mule -config $(cat mule/conf/services_to_start)" 
gnome-terminal --geometry=80x24+0+800 -e "mule/bin/mule-ss -config $(cat mule/conf/ss_services_to_start)" 
gnome-terminal --geometry=80x24+1200+800 -e "jboss/bin/run.sh"
popd
