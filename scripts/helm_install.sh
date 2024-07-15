#!/bin/bash
#
# helm
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh


sudo helm install s3-upload ./s3_upload --set configmap.data.AWS_BUCKET=$1 --set configmap.data.AWS_ACCESS_KEY_ID=$2 --set configmap.data.AWS_SECRET_ACCESS_KEY=$3 --set configmap.data.REGION_NAME=$4
