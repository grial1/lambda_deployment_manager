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
  touch ${1}.py
  echo -e "# Import dependencies\n#import boto3" >> ${1}.py
  echo -e "\n\ndef lambda_handler(event, context):" >> ${1}.py
  echo -e "# mind identation" >> ${1}.py
  
  # Get Boto3
  pip install boto3

  echo -e "\nReady to begin, please open the file ${1}.py"

}

function deploy_lambda()
{

  echo -e "\nStarting deployment"

  # Put together every file on the deployment package
  mkdir build_sources
  cp ${1}.py build_sources
  cp -r lib/python*/site-packages/* build_sources
  cd build_sources && zip -r ${1}.zip *

  # Deploy to AWS
  aws lambda create-function \
--function-name ${1}  \
--zip-file fileb://${PWD}/${1}.zip \
--role ${2} \
--handler rds_function.lambda_handler \
--runtime python2.7 \
--timeout 60 \
--memory-size 1024 
  cd .. && rm -fr build_sources
  echo -e "\n${1}.py deployed!\nCheck out AWS"
  
}