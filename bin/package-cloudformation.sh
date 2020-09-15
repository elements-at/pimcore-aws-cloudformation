#!/bin/bash
#
# Combines nested stacks into a packed template and deploys the change-set in AWS.
# Currently parameters are hardcoded.



BASE_DIR="${HOME}/pimcore-aws-cloudformation" #adjust as you like
echo "==== Package ${BASE_DIR}/pimcoreStack... ===="

read -p "Please name a S3 bucket for packaging the cloudformation templates [cloudformationdeployment]:" packagingBucket
packagingBucket=${packagingBucket:-'cloudformationdeployment'}

aws cloudformation package --template-file ${BASE_DIR}/pimcoreStack.yml \
    --output-template ${BASE_DIR}/packagedPimcoreStack.yml \
    --s3-bucket ${packagingBucket}


read -p "Please enter the stack name for deployment [demo-staging]:" stackName
stackName=${stackName:-'demo-staging'}

# should be enabled later on
#read -p "Please enter the App Name of your stack [pimcore-app]:" AppName
#AppName=${AppName:-'pimcore-app'}
#
#read -p "Please enter the Env of your stack [dev]:" Env
#Env=${Env:-'dev'}


aws cloudformation deploy --template-file ${BASE_DIR}/packagedPimcoreStack.yml \
    --stack-name ${stackName} \
    --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND
    # \
    # should be enabled later on
    #--parameter-overrides AppName=${AppName} Env=${Env}
echo "===="