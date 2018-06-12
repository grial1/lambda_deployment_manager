#! /bin/bash

# description:  Utility functions for creating a new project in AWS lambda
#               python 2.7 in a virtual enviroment and deploying it.
# author: Gaston Rial

function init_lambda()
{

  # Start virtualenv and chande to that folder
  echo -e "Creating project ${PWD}/${1} ..."
  virtualenv ./${1} && cd $_
  source bin/activate

  # Create template for lambda
  touch lambda_function.py
  echo -e "# Import dependencies\n#import boto3" >> lambda_function.py
  echo -e "\n\ndef lambda_handler(event, context):" >> lambda_function.py
  echo -e "# mind identation" >> lambda_function.py
  
  # Get Boto3
  pip install boto3

  echo -e "\nReady to begin, please open the file lambda_function.py"

}

function deploy_lambda()
{

  echo -e "\nStarting deployment"

  # Put together every file on the deployment package
  mkdir build_sources
  cp lambda_function.py build_sources
  cp -r lib/python*/* build_sources
  cd build_sources && zip -r lambda_function.zip *

  # Deploy to AWS
  aws lambda create-function \
--function-name lambda_function  \
--zip-file fileb://${PWD}/lambda_function.zip \
--role ${1} \
--handler lambda_function.lambda_handler \
--runtime python2.7 \
--timeout 60 \
--memory-size 1024 
  rm -fr build_sources
  echo -e "\nlambda_function.py deployed!\nCheck out AWS"
  
}