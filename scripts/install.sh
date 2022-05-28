#!/bin/bash
#
#	Installationsscript virtar - Serverless

##########################
# Serverless (Knative) - Installation erfolgt in Juypter
# kubectl apply --filename https://github.com/knative/serving/releases/download/knative-v1.4.0/serving-crds.yaml
# kubectl apply --filename https://github.com/knative/serving/releases/download/knative-v1.4.0/serving-core.yaml

# kubectl apply --filename https://github.com/knative/net-istio/releases/download/v0.15.0/release.yaml
wget https://storage.googleapis.com/knative-nightly/client/latest/kn-linux-amd64 -O kn
chmod 755 kn
sudo mv kn /usr/local/bin/

# Jupyter Scripte etc. Allgemein verfuegbar machen
cp -rpv data/* /data/