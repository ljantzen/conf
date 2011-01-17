#!/bin/bash

cd ~/ontopoly/
mvn clean install 
cd ~/ontopia/
./portal-build.sh
cd ~/bk/ontopoly/
ant 
cd ~/bk/omnigator/ 
ant
cd ..
redeploy ontopoly
