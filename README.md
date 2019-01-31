# microgreet
A simple service to demonstrate docker, swarm, ecs, cloudformation

## Pre-reqs
* You will need a docker version compatible with 17.12.1. So any docker version greater or equal to 17.12.1 should work.
* This has been tested on a mac but should work on a linux system as well. For windows the volume mounting and docker.sock locations may be different
* To run the cloudformation you need to use aws cli and need to make sure the credentials are set wither in the ~/.aws/credentials or as env variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY
The docker file is multi-stage. One stage is for testing and the other is to build the final image
### To Test the code before production
```
docker build --target tester -t miladino/hello-django:test .
```
### To build the final image
```
docker build --target builder -t miladino/hello-django:1.3 .
```
### Run the container 
```
docker container run -d -p 80:8000 miladino/hello-django:1.3
```
or 
```
docker stack deploy -c docker-compose.yml myhello
```
You can also use the jenkins image to build and test.
### To run the prod stack
Make sure the aws cli credentials are set.
##### These parameters are required:
- VpcId = the vpc you would like to use 
- SubnetId = the subnet to use (belonging to VpcId)
- ExecutionRoleArn = The execution IAM role for the task. This is needed for cloudwatch log creation

##### These parameters are optional:
- DefaultContainerCpu = Amount of CPU for the containers. default 256
- DefaultContainerMemory = Amount of CPU for the containers. default 512
- DefaultServiceCpuScaleOutThreshold = Average CPU value to trigger auto scaling out. default 50
```
aws cloudformation create-stack --stack-name greetings-stack --capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" --template-body file://cloudformation-prod.json --parameters ParameterKey=VpcId,ParameterValue=vpc-###### \
ParameterKey=SubnetId,ParameterValue=subnet-##### \
ParameterKey=ExecutionRoleArn,ParameterValue='arn:aws:iam::#########:role/ecsTaskExecutionRole'
```
You can also use the aws console to run the cloudformation template
#### Improvements:
- Add nginx infront of service
- create the network with cloudformation (vpc, subnet)
- create a hosted zone on route53 and separate the nginx service from the greeting service