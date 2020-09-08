# Pimcore AWS Cloudformation Template

### This repository provides a cloudformation template with nested stacks to spin up a complete Pimcore application stack in ECS.

Parts
 - ...
 
 
 ### Questions
 
 How can I deploy the nested stack?
 
 The simplest way is to use the ``AWS-CLI`` tool to package the nested templates and upload them to S3:

Example:
 ```
aws cloudformation package --template-file ${BASE_DIR}/config/cloudformation/pimcoreStack.yml \
     --output-template packagedPimcoreStack.yml \
     --s3-bucket cloudformationdeployment
 ```
 
 Use another command to actually start the deployment:
 ```
aws cloudformation deploy --template-file ${BASE_DIR}/config/cloudformation/packagedPimcoreStack.yml --stack-name car-dev-nextgen --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM CAPABILITY_AUTO_EXPAND
 ```
 
 ---
 
 How can I connect to the Bastion host?
 
 The simplest and most secure way is to use the SSM Agent.
 You can connect directly based on the AWS console, there is no need to establish as SSH connection.
 
 However, if you need to transfer files, such as database files, you can still setup a local connection 
 with the SSM (plugin required), or you temporarily establish a SSH connection.
 
 Sharing Keys:
 On your local machine, execute
 ```
  ssh-keygen 
 ```
 
 Upload ~./ssh/id_rsa.pub to your EC2 server instance using SSM and add the public key to ~/.ssh/authorized_keys.
 Now you can connect from the client.
 
 Example:
 
 ```
 ssh -i id_rsa ssm-user@ec2-3-125-43-205.eu-central-1.compute.amazonaws.com
 ```
 