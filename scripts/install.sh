#!/bin/bash
#
#	Installationsscript virtar - Serverless

##########################
# Serverless (Knative) CLI - Installation erfolgt in Juypter
wget https://storage.googleapis.com/knative-nightly/client/latest/kn-linux-amd64 -O kn
chmod 755 kn
sudo mv kn /usr/local/bin/

##########################
# Lasttests (hey)
wget https://hey-release.s3.us-east-2.amazonaws.com/hey_linux_amd64 -O hey
chmod 755 hey
sudo mv hey /usr/local/bin/


# Jupyter Scripte etc. Allgemein verfuegbar machen
cp -rpv data/* /data/