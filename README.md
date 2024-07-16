# s3-upload
A Terraform and Kubernetes infrastructure on AWS that build a S3 db and single EC2 instance and make it single node cluster. Afterwards we install with a custom helm chart and docker image a simple web app that upload image from your local computer to the S3  


## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Overview of the files](#overview-of-the-files)
* [Preparations](#preparations)
* [Setup](#setup)

## General info
my project create an image upload web app from the web to S3 DB with terraform and AWS.
link to my demo video:
[App Demo](https://www.loom.com/share/48a60e4d13ff4b7ba8512c3b064aff65?sid=c8fc274f-1764-4ebc-bb8e-562c0d6e3fc2)


## Technologies
#### for the app
  * Python (FastApi and boto3 library)
  * HTML
  * CSS
  * Javascript
#### infrastructure
  * Docker
  * HelmChart
  * Terraform
  * BashScript


## Overview of the files
* app file
* modules file
* s3_upload file
* scripts file
* main.tf

## Preparations

## Setup
